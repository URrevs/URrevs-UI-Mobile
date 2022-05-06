import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_two_phones_specs_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/comparison_table_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_comparison_table.dart';

import '../../translations/locale_keys.g.dart';

class ComparisonScreenArgs {
  String firstPhoneId;
  String secondPhoneId;
  ComparisonScreenArgs({
    required this.firstPhoneId,
    required this.secondPhoneId,
  });

  static ComparisonScreenArgs get defaultArgs => ComparisonScreenArgs(
        firstPhoneId: '6256a75b5f87fa90093a4bd6', // Acer M900
        secondPhoneId: '6256a7835f87fa90093a4be8', // Acer Liquid E
      );
}

class ComparisonScreen extends ConsumerStatefulWidget {
  const ComparisonScreen(this.screenArgs, {Key? key}) : super(key: key);

  final ComparisonScreenArgs screenArgs;

  static const String routeName = 'ComparisonScreen';

  @override
  ConsumerState<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends ConsumerState<ComparisonScreen> {
  void _getTwoPhonesSpecs() {
    ref.read(getTwoPhonesSpecsProvider.notifier).getTwoPhonesSpecs(
          widget.screenArgs.firstPhoneId,
          widget.screenArgs.secondPhoneId,
        );
  }

  @override
  void initState() {
    super.initState();
    _getTwoPhonesSpecs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.comparison.tr(),
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    ref.addErrorListener(provider: getTwoPhonesSpecsProvider, context: context);
    final state = ref.watch(getTwoPhonesSpecsProvider);
    if (state is InitialState || state is LoadingState) {
      return ComparisonTableLoading();
    } else if (state is ErrorState) {
      return FullscreenErrorWidget(
        onRetry: _getTwoPhonesSpecs,
        retryLastRequest: (state as ErrorState).failure is RetryFailure,
      );
    }
    state as GetTwoPhonesSpecsLoadedState;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: SpecsComparisonTable(
        firstProductName: state.firstPhoneSpecs.name,
        secondProductName: state.secondPhoneSpecs.name,
        firstProductImageUrl: state.firstPhoneSpecs.picture,
        secondProductImageIrl: state.secondPhoneSpecs.picture,
        firstProductSpecs: state.firstPhoneSpecs,
        secondProductSpecs: state.firstPhoneSpecs,
      ),
    );
  }
}
