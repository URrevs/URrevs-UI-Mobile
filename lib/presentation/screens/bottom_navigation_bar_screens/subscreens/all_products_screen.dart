import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/companies_states/get_all_companies_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_all_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/all_products_list_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_horizontal_list_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AllProductsSubscreen extends ConsumerStatefulWidget {
  const AllProductsSubscreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AllProductsSubscreen> createState() =>
      _AllProductsSubscreenState();
}

class _AllProductsSubscreenState extends ConsumerState<AllProductsSubscreen> {
  String? _companyId;
  late PagingController<int, Company> _companiesController;
  late PagingController<int, Phone> _phonesController;

  void _getAllCompanies() {
    ref.read(getAllCompaniesProvider.notifier).getAllCompanies();
  }

  void _getPhones() {
    ref.read(getAllPhonesProvider.notifier).getPhones(_companyId);
  }

  @override
  void initState() {
    super.initState();
    _companiesController = PagingController(firstPageKey: 0)
      ..addPageRequestListener((_) {
        Future.delayed(Duration.zero, _getAllCompanies);
      });
    _phonesController = PagingController<int, Phone>(firstPageKey: 0)
      ..addPageRequestListener((pageKey) {
        Future.delayed(Duration.zero, _getPhones);
      });
  }

  @override
  Widget build(BuildContext context) {
    final companiesState = ref.watch(getAllCompaniesProvider);
    final phonesState = ref.watch(getAllPhonesProvider);
    // show fullscreen error widget at 1st round error of companies list
    if (companiesState is GetAllCompaniesErrorState &&
        _companiesController.itemList == null) {
      return FullscreenErrorWidget(
        onRetry: () {
          _getAllCompanies();
          _companiesController.retryLastFailedRequest();
          if (phonesState is ErrorState) {
            _getPhones();
            _phonesController.retryLastFailedRequest();
          }
        },
        retryLastRequest: companiesState.failure is RetryFailure,
      );
    }
    if (phonesState is GetAllPhonesErrorState &&
        _phonesController.itemList == null) {
      return FullscreenErrorWidget(
        onRetry: () {
          _getPhones();
          _phonesController.retryLastFailedRequest();
          if (companiesState is ErrorState) {
            _getAllCompanies();
            _companiesController.retryLastFailedRequest();
          }
        },
        retryLastRequest: phonesState.failure is RetryFailure,
      );
    }
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: CustomScrollView(
        slivers: [
          _buildCompanyList(),
          _buildPhonesList(),
        ],
      ),
    );
  }

  SliverAppBar _buildCompanyList() {
    return SliverAppBar(
      elevation: 3,
      forceElevated: true,
      snap: true,
      floating: true,
      toolbarHeight: 95.h,
      collapsedHeight: 95.h,
      expandedHeight: 95.h,
      backgroundColor: ColorManager.transparent,
      flexibleSpace: CompanyHorizontalListTile(
        controller: _companiesController,
        selectedCompanyId: _companyId,
        setCompanyId: (id) {
          setState(() => _companyId = id);
          _phonesController.refresh();
        },
      ),
    );
  }

  PagedSliverList<int, Phone> _buildPhonesList() {
    ref.addInfiniteScrollingListener(getAllPhonesProvider, _phonesController);
    ref.addErrorListener(
      provider: getAllPhonesProvider,
      context: context,
      controller: _phonesController,
    );
    return PagedSliverList(
      pagingController: _phonesController,
      builderDelegate: PagedChildBuilderDelegate<Phone>(
        itemBuilder: (context, phone, index) {
          return ItemTile(
            title: phone.name,
            subtitle: LocaleKeys.smartphone.tr(),
            imageUrl: phone.companyLogo,
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductProfileScreen.routeName,
                // TODO: pass screen arguments
              );
            },
          );
        },
        firstPageErrorIndicatorBuilder: (context) => SizedBox(),
        newPageErrorIndicatorBuilder: (context) {
          return ref.partialErrorWidget(
            controller: _phonesController,
            provider: getAllPhonesProvider,
            onRetry: () =>
                ref.read(getAllPhonesProvider.notifier).getPhones(_companyId),
          );
        },
        firstPageProgressIndicatorBuilder: (context) =>
            AllProductsListLoading(),
        newPageProgressIndicatorBuilder: (context) => AllProductsListLoading(),
        noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
      ),
    );
  }
}
