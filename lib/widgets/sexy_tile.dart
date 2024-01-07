import 'package:dashboard_reborn/utils/ui_helpers.dart';
import 'package:flutter/material.dart';

class SexyTile extends StatelessWidget {
  SexyTile(
      {required this.child,
      required this.color,
      required this.splashColor,
      required this.onTap});
  final Widget child;
  final Color color;
  final Color splashColor;
  final Function() onTap;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Material(
        color: color,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: shadowColor(context),
        child: InkWell(
          child: child,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(15.0),
          // ignore: unnecessary_null_comparison
          onTap: onTap == null ? doNothing : () => onTap(),
        ),
      ),
    );
  }
}
