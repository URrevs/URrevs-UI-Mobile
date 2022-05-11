import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/comparison_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/search_states/search_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/small_search_list_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../domain/failure.dart';
import '../../resources/enums.dart';
import '../../state_management/providers_parameters.dart';
import '../empty_list_widget.dart';
import '../error_widgets/partial_error_widget.dart';

/// a prompt that navigates to specs compare screen to compare between 2 products

class CompareDialoge extends ConsumerStatefulWidget {
  const CompareDialoge({
    Key? key,
    required this.productId1,
    required this.productName1,
  }) : super(key: key);

  /// The name of the first product.
  final String productName1;
  final String productId1;
  @override
  ConsumerState<CompareDialoge> createState() => _CompareDialogeState();
}

class _CompareDialogeState extends ConsumerState<CompareDialoge> {
  final _formKey = GlobalKey<FormState>();
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.phones);
  final TextEditingController _controller = TextEditingController();

  void _search() {
    ref
        .read(searchProvider(_searchProviderParams).notifier)
        .search(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: '',
      hasTitle: true,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              LocaleKeys.compare.tr() +
                  ' ' +
                  widget.productName1 +
                  ' ' +
                  LocaleKeys.withWord.tr(),
              style: TextStyleManager.s18w500,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            SearchTextField(
              checkChosenSearchResult: false,
              searchCtl: _controller,
              fillColor: ColorManager.backgroundGrey,
              hasErrorMsg: true,
              errorMsg: LocaleKeys.productNameErrorMsg.tr(),
              hintText: LocaleKeys.writeProductName.tr(),
              searchProviderParams: _searchProviderParams,
            ),
            // SizedBox(
            //   height: 70.h,
            // ),
            _buildSearchResults(),
            // GradButton(
            //   text: Text(
            //     LocaleKeys.compare.tr(),
            //     style: TextStyleManager.s18w700,
            //   ),
            //   icon: Icon(
            //     IconsManager.compare,
            //     size: 28.sp,
            //   ),
            //   width: 310.w,
            //   reverseIcon: false,
            //   onPressed: () {
            //     if (_formKey.currentState!.validate()) {
            //       // If the form is valid, display a snackbar. In the real world,
            //       // you'd often call a server or save the information in a database.
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('Processing Data')),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    ref.addErrorListener(
      provider: searchProvider(_searchProviderParams),
      context: context,
    );
    final state = ref.watch(searchProvider(_searchProviderParams));
    if (state is InitialState) {
      return SizedBox();
    } else if (state is LoadingState) {
      return SmallSearchingListLoading();
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
        SizedBox(
          height: 200.h,
          width: 200.w,
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
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(
                        ComparisonScreen.routeName,
                        arguments: ComparisonScreenArgs(
                          firstPhoneId: widget.productId1,
                          secondPhoneId: searchResult.id,
                        ),
                      );
                    },
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
