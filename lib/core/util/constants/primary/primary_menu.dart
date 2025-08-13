import 'package:flutter/material.dart';

void showPrimaryMenu({
  required BuildContext context,
  required GlobalKey key,
  required List<PopupMenuEntry> items,
  bool isBottom = true,
  double height = 0.0,
  double isBottomHeight = 45.0,
}) {
  showMenu(
    context: context,
    useRootNavigator: true,
    color: Colors.white,
    surfaceTintColor: Colors.grey.withValues(alpha: 0.8),
    position: RelativeRect.fromLTRB(
      getXPosition(key),
      isBottom
          ? getYPosition(key) + isBottomHeight
          : getYPosition(key) - height,
      getXPosition(key),
      getYPosition(key),
    ),
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(
        30.0,
      ),
    ),
    items: items,
  );
}

double getYPosition(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero);

  return position.dy;
}

double getXPosition(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero);

  return position.dx;
}