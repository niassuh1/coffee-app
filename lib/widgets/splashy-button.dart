import 'package:capulus/constants.dart';
import 'package:flutter/material.dart';

class SplashyButton extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;
  final Color color;
  const SplashyButton({this.child, this.onTap, this.color = primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white10,
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
