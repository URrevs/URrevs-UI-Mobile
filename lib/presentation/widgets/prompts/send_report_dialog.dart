import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SendReportDialog extends ConsumerStatefulWidget {
  const SendReportDialog({
    Key? key,
    required this.postId,
    required this.postContentType,
    required this.targetType,
  }) : super(key: key);

  final String postId;
  final PostContentType postContentType;
  final TargetType targetType;

  @override
  ConsumerState<SendReportDialog> createState() => _SendReportDialogState();
}

class _SendReportDialogState extends ConsumerState<SendReportDialog> {
  final TextEditingController _controller = TextEditingController();
  ComplaintReason? _complaintReason;
  String? _errMsg;
  List<String> translatedLabels = [
    LocaleKeys.spam.tr(),
    LocaleKeys.violentContent.tr(),
    LocaleKeys.harrasment.tr(),
    LocaleKeys.hateContent.tr(),
    LocaleKeys.nudity.tr(),
    'other'.tr(),
  ];

  late final ReportPostProviderParams _providerParams =
      ReportPostProviderParams(
    postId: widget.postId,
    postContentType: widget.postContentType,
    targetType: widget.targetType,
  );

  void _sendReport() {
    if (_complaintReason == null) {
      setState(() {
        _errMsg = LocaleKeys.theReasonForTheComplaintMustBeSelectd.tr();
      });
      return;
    }
    ReportPostRequest request = ReportPostRequest(
      reason: _complaintReason!.indexForRequest,
      info: _controller.text.isNotEmpty ? _controller.text : null,
    );
    ref.read(reportPostProvider(_providerParams).notifier).reportPost(request);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: LocaleKeys.report.tr(),
      hasTitle: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.selectTheReasonForTheComplaint.tr(),
            style: TextStyleManager.s16w400.copyWith(
              color: ColorManager.black,
            ),
          ),
          for (int i = 0; i < ComplaintReason.values.length; i++)
            RadioListTile<ComplaintReason>(
              value: ComplaintReason.values[i],
              groupValue: _complaintReason,
              onChanged: (reason) => setState(() => _complaintReason = reason),
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              title: Text(
                translatedLabels[i],
                style: TextStyleManager.s16w400.copyWith(
                  color: ColorManager.black,
                ),
              ),
            ),
          if (_errMsg != null) ...[
            Text(
              _errMsg!,
              style: TextStyleManager.s13w400.copyWith(
                color: ColorManager.red,
              ),
            ),
            5.verticalSpace,
          ],
          Form(
            child: TxtField(
              textController: _controller,
              hintText: LocaleKeys
                  .enterAdditionalInformationRegardingTheComplaint
                  .tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              maxLines: 5,
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            LocaleKeys.cancel.tr(),
            style: TextStyleManager.s16w900.copyWith(
              color: ColorManager.black,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: _sendReport,
          child: Text(
            LocaleKeys.send.tr(),
            style: TextStyleManager.s16w900.copyWith(
              color: ColorManager.blue,
            ),
          ),
        )
      ],
    );
  }
}
