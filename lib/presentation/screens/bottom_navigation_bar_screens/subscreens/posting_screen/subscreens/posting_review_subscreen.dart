import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_review_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/owned_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_posts_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/add_phone_review_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_manufacturing_company_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/datepicker_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/company_fields_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/confirmation_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/referral_code_help_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/search_results_menu.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/stars_counter.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'dart:math' as math;

import '../../../../../../domain/failure.dart';
import '../../../../../state_management/providers.dart';
import '../../../../../widgets/empty_widgets/empty_list_widget.dart';
import '../../../../../widgets/loading_widgets/small_search_list_loading.dart';

final productSelectedProvider = StateProvider.autoDispose<bool>((ref) => false);

class PostingReviewSubscreen extends ConsumerStatefulWidget {
  const PostingReviewSubscreen({
    Key? key,
    required this.refCode,
    this.phone,
  }) : super(key: key);

  final String? refCode;
  final Phone? phone;

  @override
  ConsumerState<PostingReviewSubscreen> createState() =>
      _PostingReviewSubscreenState();
}

class _PostingReviewSubscreenState
    extends ConsumerState<PostingReviewSubscreen> {
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.products);
  final GetPhoneManufacturingCompanyProviderParams
      _manufacturingCompanyProviderParams =
      GetPhoneManufacturingCompanyProviderParams();
  final AddPhoneReviewProviderParams _addReviewProviderParams =
      AddPhoneReviewProviderParams();

  final refCodeKey = GlobalKey();

  SearchResult? _chosenSearchResult;

  DateTime? _chosenDate;

  void _setChosenDate(DateTime date) {
    setState(() {
      _chosenDate = date;
    });
  }

  PostingReviewModel postingReviewModel = PostingReviewModel(
    productName: '',
    companyName: 'Xiaomi',
    usedSince: DateTime(DateTime.now().year, DateTime.now().month),
    generalRating: 3,
    manufacturingQuality: 3,
    userInterface: 3,
    priceQuality: 3,
    camera: 3,
    callsQuality: 3,
    battery: 3,
    whatUserLikedAboutProduct: '',
    whatUserHatedAboutProduct: '',
    companyRating: 3,
    whatUserLikedAboutCompany: '',
    whatUserHatedAboutCompany: '',
    invitationCode: '',
  );

  late TextEditingController productNameController;
  late TextEditingController usedSinceController;
  late TextEditingController likedAboutProductController;
  late TextEditingController hatedAboutProductController;
  late TextEditingController likedAboutCompanyController;
  late TextEditingController hatedAboutCompanyController;
  late TextEditingController invitationCodeController;

  List<bool> givePoints = List.generate(11, (_) => false);

  double get _percentage {
    double percentage = givePoints.fold<double>(
        0, (total, giveFlag) => total + (giveFlag ? 0.5 / 11 : 0));
    List<TextEditingController> prosAndConsControllers = [
      likedAboutProductController,
      hatedAboutProductController,
      likedAboutCompanyController,
      hatedAboutCompanyController
    ];
    double prosAndConsPercent = 0;
    for (var controller in prosAndConsControllers) {
      prosAndConsPercent +=
          controller.text.length / AppNumericValues.fullPointsCharsNum;
    }
    percentage += prosAndConsPercent > 0.5 ? 0.5 : prosAndConsPercent;
    return percentage > 1 ? 1 : percentage;
  }

  @override
  void initState() {
    super.initState();
    // show refcode text field if refcode is passed to the screen
    if (widget.refCode != null) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        if (refCodeKey.currentContext != null) {
          Scrollable.ensureVisible(refCodeKey.currentContext!);
        }
      });
    }

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.phone != null) {
        _chooseSearchResult(widget.phone!.toSearchResult);
      }
    });

    productNameController = TextEditingController();
    usedSinceController = TextEditingController()
      ..addListener(() {
        setState(() => givePoints[1] = usedSinceController.text.isNotEmpty);
      });
    likedAboutProductController = TextEditingController()
      ..addListener(() => setState(() {}));
    hatedAboutProductController = TextEditingController()
      ..addListener(() => setState(() {}));
    likedAboutCompanyController = TextEditingController()
      ..addListener(() => setState(() {}));
    hatedAboutCompanyController = TextEditingController()
      ..addListener(() => setState(() {}));
    invitationCodeController = TextEditingController(text: widget.refCode ?? '')
      ..addListener(() {
        setState(
            () => givePoints[10] = invitationCodeController.text.isNotEmpty);
      });
  }

  List<int> ratings = List.generate(8, (index) => 0);
  final List<String> _ratingLabels = [
    LocaleKeys.manufacturingQuality.tr(),
    LocaleKeys.userInterface.tr(),
    LocaleKeys.priceQuality.tr(),
    LocaleKeys.camera.tr(),
    LocaleKeys.callsQuality.tr(),
    LocaleKeys.battery.tr(),
  ];
  int _keyNumber = 0;

  String _phoneRatingErrorMessage = '';
  String _companyRatingErrorMessage = '';

  void _emptyStarsFields() {
    ratings.fillRange(0, 8, 0);
    setState(() => _keyNumber = (_keyNumber + 1) % 2);
  }

  void _emptyFields() {
    productNameController.text = '';
    usedSinceController.text = '';
    _chosenDate = null;
    likedAboutProductController.text = '';
    hatedAboutProductController.text = '';
    likedAboutCompanyController.text = '';
    hatedAboutCompanyController.text = '';
    invitationCodeController.text = '';
    _phoneRatingErrorMessage = '';
    _companyRatingErrorMessage = '';
    givePoints = List.generate(11, (index) => false);
    _clearChosenSearchResult();
    _emptyStarsFields();
  }

  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
  bool star6 = false;
  bool star7 = false;
  bool star8 = false;
  final _formKey = GlobalKey<FormState>();
  bool productSelected = false;
  void onProductNameChanged() {
    if (productNameController.text.isNotEmpty) {
      if (!productSelected) {
        setState(() {
          productSelected = true;
        });
      }
    } else {
      if (productSelected) {
        setState(() {
          productSelected = false;
        });
      }
    }
  }

  void _search() {
    ref
        .read(searchProvider(_searchProviderParams).notifier)
        .search(productNameController.text);
  }

  void _chooseSearchResult(SearchResult searchResult) {
    productNameController.text = searchResult.name;
    setState(() {
      _chosenSearchResult = searchResult;
      givePoints[0] = true;
    });
    ref
        .read(getPhoneManufacturingCompanyProvider(
                _manufacturingCompanyProviderParams)
            .notifier)
        .getPhoneManufacturingCompany(searchResult.id);
  }

  void _clearChosenSearchResult() {
    setState(() {
      _chosenSearchResult = null;
    });
    ref
        .read(getPhoneManufacturingCompanyProvider(
                _manufacturingCompanyProviderParams)
            .notifier)
        .returnToInitialState();
    ref
        .read(searchProvider(_searchProviderParams).notifier)
        .returnToInitialState();
  }

  SliverAppBar _buildStarsCounterBar() {
    return SliverAppBar(
      elevation: 1,
      automaticallyImplyLeading: false,
      forceElevated: true,
      pinned: true,
      // snap: true,
      // floating: true,
      toolbarHeight: 50.h,
      collapsedHeight: 50.h,
      expandedHeight: 50.h,
      backgroundColor: ColorManager.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(color: ColorManager.backgroundGrey),
        child: StarsCounter(percentage: _percentage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(searchProvider(_searchProviderParams), (previous, next) {
      if (next is SearchInitialState) {
        setState(() => givePoints[0] = false);
      }
    });
    return Form(
      key: _formKey,
      child: CustomScrollView(
        slivers: [
          if (_percentage > 0) _buildStarsCounterBar(),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: AppEdgeInsets.screenPadding.copyWith(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.chooseProduct.tr() + ':',
                    style: TextStyleManager.s18w500.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  SearchTextField(
                    fillColor: ColorManager.textFieldGrey,
                    searchCtl: productNameController,
                    hasErrorMsg: true,
                    hintText: LocaleKeys.writeProductName.tr(),
                    errorMsg: LocaleKeys.productNameErrorMsg.tr(),
                    searchProviderParams: _searchProviderParams,
                    readOnly: _chosenSearchResult != null,
                    onClear: _clearChosenSearchResult,
                    checkChosenSearchResult: true,
                    chosenSearchResult: _chosenSearchResult,
                  ),
                  SearchResultsMenu(
                    searchProviderParams: _searchProviderParams,
                    hideResults: _chosenSearchResult != null,
                    onRetrySearch: _search,
                    chooseSearchResult: _chooseSearchResult,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    LocaleKeys.howLongHaveYouOwnedThisProduct.tr(),
                    style: TextStyleManager.s18w500.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  DatePickerField(
                    key: ValueKey('date-$_keyNumber'),
                    dateController: usedSinceController,
                    hintText: LocaleKeys.purchaseDate.tr(),
                    fillColor: ColorManager.textFieldGrey,
                    isMonthDatePicker: true,
                    hasErrorMsg: true,
                    errorMsg: LocaleKeys.purchaseDateErrorMsg.tr(),
                    setChosenDate: _setChosenDate,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    LocaleKeys.rateOverallExpericence.tr(),
                    style: TextStyleManager.s18w500.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // general rating bar
                      CustomRatingBar(
                        key: ValueKey<String>('star-0-$_keyNumber'),
                        onRatingUpdate: (rating) {
                          setState(() => givePoints[2] = true);
                          ratings[0] = rating.toInt();
                        },
                      ),
                      SizedBox(height: 5.h),
                      for (int i = 0; i < _ratingLabels.length; i++)
                        RatingEntry(
                          key: ValueKey<String>('star-${i + 1}-$_keyNumber'),
                          title: _ratingLabels[i],
                          onRatingUpdate: (rating) {
                            ratings[i + 1] = rating.toInt();
                            setState(() => givePoints[i + 3] = true);
                          },
                        ),
                      5.verticalSpace,
                      Text(
                        _phoneRatingErrorMessage,
                        style: TextStyleManager.s13w400.copyWith(
                          color: ColorManager.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // what do you like about this product
                  Text(
                    LocaleKeys.whatDoYouLikeAboutThisProduct.tr(),
                    style: TextStyleManager.s18w500.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  TxtField(
                    textController: likedAboutProductController,
                    hintText: LocaleKeys.pros.tr(),
                    keyboardType: TextInputType.multiline,
                    fillColor: ColorManager.textFieldGrey,
                    errorMsg: LocaleKeys.likedAboutProductErrorMsg.tr(),
                    hasErrorMsg: true,
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: 20.h),
                  // what do you hate about this product
                  Text(
                    LocaleKeys.whatDoYouHateAboutThisProduct.tr(),
                    style: TextStyleManager.s18w500.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  TxtField(
                    textController: hatedAboutProductController,
                    hintText: LocaleKeys.cons.tr(),
                    keyboardType: TextInputType.multiline,
                    fillColor: ColorManager.textFieldGrey,
                    errorMsg: LocaleKeys.hateAboutProductErrorMsg.tr(),
                    hasErrorMsg: true,
                    textInputAction: TextInputAction.newline,
                  ),
                  SizedBox(height: 40.h),
                  _buildCompanyFields(),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.enterInvitationCode.tr() + ':',
                        style: TextStyleManager.s18w500.copyWith(
                          color: ColorManager.black,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          IconsManager.help,
                          size: 30.sp,
                        ),
                        color: ColorManager.blue,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ReferralCodeHelpDialog();
                            },
                          );
                        },
                      )
                    ],
                  ),
                  Align(
                    alignment: context.isArabic
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        width: 140.w,
                        child: TxtField(
                          key: refCodeKey,
                          textController: invitationCodeController,
                          hintText: LocaleKeys.invitationCode.tr(),
                          keyboardType: TextInputType.text,
                          fillColor: ColorManager.textFieldGrey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GradButton _buildSubmitButton() {
    ref.addErrorListener(
      provider: addPhoneReviewProvider(_addReviewProviderParams),
      context: context,
    );
    ref.listen(addPhoneReviewProvider(_addReviewProviderParams),
        (previous, next) {
      if (next is AddPhoneReviewLoadedState) {
        String message =
            '${LocaleKeys.postedSuccessfully.tr()}. ${LocaleKeys.youHaveEarned.tr()} ${next.earnedPoints} ${LocaleKeys.point.tr()}';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            action: SnackBarAction(
              label: LocaleKeys.seePost.tr(),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  FullscreenPostScreen.routeName,
                  arguments: FullscreenPostScreenArgs(
                    cardType: CardType.productReview,
                    postId: next.phoneReview.id,
                    postUserId: next.phoneReview.userId,
                    postType: PostType.phoneReview,
                  ),
                );
              },
            ),
          ),
        );
        if (next.phoneReview.verificationRatio == 0) {
          message = LocaleKeys
              .youShouldVerifyYourOwnProductsByOpeningThePlatformThroughThePhoneYouWantToVerify
              .tr();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              action: SnackBarAction(
                label: LocaleKeys.seePost.tr(),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    OwnedProductsScreen.routeName,
                    arguments: OwnedProductsScreenArgs(userId: null),
                  );
                },
              ),
            ),
          );
        }
        _emptyFields();
      }
    });
    final state = ref.watch(addPhoneReviewProvider(_addReviewProviderParams));
    late Widget icon;
    late bool isLoading;
    if (state is LoadingState) {
      isLoading = true;
      icon = Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Center(
          child: SizedBox(
            height: 16.sp,
            width: 16.sp,
            child: CircularProgressIndicator(
              color: ColorManager.white,
              strokeWidth: 3,
            ),
          ),
        ),
      );
    } else {
      icon = Icon(IconsManager.add, size: 28.sp);
      isLoading = false;
    }
    return GradButton(
      text: Text(
        LocaleKeys.postReview.tr(),
        style: TextStyleManager.s18w700,
      ),
      icon: icon,
      width: 360.w,
      reverseIcon: false,
      isEnabled: !isLoading,
      onPressed: _submitReview,
    );
  }

  void _submitReview() {
    _formKey.currentState!.validate();
    bool isError = false;
    final starError = LocaleKeys.starRatingMissingField.tr();
    for (int i = 0; i < ratings.length; i++) {
      if (ratings[i] == 0) {
        isError = true;
        if (i <= 6) {
          setState(() => _phoneRatingErrorMessage = starError);
        } else {
          setState(() => _companyRatingErrorMessage = starError);
        }
      }
    }
    if (isError) return;
    if (_formKey.currentState!.validate()) {
      String? refCode = invitationCodeController.text;
      if (refCode.isEmpty) refCode = null;

      final companyState = ref.watch(getPhoneManufacturingCompanyProvider(
              _manufacturingCompanyProviderParams))
          as GetPhoneManufacturingCompanyLoadedState;

      AddPhoneReviewRequest request = AddPhoneReviewRequest(
        phoneId: _chosenSearchResult!.id,
        companyId: companyState.company.id,
        ownedDate: _chosenDate!,
        generalRating: ratings[0],
        uiRating: ratings[1],
        manQuality: ratings[2],
        valFMon: ratings[3],
        camera: ratings[4],
        callQuality: ratings[5],
        battery: ratings[6],
        pros: likedAboutProductController.text,
        cons: hatedAboutProductController.text,
        refCode: refCode,
        companyRating: ratings[7],
        compPros: likedAboutCompanyController.text,
        compCons: hatedAboutCompanyController.text,
      );
      ref
          .read(addPhoneReviewProvider(_addReviewProviderParams).notifier)
          .addPhoneReview(request);
    }
  }

  Widget _buildCompanyFields() {
    final state = ref.watch(getPhoneManufacturingCompanyProvider(
        _manufacturingCompanyProviderParams));
    ref.listen(
        getPhoneManufacturingCompanyProvider(
            _manufacturingCompanyProviderParams), (previous, next) {
      if (next is ErrorState) {
        showSnackBarWithoutActionAtError(state: state, context: context);
        setState(() => _chosenSearchResult = null);
        ref
            .read(searchProvider(_searchProviderParams).notifier)
            .returnToInitialState();
      }
    });
    if (state is InitialState || state is ErrorState) {
      return SizedBox();
    } else if (state is LoadingState) {
      return CompanyFieldsLoading();
    }
    Company company =
        (state as GetPhoneManufacturingCompanyLoadedState).company;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // rate the manufacturer
        Text(
          LocaleKeys.howDoYouRateTheManufacturer.tr(),
          style: TextStyleManager.s18w500.copyWith(
            color: ColorManager.black,
          ),
        ),
        Center(
          child: Column(
            children: [
              CustomRatingBar(
                key: ValueKey<String>('star-7-$_keyNumber'),
                onRatingUpdate: (rating) {
                  ratings[7] = rating.toInt();
                  setState(() => givePoints[9] = true);
                },
              ),
              5.verticalSpace,
              Text(
                _companyRatingErrorMessage,
                style: TextStyleManager.s13w400.copyWith(
                  color: ColorManager.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        // what do you like about the manufacturer
        Text(
          LocaleKeys.WhatDoYouLikeAbout.tr() + ' ' + company.name,
          style: TextStyleManager.s18w500.copyWith(
            color: ColorManager.black,
          ),
        ),
        TxtField(
          textController: likedAboutCompanyController,
          hintText: LocaleKeys.pros.tr(),
          keyboardType: TextInputType.multiline,
          fillColor: ColorManager.textFieldGrey,
          errorMsg: LocaleKeys.likedAboutManufacturerErrorMsg.tr(),
          hasErrorMsg: true,
          textInputAction: TextInputAction.newline,
        ),
        SizedBox(height: 20.h),
        // what do you hate about the manufacturer
        Text(
          LocaleKeys.whatDoYouHateAbout.tr() + ' ' + company.name,
          style: TextStyleManager.s18w500.copyWith(
            color: ColorManager.black,
          ),
        ),
        TxtField(
          textController: hatedAboutCompanyController,
          hintText: LocaleKeys.cons.tr(),
          keyboardType: TextInputType.multiline,
          fillColor: ColorManager.textFieldGrey,
          errorMsg: LocaleKeys.hatedAboutManufacturerErrorMsg.tr(),
          hasErrorMsg: true,
          textInputAction: TextInputAction.newline,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class RatingEntry extends StatelessWidget {
  const RatingEntry({
    required this.title,
    required this.onRatingUpdate,
    Key? key,
  }) : super(key: key);

  final String title;
  final Function(double) onRatingUpdate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: SizedBox(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  title + ':',
                  style: TextStyleManager.s18w500.copyWith(
                    color: ColorManager.black,
                  ),
                ),
              ),
              CustomRatingBar(onRatingUpdate: onRatingUpdate),
            ]),
      ),
    );
  }
}

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    required this.onRatingUpdate,
    Key? key,
  }) : super(key: key);

  final Function(double) onRatingUpdate;
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      itemSize: 35.sp,
      initialRating: 0,
      minRating: 1,
      glowRadius: 2,
      tapOnlyMode: true,
      glow: false,
      unratedColor: ColorManager.grey,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
      ratingWidget: RatingWidget(
        full: Icon(
          IconsManager.star,
          color: ColorManager.blue,
          size: 30.sp,
        ),
        half: Icon(
          IconsManager.starOutlined,
          color: ColorManager.black,
          size: 30.sp,
        ),
        empty: Icon(
          IconsManager.starOutlined,
          color: ColorManager.black,
          size: 30.sp,
        ),
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
