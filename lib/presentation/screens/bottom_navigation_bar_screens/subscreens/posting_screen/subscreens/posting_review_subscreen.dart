import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_review_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_reviews_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
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
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/suggested_searches_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/referral_code_help_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'dart:math' as math;

import '../../../../../../domain/failure.dart';
import '../../../../../state_management/providers.dart';
import '../../../../../widgets/empty_list_widget.dart';

final productSelectedProvider = StateProvider.autoDispose<bool>((ref) => false);

class PostingReviewSubscreen extends ConsumerStatefulWidget {
  const PostingReviewSubscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PostingReviewSubscreen> createState() =>
      _PostingReviewSubscreenState();
}

class _PostingReviewSubscreenState
    extends ConsumerState<PostingReviewSubscreen> {
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.phones);
  final GetPhoneManufacturingCompanyProviderParams
      _manufacturingCompanyProviderParams =
      GetPhoneManufacturingCompanyProviderParams();
  final AddPhoneReviewProviderParams _addReviewProviderParams =
      AddPhoneReviewProviderParams();

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

  @override
  void initState() {
    super.initState();
    productNameController =
        TextEditingController(text: postingReviewModel.productName);
    // NOTE: I am not sure about this controller.
    usedSinceController = TextEditingController(text: '');
    likedAboutProductController = TextEditingController(
        text: postingReviewModel.whatUserLikedAboutProduct);
    hatedAboutProductController = TextEditingController(
        text: postingReviewModel.whatUserHatedAboutProduct);
    likedAboutCompanyController = TextEditingController(
        text: postingReviewModel.whatUserLikedAboutCompany);
    hatedAboutCompanyController = TextEditingController(
        text: postingReviewModel.whatUserHatedAboutCompany);
    invitationCodeController =
        TextEditingController(text: postingReviewModel.invitationCode);
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
    setState(() => _chosenSearchResult = searchResult);
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
  }

  Widget _buildSearchResults() {
    ref.addErrorListener(
      provider: searchProvider(_searchProviderParams),
      context: context,
    );
    if (_chosenSearchResult != null) {
      return SizedBox();
    }
    final state = ref.watch(searchProvider(_searchProviderParams));
    if (state is InitialState) {
      return SizedBox();
    } else if (state is LoadingState) {
      return SuggestedSearchesLoading();
    } else if (state is SearchErrorState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          PartialErrorWidget(
            onRetry: _search,
            retryLastRequest: state.failure is RetryFailure,
          ),
        ],
      );
    }
    state as SearchLoadedState;
    if (state.searchResults.isEmpty) {
      return EmptyListWidget();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Container(
          decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(
              //     color: ColorManager.grey,
              //     blurRadius: 0.1,
              //   ),
              //   BoxShadow(
              //     color: ColorManager.backgroundGrey,
              //     spreadRadius: -1,
              //     blurRadius: 8.0,
              //     offset: Offset(10, 0),
              //   ),
              //   BoxShadow(
              //     color: ColorManager.backgroundGrey,
              //     spreadRadius: -1,
              //     blurRadius: 8.0,
              //     offset: Offset(-10, 0),
              //   ),
              // ],
              ),
          child: ScrollConfiguration(
            behavior: NoGlowingScrollBehaviour(),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                for (var searchResult in state.searchResults)
                  ListTile(
                    title: Text(
                      searchResult.name,
                      style: TextStyleManager.s16w400.copyWith(
                        color: ColorManager.black,
                      ),
                    ),
                    onTap: () => _chooseSearchResult(searchResult),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //bool productSelected = ref.watch(productSelectedProvider);
    return SingleChildScrollView(
      padding: AppEdgeInsets.screenPadding.copyWith(bottom: 10.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.chooseProduct.tr() + ':',
                style: TextStyleManager.s18w500),
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
            _buildSearchResults(),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.howLongHaveYouOwnedThisProduct.tr(),
              style: TextStyleManager.s18w500,
            ),
            DatePickerField(
              dateController: usedSinceController,
              hintText: LocaleKeys.purchaseDate.tr(),
              fillColor: ColorManager.textFieldGrey,
              isMonthDatePicker: true,
              hasErrorMsg: true,
              errorMsg: LocaleKeys.purchaseDateErrorMsg.tr(),
              setChosenDate: _setChosenDate,
            ),
            SizedBox(height: 20.h),
            Text(LocaleKeys.rateOverallExpericence.tr(),
                style: TextStyleManager.s18w500),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // general rating bar
                CustomRatingBar(
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star1) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star1 = true;
                      postingReviewModel.generalRating = rating.toInt();
                    }
                  },
                ),
                SizedBox(height: 5.h),
                // manufacturing quality bar
                RatingEntry(
                  title: LocaleKeys.manufacturingQuality.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star2) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star2 = true;
                      postingReviewModel.manufacturingQuality = rating.toInt();
                    }
                  },
                ),
                // user interface bar
                RatingEntry(
                  title: LocaleKeys.userInterface.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star3) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star3 = true;
                      postingReviewModel.userInterface = rating.toInt();
                    }
                  },
                ),
                // price quality bar
                RatingEntry(
                  title: LocaleKeys.priceQuality.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star4) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star4 = true;
                      postingReviewModel.priceQuality = rating.toInt();
                    }
                  },
                ),
                // camera bar
                RatingEntry(
                  title: LocaleKeys.camera.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star5) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star5 = true;
                      postingReviewModel.camera = rating.toInt();
                    }
                  },
                ),
                // calls quality bar
                RatingEntry(
                  title: LocaleKeys.callsQuality.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star6) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star6 = true;
                      postingReviewModel.callsQuality = rating.toInt();
                    }
                  },
                ),
                // battery bar
                RatingEntry(
                  title: LocaleKeys.battery.tr(),
                  onRatingUpdate: (rating) {
                    FocusScope.of(context).unfocus();
                    if (!star7) {
                      setState(() {
                        //starsPoints++;
                      });
                    }
                    if (rating != 0) {
                      star7 = true;
                      postingReviewModel.battery = rating.toInt();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // what do you like about this product
            Text(LocaleKeys.whatDoYouLikeAboutThisProduct.tr(),
                style: TextStyleManager.s18w500),
            TxtField(
              textController: likedAboutProductController,
              hintText: LocaleKeys.pros.tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              errorMsg: LocaleKeys.likedAboutProductErrorMsg.tr(),
              hasErrorMsg: true,
            ),
            SizedBox(height: 20.h),
            // what do you hate about this product
            Text(LocaleKeys.whatDoYouHateAboutThisProduct.tr(),
                style: TextStyleManager.s18w500),
            TxtField(
              textController: hatedAboutProductController,
              hintText: LocaleKeys.cons.tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              errorMsg: LocaleKeys.hateAboutProductErrorMsg.tr(),
              hasErrorMsg: true,
            ),
            SizedBox(height: 40.h),
            _buildCompanyFields(),
            Row(
              children: [
                Text(LocaleKeys.enterInvitationCode.tr() + ':',
                    style: TextStyleManager.s18w500),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: context.isArabic
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Icon(
                            IconsManager.help,
                            size: 30.sp,
                          ),
                        )
                      : Icon(
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
    );
  }

  GradButton _buildSubmitButton() {
    ref.listen(addPhoneReviewProvider(_addReviewProviderParams),
        (previous, next) {
      if (next is LoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم النشر بنجاح'),
            margin: EdgeInsets.fromLTRB(15.w, 5.h, 15.w, 10.h + 50.h),
            action: SnackBarAction(
              label: 'رؤية المنشور',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  PostedReviewsScreen.routeName,
                  arguments: PostedReviewsScreenArgs(userId: null),
                );
              },
            ),
          ),
        );
      }
    });
    final state = ref.watch(addPhoneReviewProvider(_addReviewProviderParams));
    late Widget icon;
    if (state is LoadingState) {
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
    }
    return GradButton(
        text: Text(
          LocaleKeys.postReview.tr(),
          style: TextStyleManager.s18w700,
        ),
        icon: icon,
        width: 360.w,
        reverseIcon: false,
        onPressed: () {
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
              generalRating: postingReviewModel.generalRating,
              uiRating: postingReviewModel.userInterface,
              manQuality: postingReviewModel.manufacturingQuality,
              valFMon: postingReviewModel.priceQuality,
              camera: postingReviewModel.camera,
              callQuality: postingReviewModel.callsQuality,
              battery: postingReviewModel.battery,
              pros: likedAboutProductController.text,
              cons: hatedAboutProductController.text,
              ref: refCode,
              companyRating: postingReviewModel.companyRating,
              compPros: likedAboutCompanyController.text,
              compCons: hatedAboutCompanyController.text,
            );
            ref
                .read(addPhoneReviewProvider(_addReviewProviderParams).notifier)
                .addPhoneReview(request);
          }
        });
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
        Text(LocaleKeys.howDoYouRateTheManufacturer.tr(),
            style: TextStyleManager.s18w500),
        Center(
          child: CustomRatingBar(
            onRatingUpdate: (rating) {
              FocusScope.of(context).unfocus();
              if (!star8) {
                setState(() {
                  //starsPoints++;
                });
              }
              if (rating != 0) {
                star8 = true;
                postingReviewModel.companyRating = rating.toInt();
              }
            },
          ),
        ),
        SizedBox(height: 20.h),
        // what do you like about the manufacturer
        Text(LocaleKeys.WhatDoYouLikeAbout.tr() + ' ' + company.name,
            style: TextStyleManager.s18w500),
        TxtField(
          textController: likedAboutCompanyController,
          hintText: LocaleKeys.pros.tr(),
          keyboardType: TextInputType.text,
          fillColor: ColorManager.textFieldGrey,
          errorMsg: LocaleKeys.likedAboutManufacturerErrorMsg.tr(),
          hasErrorMsg: true,
        ),
        SizedBox(height: 20.h),
        // what do you hate about the manufacturer
        Text(LocaleKeys.whatDoYouHateAbout.tr() + ' ' + company.name,
            style: TextStyleManager.s18w500),
        TxtField(
          textController: hatedAboutCompanyController,
          hintText: LocaleKeys.cons.tr(),
          keyboardType: TextInputType.text,
          fillColor: ColorManager.textFieldGrey,
          errorMsg: LocaleKeys.hatedAboutManufacturerErrorMsg.tr(),
          hasErrorMsg: true,
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
                  style: TextStyleManager.s18w500,
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
