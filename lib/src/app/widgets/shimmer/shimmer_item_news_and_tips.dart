import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemNewFeedHorizontalWidget extends StatefulWidget {
  const ShimmerItemNewFeedHorizontalWidget({Key key}) : super(key: key);
  @override
  _ItemNewFeedHorizontalWidgetState createState() =>
      _ItemNewFeedHorizontalWidgetState();
}

class _ItemNewFeedHorizontalWidgetState
    extends State<ShimmerItemNewFeedHorizontalWidget> {
  final _color = Colors.grey[200];
  Widget _shimmer({Widget widget}) {
    return Shimmer(
      period: Duration(seconds: 2),
      direction: ShimmerDirection.ltr,
      gradient:
          LinearGradient(colors: [_color, Colors.white, _color, Colors.white]),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
//              boxShadow: [
//                BoxShadow(
//                    color: Colors.black12,
//                    offset: Offset(0.0, 1.0),
//                    blurRadius: 1.0),
//                BoxShadow(
//                    color: Colors.black12,
//                    offset: Offset(0.0, -1.0),
//                    blurRadius: 1.0),
//              ]
          ),
          child: _shimmer(
              widget: Container(
            width: MediaQuery.of(context).size.width * 0.43,
            height: MediaQuery.of(context).size.width * 0.43,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0), color: _color),
          )),
        ),
//        Container(
////          width: MediaQuery.of(context).size.width * 0.3,
//          alignment: Alignment.center,
//          margin: EdgeInsets.all(10),
//          decoration: BoxDecoration(
//            color: Colors.red,
//            borderRadius: BorderRadius.all(Radius.circular(12.0)),
//          ),
//          child: Image.network(widget.url,fit: BoxFit.cover,),
//        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.center,
//          width: MediaQuery.of(context).size.width * 0.3,
//          height: 200,
          child: Column(
            children: <Widget>[
              _shimmer(
                  widget: Container(
                color: _color,
                height: 20,
              )),
              _shimmer(
                  widget: Container(
                color: _color,
                height: 20,
              )),
            ],
          ),
        )
      ],
    );
  }
}

class ShimmerItemNewFeedVerticalWidget extends StatefulWidget {
  const ShimmerItemNewFeedVerticalWidget({Key key}) : super(key: key);
  @override
  _ItemNewFeedVerticalWidgetState createState() =>
      _ItemNewFeedVerticalWidgetState();
}

class _ItemNewFeedVerticalWidgetState
    extends State<ShimmerItemNewFeedVerticalWidget> {
  final _color = Colors.grey[200];
  Widget _shimmer({Widget widget}) {
    return Shimmer(
      period: Duration(seconds: 2),
      direction: ShimmerDirection.ltr,
      gradient:
          LinearGradient(colors: [_color, Colors.white, _color, Colors.white]),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
//                boxShadow: [
//                  BoxShadow(
//                      color: Colors.black12,
//                      offset: Offset(0.0, 1.0),
//                      blurRadius: 1.0),
//                  BoxShadow(
//                      color: Colors.black12,
//                      offset: Offset(0.0, -1.0),
//                      blurRadius: 1.0),
//                ]
            ),
            child: _shimmer(
                widget: Container(
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0), color: _color),
            )),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.33,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _shimmer(widget: Container(
                    height: 20,
                    color: _color,
                  )),
                  _shimmer(widget: Container(
                    height: 20,
                    color: _color,
                  )),
                  _shimmer(widget: Container(
                    height: 20,
                    color: _color,
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
