import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';

class ElevatedButtonStyleManager {
  static ButtonStyle get authButton =>
      ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size.zero),
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
              backgroundColor:
                  MaterialStateProperty.all<Color>(ColorManager.backgroundGrey),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                  side: BorderSide(
                    width: 1.5,
                  ),
                ),
              ),
            );
}