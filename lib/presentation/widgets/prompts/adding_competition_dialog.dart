import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/data/requests/leaderboard_api_requests.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/add_compeititon_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/alert_dialog_title.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/datepicker_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// prompt that takes user input
/// it sends a request with the new competition

class AddingCompetitionDialog extends ConsumerStatefulWidget {
  const AddingCompetitionDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<AddingCompetitionDialog> createState() =>
      _AddingCompetitionDialogState();
}

class _AddingCompetitionDialogState
    extends ConsumerState<AddingCompetitionDialog> {
  /// The controller for the date field.
  final TextEditingController dateController = TextEditingController();

  /// The controller for the number of winners field.
  final TextEditingController numberOfWinnersController =
      TextEditingController();

  /// The controller for the prize name field.
  final TextEditingController prizeNameController = TextEditingController();

  /// The controller for the image url field.
  final TextEditingController imgUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? deadline;

  /// Function to build the prize image, when the a vaild URL is entered.
  Widget prizeImageBuilder() {
    return StatefulBuilder(builder: (context, setBuilderState) {
      String imgUrl = imgUrlController.text;
      imgUrlController.addListener(() {
        setBuilderState(() => imgUrl = imgUrlController.text);
      });
      try {
        if (!Uri.parse(imgUrl).isAbsolute) return SizedBox();
      } on FormatException catch (_) {
        return SizedBox();
      }
      return Center(
        child: SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, exception, stackTrace) {
                return Image.asset(
                  ImageAssets.errorImage,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      );
    });
  }

  void _submitCompetition() {
    if (_formKey.currentState!.validate()) {
      final request = AddCompetitionRequest(
        deadline: deadline!,
        numWinners: int.parse(numberOfWinnersController.text),
        prize: prizeNameController.text,
        prizePic: imgUrlController.text,
      );
      ref.read(addCompetitionProvider.notifier).addCompetition(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: ColorManager.transparent,
          body: Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  // color should be provided for the container to capture
                  // taps
                  color: ColorManager.transparent,
                ),
              ),
              GestureDetector(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppRadius.interactionBodyRadius),
                  ),
                  scrollable: true,
                  title: AlertDialogTitle(
                    titleText: Text(LocaleKeys.addingCompetition.tr()),
                  ),
                  titleTextStyle: TextStyleManager.s16w700.copyWith(
                    color: ColorManager.black,
                    fontFamily: FontConstants.tajawal,
                  ),
                  insetPadding: EdgeInsets.all(10.sp),
                  content: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.enterCompetitionFinishingDate.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyleManager.s18w500.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                        SizedBox(height: 5.h, width: 320.w),
                        DatePickerField(
                          setChosenDate: (dateTime) {
                            setState(() => deadline = dateTime);
                          },
                          dateController: dateController,
                          hintText: LocaleKeys.competitionEndDate.tr(),
                          fillColor: ColorManager.backgroundGrey,
                          isMonthDatePicker: false,
                          hasErrorMsg: true,
                          errorMsg: LocaleKeys.competitionEndDateErrorMsg.tr(),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          LocaleKeys.enterNumberOfWinners.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyleManager.s18w500.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TxtField(
                          textController: numberOfWinnersController,
                          hintText: LocaleKeys.winnersNumber.tr(),
                          keyboardType: TextInputType.number,
                          fillColor: ColorManager.backgroundGrey,
                          errorMsg:
                              LocaleKeys.enterNumberOfWinnersErrorMsg.tr(),
                          hasErrorMsg: true,
                          extraValidation: (value) {
                            if (int.tryParse(numberOfWinnersController.text) ==
                                null) {
                              return LocaleKeys
                                  .enterNumberOfWinnersFormatErrorMsg
                                  .tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          LocaleKeys.enterPrizeName.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyleManager.s18w500.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TxtField(
                          textController: prizeNameController,
                          hintText: LocaleKeys.prizeName.tr(),
                          keyboardType: TextInputType.text,
                          fillColor: ColorManager.backgroundGrey,
                          errorMsg: LocaleKeys.AddPrizeNameErrorMsg.tr(),
                          hasErrorMsg: true,
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          LocaleKeys.enterPrizeImageLink.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyleManager.s18w500.copyWith(
                            color: ColorManager.black,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        TxtField(
                          textController: imgUrlController,
                          hintText: LocaleKeys.prizeImageLink.tr(),
                          keyboardType: TextInputType.url,
                          fillColor: ColorManager.backgroundGrey,
                          errorMsg: LocaleKeys.prizeImageUrlErrorMsg.tr(),
                          hasErrorMsg: true,
                        ),
                        SizedBox(height: 14.h),
                        prizeImageBuilder(),
                        SizedBox(height: 14.h),
                        _buildSubmitButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSubmitButton(BuildContext newScaffCtx) {
    return Consumer(builder: ((context, ref, _) {
      ref.addErrorListener(
        provider: addCompetitionProvider,
        context: newScaffCtx,
      );
      ref.listen(addCompetitionProvider, (previous, next) {
        if (next is AddCompetitionLoadedState) Navigator.of(context).pop();
      });
      final state = ref.watch(addCompetitionProvider);
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
          LocaleKeys.addCompetition.tr(),
          style: TextStyleManager.s18w700,
        ),
        icon: icon,
        width: 360.w,
        reverseIcon: false,
        isEnabled: !isLoading,
        onPressed: _submitCompetition,
      );
    }));
  }
}
