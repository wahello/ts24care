import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';

class BottomControlCameraWidget extends StatefulWidget {
  final TS24CameraWidgetViewModel viewModel;

  BottomControlCameraWidget({this.viewModel});

  @override
  _BottomControlCameraWidgetState createState() =>
      _BottomControlCameraWidgetState();
}

class _BottomControlCameraWidgetState extends State<BottomControlCameraWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.viewModel.indexSwipe == 0) widget.viewModel.isRecorder = false;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.viewModel.indexSwipe == 0) widget.viewModel.isRecorder = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buttonShoot() {
      return Container(
        height: 70,
        width: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3)),
        child: TS24Button(
          onTap: () {
            if (widget.viewModel.indexSwipe == 1) {
              setState(() {
                widget.viewModel.isRecorder = !widget.viewModel.isRecorder;
              });
            }
          },
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
//                          shape: BoxShape.circle,
          ),
          child: AnimatedContainer(
            width: widget.viewModel.isRecorder ? 35 : 60,
            height: widget.viewModel.isRecorder ? 35 : 60,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.viewModel.isRecorder ? 5 : 50)),
              color: widget.viewModel.isRecorder ? Colors.red : Colors.white,
//                          shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    Widget _buttonSwitchCamera() {
      return FlatButton(
        onPressed: () {
          widget.viewModel.onSwitchCamera(mounted);
        },
        child: Container(
          height: 30,
          width: 30,
          child: Icon(
            Icons.switch_camera,
            color: Colors.white,
            size: 40,
          ),
        ),
      );
    }

    Widget _reviewBox() {
      return FlatButton(
        onPressed: () {},
        child: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/images/vegetable_natural.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5)),
        ),
      );
    }

    Widget _bottomTitleCameraType() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: widget.viewModel.isRecorder
                      ? Colors.transparent
                      : Colors.black12,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                'Picture',
                style: TextStyle(
                    color: widget.viewModel.isRecorder
                        ? Colors.white
                        : ThemePrimary.primaryColor),
              )),
          SizedBox(
            width: 5,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: widget.viewModel.isRecorder
                      ? Colors.black12
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                'Camera',
                style: TextStyle(
                    color: widget.viewModel.isRecorder
                        ? ThemePrimary.primaryColor
                        : Colors.white),
              )),
        ],
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 140,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _bottomTitleCameraType(),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _reviewBox(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buttonShoot(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[_buttonSwitchCamera()],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
