import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/circular_loading.dart';

class AdminPanelTileLoading extends StatelessWidget {
  const AdminPanelTileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularLoading();
  }
}
