import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../resources/values_manager.dart';
import '../../state_management/providers.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField({
    Key? key,
    required this.searchCtl,
    required this.hintText,
    required this.searchProviderParams,
    required this.fillColor,
    required this.checkChosenSearchResult,
    this.chosenSearchResult,
    this.errorMsg = '',
    this.hasErrorMsg = false,
    this.readOnly = false,
    this.onClear,
    this.requestFoucus = false,
  }) : super(key: key);

  final TextEditingController searchCtl;
  final bool hasErrorMsg;
  final String errorMsg;
  final String hintText;
  final SearchProviderParams searchProviderParams;
  final Color fillColor;
  final bool readOnly;
  final VoidCallback? onClear;
  final SearchResult? chosenSearchResult;
  final bool checkChosenSearchResult;
  final bool requestFoucus;

  @override
  ConsumerState<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  Timer? _timer;
  late final TextEditingController _controller = widget.searchCtl;
  late final SearchProviderParams _providerParams = widget.searchProviderParams;
  final FocusNode _focusNode = FocusNode();

  void _search() {
    ref.read(searchProvider(_providerParams).notifier).search(_controller.text);
  }

  void _handleTextFieldChange() {
    _timer?.cancel();
    if (_controller.text.isNotEmpty) {
      _timer = Timer(AppDuration.typingThrottling, _search);
    } else {
      ref.read(searchProvider(_providerParams).notifier).returnToInitialState();
    }
  }

  InputBorder inputBorder([Color? color]) {
    color ??= ColorManager.strokeGrey;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.r),
      borderSide: BorderSide(width: 0.8, color: color),
    );
  }

  Widget get suffixWidget {
    return StatefulBuilder(builder: (context, setBuilderState) {
      _controller.addListener(() => setBuilderState(() {}));
      if (_controller.text.isEmpty) {
        return Icon(IconsManager.search, size: 29.sp);
      }
      return IconButton(
        onPressed: () {
          _controller.text = '';
          _timer?.cancel();
          ref
              .read(searchProvider(_providerParams).notifier)
              .returnToInitialState();
          if (widget.onClear != null) widget.onClear!();
        },
        icon: Icon(
          FontAwesomeIcons.xmark,
          size: 18.sp,
          color: ColorManager.black,
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.requestFoucus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      cursorColor: ColorManager.black,
      controller: widget.searchCtl,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      style: TextStyleManager.s18w500.copyWith(
        color: ColorManager.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        suffixIcon: suffixWidget,
        suffixIconColor: ColorManager.black,
        hintText: widget.hintText,
        hintStyle: TextStyleManager.s16w300.copyWith(
          color: ColorManager.black,
        ),
        filled: true,
        fillColor: widget.fillColor,
        errorStyle: TextStyleManager.s13w400.copyWith(color: ColorManager.red),
        errorBorder:
            widget.hasErrorMsg ? inputBorder(ColorManager.red) : inputBorder(),
        disabledBorder: inputBorder(),
        border: inputBorder(),
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(ColorManager.blue),
      ),
      onChanged: (_) => _handleTextFieldChange(),
      validator: widget.hasErrorMsg
          ? (value) {
              if (value == null || value.isEmpty) {
                return widget.errorMsg;
              } else if (widget.checkChosenSearchResult &&
                  widget.chosenSearchResult == null) {
                return widget.errorMsg;
              } else {
                return null;
              }
            }
          : null,
    );
  }
}
