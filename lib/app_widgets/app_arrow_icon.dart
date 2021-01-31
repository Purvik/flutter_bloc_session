import 'package:flutter/material.dart';

class AppArrowIcon extends StatelessWidget {
  final IconData iconData;
  final Function onPress;
  final double iconSize;
  final Color iconColor;

  AppArrowIcon({
    @required this.iconData,
    @required this.onPress,
    this.iconSize = 100,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      splashColor: Colors.black12,
      highlightColor: Colors.transparent,
      child: Icon(
        iconData,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
