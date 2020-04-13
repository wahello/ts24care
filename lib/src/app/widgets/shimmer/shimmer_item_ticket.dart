import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemTicketsWidget extends StatelessWidget {
  const ShimmerItemTicketsWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _color = Colors.grey[200];
    Widget _shimmer({Widget widget}) {
      return Shimmer(
        period: Duration(seconds: 2),
        direction: ShimmerDirection.ltr,
        gradient: LinearGradient(
            colors: [_color, Colors.white, _color, Colors.white]),
        child: widget,
      );
    }

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 10),
          alignment: Alignment.center,
          width: 50,
          height: 50,
          child: _shimmer(
            widget: Container(
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(45.0),
              ),
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.width * 0.33,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _shimmer(
                    widget: Container(
                  height: 20,
                  color: _color,
                )),
                _shimmer(
                    widget: Container(
                  height: 20,
                  color: _color,
                )),
                _shimmer(
                    widget: Container(
                  height: 20,
                  color: _color,
                )),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        )
      ],
    );
  }
}
