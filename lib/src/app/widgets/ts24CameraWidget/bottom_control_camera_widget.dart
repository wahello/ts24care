import 'dart:io';

import 'package:flutter/material.dart';
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
            if (widget.viewModel.isCamera) {
              widget.viewModel.toogleFlatRunCamera();
            }
            if (widget.viewModel.isTakePicture &&
                widget.viewModel.isCamera == false) {
              widget.viewModel.onTakePictureButtonPressed(mounted);
            }
          },
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Colors.transparent,
          ),
          child: AnimatedContainer(
            width: widget.viewModel.isCamera &&
                    !widget.viewModel.isTakePicture &&
                    widget.viewModel.isRecorderStarting
                ? 35
                : 60,
            height: widget.viewModel.isCamera &&
                    !widget.viewModel.isTakePicture &&
                    widget.viewModel.isRecorderStarting
                ? 35
                : 60,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                  widget.viewModel.isCamera &&
                          !widget.viewModel.isTakePicture &&
                          widget.viewModel.isRecorderStarting
                      ? 5
                      : 50)),
              color: widget.viewModel.isCamera &&
                      !widget.viewModel.isTakePicture &&
                      widget.viewModel.isRecorderStarting
                  ? Colors.red
                  : Colors.white,
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
                  image: widget.viewModel.imagePath == null
                      ? AssetImage("assets/images/vegetable_natural.jpg")
                      : AssetImage(widget.viewModel.imagePath),
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
          GestureDetector(
            onTap: () {
              widget.viewModel.updateTitleCameraAndPicture('picture');
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: widget.viewModel.isTakePicture
                        ? Colors.black38
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Picture',
                  style: TextStyle(
                      color: widget.viewModel.isTakePicture
                          ? ThemePrimary.primaryColor
                          : Colors.white),
                )),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              widget.viewModel.updateTitleCameraAndPicture('camera');
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: widget.viewModel.isCamera
                        ? Colors.black38
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Camera',
                  style: TextStyle(
                      color: widget.viewModel.isCamera
                          ? ThemePrimary.primaryColor
                          : Colors.white),
                )),
          ),
        ],
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .22,
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
