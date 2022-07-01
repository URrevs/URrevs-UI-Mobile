import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/report_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/vertical_list_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/report_cards_list_loading.dart';

class ReportsList extends ConsumerStatefulWidget {
  const ReportsList({
    Key? key,
    required this.reportStatus,
  }) : super(key: key);

  final ReportStatus reportStatus;

  @override
  ConsumerState<ReportsList> createState() => _ReportsListState();
}

class _ReportsListState extends ConsumerState<ReportsList> {
  late final PagingController<int, Report> _controller =
      PagingController(firstPageKey: 0)
        ..addPageRequestListener((_) {
          Future.delayed(Duration.zero, _getReports);
        });

  late final _getReportsProviderParams =
      GetReportsProviderParams(reportStatus: widget.reportStatus);

  void _getReports() {
    _controller.retryLastFailedRequest();
    ref
        .read(getReportsProvider(_getReportsProviderParams).notifier)
        .getReports();
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getReportsProvider(_getReportsProviderParams),
      context: context,
      controller: _controller,
    );
    ref.addInfiniteScrollingListener(
      getReportsProvider(_getReportsProviderParams),
      _controller,
    );
    Widget? errWidget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(getReportsProvider(_getReportsProviderParams)),
        onRetry: _getReports,
        controller: _controller,
      ),
    ]);
    if (errWidget != null) return errWidget;
    return Padding(
      padding: AppEdgeInsets.screenWithoutFabPadding,
      child: PagedListView(
        pagingController: _controller,
        builderDelegate: PagedChildBuilderDelegate<Report>(
          itemBuilder: (context, report, index) => ReportCard(
            report: report,
            reportStatus: widget.reportStatus,
          ),
          firstPageErrorIndicatorBuilder: (context) => SizedBox(),
          newPageErrorIndicatorBuilder: (context) {
            final state =
                ref.watch(getReportsProvider(_getReportsProviderParams));
            if (state is ErrorState) {
              return VerticalListErrorWidget(
                onRetry: _getReports,
                retryLastRequest: (state as ErrorState).failure is RetryFailure,
              );
            } else {
              return SizedBox();
            }
          },
          firstPageProgressIndicatorBuilder: (context) =>
              ReportCardsListLoading(),
          newPageProgressIndicatorBuilder: (context) =>
              ReportCardsListLoading(),
          noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
        ),
      ),
    );
  }
}
