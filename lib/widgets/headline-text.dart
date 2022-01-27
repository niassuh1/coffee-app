import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  const HeadlineText(
      {this.title, this.subtitle, this.titleStyle, this.subtitleStyle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(text: title, style: titleStyle, children: [
        TextSpan(
          text: subtitle,
          style: subtitleStyle,
        )
      ]),
    );
  }
}
