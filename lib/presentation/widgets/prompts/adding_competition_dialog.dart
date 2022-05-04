import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/datepicker_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// prompt that takes user input
/// it sends a request with the new competition

class AddingCompetitionPrompt extends StatefulWidget {
  const AddingCompetitionPrompt({
    Key? key,
    required this.dateController,
    required this.numberOfWinnersController,
    required this.prizeNameController,
    required this.imgUrlController,
  }) : super(key: key);

  /// The controller for the date field.
  final TextEditingController dateController;

  /// The controller for the number of winners field.
  final TextEditingController numberOfWinnersController;

  /// The controller for the prize name field.
  final TextEditingController prizeNameController;

  /// The controller for the image url field.
  final TextEditingController imgUrlController;

  @override
  State<AddingCompetitionPrompt> createState() =>
      _AddingCompetitionPromptState();
}

class _AddingCompetitionPromptState extends State<AddingCompetitionPrompt> {
  
  /// Function to build the prize image, when the a vaild URL is entered.
  Widget prizeImageBuilder() {
    String imgUrl = widget.imgUrlController.text;
    // print(Uri.parse(imgUrl).isAbsolute);
    setState(() {
      imgUrl = widget.imgUrlController.text;
    });
    return Uri.parse(imgUrl).isAbsolute
        ? Center(
            child: SizedBox(
              width: 120.w,
              height: 120.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(
                      ImageAssets.errorImage,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          )
        : SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.interactionBodyRadius),
      ),
      scrollable: true,
      title: AlertDialogTitle(titleText: Text(LocaleKeys.addingCompetition.tr()),),
      titleTextStyle: TextStyleManager.s16w700.copyWith(
        color: ColorManager.black,
        fontFamily: FontConstants.tajawal,
      ),
      insetPadding: EdgeInsets.all(10.sp),
      content: Column(
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
            dateController: widget.dateController,
            hintText: LocaleKeys.competitionEndDate.tr(),
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
            textController: widget.numberOfWinnersController,
            hintText: LocaleKeys.winnersNumber.tr(),
            keyboardType: TextInputType.number,
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
            textController: widget.prizeNameController,
            hintText: LocaleKeys.prizeName.tr(),
            keyboardType: TextInputType.text,
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
            textController: widget.imgUrlController,
            hintText: LocaleKeys.prizeImageLink.tr(),
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: 14.h),
          prizeImageBuilder(),
          SizedBox(height: 14.h),
          GradButton(
              text: Text(
                LocaleKeys.addCompetition.tr(),
                style: TextStyleManager.s18w700,
              ),
              icon: Icon(
                IconsManager.add,
                size: 28.sp,
              ),
              width: 250.w,
              reverseIcon: false,
              onPressed: () {}),
        ],
      ),
    );
  }
}

/// Alert dialog title with exiting button
class AlertDialogTitle extends StatelessWidget {
  const AlertDialogTitle({
    required this.titleText,
    Key? key,
  }) : super(key: key);
  /// The text to display in the title.
  final Text titleText;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: EdgeInsets.only( top: 15.h),
          child: titleText,
        ),
        Positioned(
          top: 0,
          left: context.isArabic ? 0 : null,
          right: context.isArabic ? null : 0,
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.dialogCloseIconBackgroundGrey,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.2),
                        blurRadius: 1.sp,
                        spreadRadius: 1.sp,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Padding(
                  padding: EdgeInsets.all(2.sp),
                  child: Icon(
                    FontAwesomeIcons.xmark,
                    size: 24.sp,
                    color: ColorManager.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}