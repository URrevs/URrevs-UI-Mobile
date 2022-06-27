import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_specs_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_phone_statistical_info_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/phones_states/get_similar_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/rating_overview_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/phone_overview_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/phone_picture_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/phone_specs_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/similar_phones_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/disclaimer_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_table.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/custom_network_image.dart';
import 'dart:math' as math;

class SuggestedItem {
  final String name;
  final String imageUrl;

  SuggestedItem({
    required this.name,
    required this.imageUrl,
  });
}

/// Testing data for similar phones widget.
List<SuggestedItem> suggestedItems = [
  SuggestedItem(
      name: 'Samsung Galaxy A52s',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A32',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A72',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A72sdfsd gasdfgadfgas',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  SuggestedItem(
      name: 'Samsung Galaxy A72',
      imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
];

class ProductProfileSpecsSubscreen extends ConsumerStatefulWidget {
  const ProductProfileSpecsSubscreen({Key? key, required this.phoneId})
      : super(key: key);

  final String phoneId;

  @override
  ConsumerState<ProductProfileSpecsSubscreen> createState() =>
      _ProductProfileSpecsSubscreenState();
}

class _ProductProfileSpecsSubscreenState
    extends ConsumerState<ProductProfileSpecsSubscreen> {
  final GetPhoneSpecsProviderParams _phoneSpecsProviderParams =
      GetPhoneSpecsProviderParams();
  final GetPhoneStatisticalInfoProviderParams _statisticalInfoProviderParams =
      GetPhoneStatisticalInfoProviderParams();
  final GetSimilarPhonesProviderParams _similarPhonesProviderParams =
      GetSimilarPhonesProviderParams();

  void _getPhoneStatisticalInfo() {
    ref
        .read(getPhoneStatisticalInfoProvider(_statisticalInfoProviderParams)
            .notifier)
        .getPhoneStatisticalInfo(widget.phoneId);
  }

  void _getPhoneSpecs() {
    ref
        .read(getPhoneSpecsProvider(_phoneSpecsProviderParams).notifier)
        .getPhoneSpecs(widget.phoneId);
  }

  void _getSimilarPhones() {
    ref
        .read(getSimilarPhonesProvider(_similarPhonesProviderParams).notifier)
        .getSimilarPhones(widget.phoneId);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getPhoneStatisticalInfo();
      _getPhoneSpecs();
      _getSimilarPhones();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getPhoneStatisticalInfoProvider(_statisticalInfoProviderParams),
      context: context,
    );
    ref.addErrorListener(
      provider: getPhoneSpecsProvider(_phoneSpecsProviderParams),
      context: context,
    );
    ref.addErrorListener(
      provider: getSimilarPhonesProvider(_similarPhonesProviderParams),
      context: context,
    );
    final widget = fullScreenErrorWidgetOrNull([
      StateAndRetry(
        state: ref.watch(
            getPhoneStatisticalInfoProvider(_statisticalInfoProviderParams)),
        onRetry: _getPhoneStatisticalInfo,
      ),
      StateAndRetry(
        state: ref.watch(getPhoneSpecsProvider(_phoneSpecsProviderParams)),
        onRetry: _getPhoneSpecs,
      ),
      StateAndRetry(
        state:
            ref.watch(getSimilarPhonesProvider(_similarPhonesProviderParams)),
        onRetry: _getSimilarPhones,
      ),
    ]);
    if (widget != null) return widget;
    return ListView(
      padding: AppEdgeInsets.screenPadding,
      addAutomaticKeepAlives: false,
      cacheExtent: 100,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
          child: _buildRatingOverviewCard(),
        ),
        Text(LocaleKeys.productImage.tr() + ':',
            style: TextStyleManager.s18w700),
        _buildPhonePhoto(),
        SizedBox(height: 12.h),
        Row(
          children: [
            Text(LocaleKeys.specifications.tr() + ':',
                style: TextStyleManager.s18w700),
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
                    return DisclaimerDialog();
                  },
                );
              },
            )
          ],
        ),
        _buildSpecsTable(),
        SizedBox(height: 12.h),
        Text(
          LocaleKeys.similarPhones.tr() + ':',
          style: TextStyleManager.s18w700,
        ),
        Card(
          elevation: AppElevations.ev3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
          ),
          color: ColorManager.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
            child: Container(
              color: ColorManager.white,
              height: 210.h,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: Center(
                  child: _buildSimilarPhonesList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarPhonesList() {
    final state =
        ref.watch(getSimilarPhonesProvider(_similarPhonesProviderParams));
    final widget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: SimilarPhonesLoading(),
    );
    if (widget != null) return widget;
    state as GetSimilarPhonesLoadedState;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: suggestedItems.length,
      itemBuilder: (context, index) {
        final phone = state.phones[index];
        return Padding(
          padding: EdgeInsets.only(top: 20.0, left: 8, right: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProductProfileScreen.routeName,
                arguments: ProductProfileScreenArgs(
                    phoneId: phone.id, phoneName: phone.name),
              );
            },
            child: Column(
              children: [
                SizedBox(
                  width: 85.w,
                  height: 110.h,
                  child: CustomNetworkImage(
                    imageUrl: phone.picture,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: SizedBox(
                    width: 100.w,
                    height: 60.h,
                    child: Text(
                      phone.name,
                      style: TextStyleManager.s16w500,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpecsTable() {
    final widget = loadingOrErrorWidgetOrNull(
      state: ref.watch(getPhoneSpecsProvider(_phoneSpecsProviderParams)),
      loadingWidget: PhoneSpecsLoading(),
    );
    if (widget != null) return widget;
    final state = ref.watch(getPhoneSpecsProvider(_phoneSpecsProviderParams))
        as GetPhoneSpecsLoadedState;
    return SpecsTable(specs: state.specs);
  }

  Widget _buildPhonePhoto() {
    final state = ref.watch(getPhoneSpecsProvider(_phoneSpecsProviderParams));
    final loadingWidget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: PhonePictureLoading(),
    );
    if (loadingWidget != null) return loadingWidget;
    state as GetPhoneSpecsLoadedState;
    return Card(
      elevation: AppElevations.ev3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.postCardRadius),
      ),
      color: ColorManager.white,
      child: Column(
        children: [
          SizedBox(width: double.maxFinite),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: CustomNetworkImage(imageUrl: state.specs.picture),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingOverviewCard() {
    // get phone name from specs provider
    final specsState =
        ref.watch(getPhoneSpecsProvider(_phoneSpecsProviderParams));
    String? productId;
    late String phoneName;
    if (specsState is LoadingState ||
        specsState is InitialState ||
        specsState is ErrorState) {
      phoneName = '';
      productId = null;
    } else {
      specsState as GetPhoneSpecsLoadedState;
      phoneName = specsState.specs.name;
      productId = specsState.specs.id;
    }
    // show rating widget according to statistical info provider
    final state = ref
        .watch(getPhoneStatisticalInfoProvider(_statisticalInfoProviderParams));
    final widget = loadingOrErrorWidgetOrNull(
      state: state,
      loadingWidget: PhoneOverviewLoading(),
    );
    if (widget != null) return widget;
    state as GetPhoneStatisticalInfoLoadedState;
    return RatingOverviewCard(
      productId: productId,
      productName: phoneName,
      owned: state.info.owned,
      generalProductRating: state.info.generalRating.toDouble(),
      generalCompanyRating: state.info.generalRating.toDouble(),
      scores: [
        state.info.uiRating.toInt(),
        state.info.manufacturingQuality.toInt(),
        state.info.valueForMoney.toInt(),
        state.info.camera.toInt(),
        state.info.callQuality.toInt(),
        state.info.battery.toInt(),
      ],
      viewsCounter: state.info.views,
      isProduct: true,
    );
  }
}
