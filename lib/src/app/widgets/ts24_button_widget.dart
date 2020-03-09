import 'package:flutter/material.dart';

class TS24Button extends StatelessWidget {
  final BoxDecoration decoration;
  final double width;
  final double height;
  final Function onTap;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final AlignmentGeometry alignment;

  const TS24Button(
      {Key key,
      this.onTap,
      this.decoration,
      this.child,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.alignment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: padding,
          margin: margin,
          width: width,
          height: height,
          alignment: alignment,
          decoration: decoration,
          child: child,
        ),
        Container(
          margin: margin,
          width: width,
          height: height,
          decoration: decoration != null
              ? BoxDecoration(
                  borderRadius: decoration.borderRadius,
                  color: Colors.transparent,
                  border: decoration.border,
                  boxShadow: decoration.boxShadow,
                  gradient: decoration.gradient,
                  shape: decoration.shape,
                  backgroundBlendMode: decoration.backgroundBlendMode,
                  image: decoration.image)
              : BoxDecoration(
                  color: Colors.transparent, borderRadius: BorderRadius.zero),
          child: Material(
            shape: decoration != null ? decoration.border : null,
            borderRadius: decoration != null
                ? decoration.borderRadius
                : BorderRadius.zero,
            color: Colors.transparent,
            child: InkWell(
              borderRadius: decoration != null
                  ? decoration.borderRadius
                  : BorderRadius.zero,
              onTap: onTap,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        )
      ],
    );
  }
}
