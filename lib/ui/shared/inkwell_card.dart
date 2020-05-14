import 'package:flutter/material.dart';

class InkWellCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double elevation;
  final VoidCallback onTap;

  InkWellCard({
    this.child,
    this.margin,
    this.borderRadius,
    this.elevation = 1,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Card(
        margin: margin,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(6)),
        elevation: elevation,
        child: IntrinsicHeight(
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
      Positioned.fill(
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: Material(
            color: Colors.transparent,
            child: new InkWell(
              splashColor: Colors.black12,
              borderRadius: BorderRadius.circular(14),
              onTap: onTap,
            ),
          ),
        ),
      )
    ]);
  }
}
