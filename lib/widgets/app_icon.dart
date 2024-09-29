import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  double size;
  final double iconSize;
  AppIcon({Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.size = 45,
    this.iconSize=16,
    this.iconColor = const Color(0xFF756d54)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(size / 2),
        color: backgroundColor),
        child: Icon(icon,color: iconColor,size: iconSize),);
  }
}
