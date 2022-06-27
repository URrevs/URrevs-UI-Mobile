import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/data/requests/questions_api_requests.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_question_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_posts_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/add_question_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_phone_manufacturing_company_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/search_results_menu.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../../../state_management/providers_parameters.dart';

class PostingQuestionSubscreen extends ConsumerStatefulWidget {
  const PostingQuestionSubscreen({
    Key? key,
    this.phone,
    this.company,
  }) : super(key: key);

  final Phone? phone;
  final Company? company;

  @override
  ConsumerState<PostingQuestionSubscreen> createState() =>
      _PostingQuestionSubscreenState();
}

class _PostingQuestionSubscreenState
    extends ConsumerState<PostingQuestionSubscreen> {
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.productsAndCompanies);

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController questionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SearchResult? _chosenSearchResult;

  void _search() {
    ref
        .read(searchProvider(_searchProviderParams).notifier)
        .search(productNameController.text);
  }

  void _chooseSearchResult(SearchResult searchResult) {
    productNameController.text = searchResult.name;
    setState(() => _chosenSearchResult = searchResult);
  }

  void _clearChosenSearchResult() {
    setState(() {
      _chosenSearchResult = null;
    });
    ref
        .read(searchProvider(_searchProviderParams).notifier)
        .returnToInitialState();
  }

  void _emptyFields() {
    productNameController.text = '';
    questionController.text = '';
    _clearChosenSearchResult();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.phone != null) {
        _chooseSearchResult(widget.phone!.toSearchResult);
      } else if (widget.company != null) {
        _chooseSearchResult(widget.company!.toSearchResult);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// the screen should be watching the search provider so that it is not
    /// disposed, even if one of the children is watching it, it is disposed of
    /// if this screen doesn't watch it nonetheless.
    ref.watch(searchProvider(_searchProviderParams));
    return SingleChildScrollView(
      padding: AppEdgeInsets.screenPadding.copyWith(bottom: 10.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.yourQuestionRegarding.tr(),
                style: TextStyleManager.s18w500),
            SearchTextField(
              fillColor: ColorManager.textFieldGrey,
              searchProviderParams: _searchProviderParams,
              searchCtl: productNameController,
              hasErrorMsg: true,
              hintText: LocaleKeys.writeTheNameOfProductOrCompany.tr(),
              errorMsg: LocaleKeys.productNameOrCompanyNameErrorMsg.tr(),
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
            Text(LocaleKeys.writeYourQuestion.tr(),
                style: TextStyleManager.s18w500),
            TxtField(
              textController: questionController,
              hintText: LocaleKeys.question.tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              errorMsg: LocaleKeys.enterYourQuestionErrorMsg.tr(),
              hasErrorMsg: true,
            ),
            SizedBox(height: 30.h),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  GradButton _buildSubmitButton() {
    ref.addErrorListener(
      provider: addQuestionProvider,
      context: context,
    );
    ref.listen(addQuestionProvider, (previous, next) {
      if (next is AddQuestionLoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.postedSuccessfully.tr()),
            action: SnackBarAction(
              label: LocaleKeys.seePost.tr(),
              onPressed: () {
                PostType postType = next.question.type == TargetType.phone
                    ? PostType.phoneQuestion
                    : PostType.companyQuestion;
                Navigator.of(context).pushNamed(
                  FullscreenPostScreen.routeName,
                  arguments: FullscreenPostScreenArgs(
                    cardType: postType.cardType,
                    postId: next.question.id,
                    postUserId: next.question.userId,
                    postType: postType,
                  ),
                );
              },
            ),
          ),
        );
        _emptyFields();
      }
    });
    final state = ref.watch(addQuestionProvider);
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
        LocaleKeys.postQuestion.tr(),
        style: TextStyleManager.s18w700,
      ),
      icon: icon,
      width: 360.w,
      reverseIcon: false,
      isEnabled: !isLoading,
      onPressed: _submitQuestion,
    );
  }

  void _submitQuestion() {
    if (_formKey.currentState!.validate()) {
      if (_chosenSearchResult!.targetType == TargetType.phone) {
        AddPhoneQuestionRequest request = AddPhoneQuestionRequest(
          phonetId: _chosenSearchResult!.id,
          content: questionController.text,
        );
        ref.read(addQuestionProvider.notifier).addPhoneQuestion(request);
      } else {
        AddCompanyQuestionRequest request = AddCompanyQuestionRequest(
          companyId: _chosenSearchResult!.id,
          content: questionController.text,
        );
        ref.read(addQuestionProvider.notifier).addCompanyQuestion(request);
      }
    }
  }
}
