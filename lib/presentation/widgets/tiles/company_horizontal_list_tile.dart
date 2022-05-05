import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_all_companies_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/horizontal_list_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/horizontal_companies_list_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_logo_tile.dart';

class CompanyHorizontalListTile extends ConsumerStatefulWidget {
  const CompanyHorizontalListTile({
    required this.controller,
    required this.selectedCompanyId,
    required this.setCompanyId,
    Key? key,
  }) : super(key: key);

  final PagingController<int, Company> controller;
  final String? selectedCompanyId;
  final ValueChanged<String?> setCompanyId;

  @override
  ConsumerState<CompanyHorizontalListTile> createState() =>
      _CompanyHorizontalListTileState();
}

class _CompanyHorizontalListTileState
    extends ConsumerState<CompanyHorizontalListTile> {
  void _setSelectedCompany(Company company) {
    if (widget.selectedCompanyId == company.id) {
      widget.setCompanyId(null);
    } else {
      widget.setCompanyId(company.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.addInfiniteScrollingListener(
      getAllCompaniesProvider,
      widget.controller,
    );
    // show snackbar only at first round error
    ref.addErrorListener(
      provider: getAllCompaniesProvider,
      context: context,
      controller: widget.controller,
    );

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10.r),
        bottomRight: Radius.circular(10.r),
      ),
      child: Container(
        decoration: BoxDecoration(color: ColorManager.white),
        height: 95.h,
        child: ScrollConfiguration(
          behavior: NoGlowingScrollBehaviour(),
          child: PagedListView(
            pagingController: widget.controller,
            scrollDirection: Axis.horizontal,
            builderDelegate: PagedChildBuilderDelegate<Company>(
              itemBuilder: (context, company, index) {
                return GestureDetector(
                  onTap: () => _setSelectedCompany(company),
                  child: CompanyLogoTile(
                    companyName: company.name,
                    imageUrl: company.logo,
                    isSelected: company.id == widget.selectedCompanyId,
                  ),
                );
              },
              firstPageErrorIndicatorBuilder: (context) => SizedBox(),
              newPageErrorIndicatorBuilder: (context) {
                final state = ref.watch(getAllCompaniesProvider);
                if (state is GetAllCompaniesErrorState) {
                  return HorizontalListErrorWidget(
                    onRetry: () {
                      ref
                          .read(getAllCompaniesProvider.notifier)
                          .getAllCompanies();
                      widget.controller.retryLastFailedRequest();
                    },
                    retryLastRequest: state.failure is RetryFailure,
                  );
                } else {
                  return SizedBox();
                }
              },
              noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
              noMoreItemsIndicatorBuilder: null,
              firstPageProgressIndicatorBuilder: (context) =>
                  HorizontalCompaniesListLoading(),
              newPageProgressIndicatorBuilder: (context) =>
                  HorizontalCompaniesListLoading(),
            ),
          ),
        ),
      ),
    );
  }
}
