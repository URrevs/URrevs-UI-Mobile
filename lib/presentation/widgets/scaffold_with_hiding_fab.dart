import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScaffoldWithHidingFab extends StatefulWidget {
  const ScaffoldWithHidingFab({
    Key? key,
    required this.appBar,
    required this.body,
    required this.floatingActionButton,
  }) : super(key: key);

  final AppBar appBar;
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  @override
  State<ScaffoldWithHidingFab> createState() => _ScaffoldWithHidingFabState();
}

class _ScaffoldWithHidingFabState extends State<ScaffoldWithHidingFab> {
  bool _showFab = true;

  Widget? get fab => _showFab ? widget.floatingActionButton : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (widget.floatingActionButton == null) return true;
          if (notification.metrics.axis == Axis.horizontal) return true;
          if (notification.direction == ScrollDirection.forward) {
            if (!_showFab) setState(() => _showFab = true);
          } else if (notification.direction == ScrollDirection.reverse) {
            if (_showFab) setState(() => _showFab = false);
          }
          return true;
        },
        child: widget.body,
      ),
      floatingActionButton: fab,
    );
  }
}
