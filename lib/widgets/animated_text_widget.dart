import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatelessWidget {
  const AnimatedTextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontStyle,
    required this.fontWeight,
  });

  final String text;
  final Color color;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      pause: const Duration(milliseconds: 2000),
      animatedTexts: [
        TyperAnimatedText(
          text,
          textStyle: TextStyle(
            fontSize: fontSize,
            color: color,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
