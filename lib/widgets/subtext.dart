import 'package:flutter/material.dart';

class SubTextWidget extends StatelessWidget {
  const SubTextWidget({
    Key? key,
    required this.label,
    this.fontSize = 15,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.white,
    this.underline = TextDecoration.none,
    this.icon,
    this.iconColor = Colors.amber, // New parameter for icon color
    this.lineHeight = 1.0,
  }) : super(key: key);

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration underline;
  final IconData? icon;
  final Color? iconColor; // New parameter for icon color
  final double lineHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)
          Icon(
            icon,
            size: fontSize * 1.5,
            color: iconColor, // Use the provided icon color
          ),
        SizedBox(width: icon != null ? 8.0 : 0),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontStyle: fontStyle,
            decoration: underline,
            height: lineHeight,
          ),
        ),
      ],
    );
  }
}
