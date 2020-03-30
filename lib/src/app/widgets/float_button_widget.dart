import 'package:flutter/material.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';

class FloatButtonWidget extends StatefulWidget {
  final List<FloatingActionButton> listFAB;
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  FloatButtonWidget({this.onPressed, this.tooltip, this.icon, this.listFAB});

  @override
  _FloatButtonWidgetState createState() => _FloatButtonWidgetState();
}

class _FloatButtonWidgetState extends State<FloatButtonWidget>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  int count = 0;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  List<FloatingActionButton> list = List();
  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: ThemePrimary.primaryColor,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    widget.listFAB.forEach((item) {
      list.add(item);
    });
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: Transform.rotate(
          angle: _animateIcon.value*2.3,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ...list
            .asMap()
            .map((index, item) {
              return MapEntry(
                  index,
                  Transform(
                    transform: Matrix4.translationValues(
                      0.0,
                      _translateButton.value * (widget.listFAB.length - index),
                      0.0,
                    ),
                    child: Container(
                      child:
                      isOpened
                          ?
                      item
                          : FloatingActionButton(
                              backgroundColor: item.backgroundColor,
                              heroTag: index.toString(),
                              onPressed: item.onPressed,
                              elevation: 0,
                              child: item.child,
                              tooltip: item.tooltip,
                            ),
                    ),
                  ));
            })
            .values
            .toList(),
//        Transform(
//          transform: Matrix4.translationValues(
//            0.0,
//            _translateButton.value * 3.0,
//            0.0,
//          ),
//          child: add(),
//        ),
//        Transform(
//          transform: Matrix4.translationValues(
//            0.0,
//            _translateButton.value * 2.0,
//            0.0,
//          ),
//          child: chat(),
//        ),
//        Transform(
//          transform: Matrix4.translationValues(
//            0.0,
//            _translateButton.value,
//            0.0,
//          ),
//          child: call(),
//        ),
        toggle(),
      ],
    );
  }
}
