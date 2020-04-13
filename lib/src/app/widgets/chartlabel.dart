import 'dart:math';
import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as text;
import 'package:charts_flutter/src/text_style.dart' as style;

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      FillPatternType fillPattern,
      Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.white);
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(
        text.TextElement("CustomMeasureTickCount.pointerValue",
            style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round());
  }
}
