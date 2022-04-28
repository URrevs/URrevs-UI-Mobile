import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScaffoldWithHidingFab extends StatefulWidget {
  const ScaffoldWithHidingFab({
    Key? key,
    this.appBar,
    required this.body,
    required this.fabIcon,
    required this.fabLabel,
    required this.onPressingFab,
    this.hideFab = false,
  }) : super(key: key);

  final AppBar? appBar;
  final Widget body;
  final Widget fabIcon;
  final String fabLabel;
  final VoidCallback onPressingFab;
  final bool hideFab;

  @override
  State<ScaffoldWithHidingFab> createState() => _ScaffoldWithHidingFabState();
}

class _ScaffoldWithHidingFabState extends State<ScaffoldWithHidingFab> {
  bool _expandedFab = true;

  Widget? get fab {
    if (widget.hideFab) return null;
    if (_expandedFab) {
      return FloatingActionButton.extended(
        onPressed: widget.onPressingFab,
        label: Text(widget.fabLabel),
        icon: widget.fabIcon,
      );
    } else {
      return FloatingActionButton(
        onPressed: widget.onPressingFab,
        child: widget.fabIcon,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (widget.hideFab) return true;
            if (notification.metrics.axis == Axis.horizontal) return true;
            if (notification.direction == ScrollDirection.forward) {
              if (!_expandedFab) setState(() => _expandedFab = true);
            } else if (notification.direction == ScrollDirection.reverse) {
              if (_expandedFab) setState(() => _expandedFab = false);
            }
            return true;
          },
          child: widget.body,
        ),
      ),
      floatingActionButton: fab,
    );
  }
}
