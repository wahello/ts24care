import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';

typedef DirectoryCallback = void Function(String derectory);
class BottomControlCameraWidget extends StatefulWidget {
//  final TS24CameraWidgetViewModel viewModel;
  final Function() onShoot;

  BottomControlCameraWidget({this.onShoot});

  @override
  _BottomControlCameraWidgetState createState() =>
      _BottomControlCameraWidgetState();
}

class _BottomControlCameraWidgetState extends State<BottomControlCameraWidget> {
  TS24CameraWidgetViewModel viewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    if (widget.viewModel.indexSwipe == 0) widget.viewModel.isRecorder = false;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
//    if (widget.viewModel.indexSwipe == 0) widget.viewModel.isRecorder = false;
  }

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModelProvider.of(context);
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
            if (viewModel.isCamera) {
              viewModel.toogleFlatRunCamera();
            }
            if (viewModel.isTakePicture &&
                viewModel.isCamera == false) {
//              viewModel.onTakePictureButtonPressed(mounted);
                widget.onShoot();
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
            width: viewModel.isCamera &&
                    !viewModel.isTakePicture &&
                    viewModel.isRecorderStarting
                ? 35
                : 60,
            height: viewModel.isCamera &&
                    !viewModel.isTakePicture &&
                    viewModel.isRecorderStarting
                ? 35
                : 60,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                  viewModel.isCamera &&
                          !viewModel.isTakePicture &&
                          viewModel.isRecorderStarting
                      ? 5
                      : 50)),
              color: viewModel.isCamera &&
                      !viewModel.isTakePicture &&
                      viewModel.isRecorderStarting
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
          viewModel.onSwitchCamera(mounted);
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
                  image: viewModel.imagePath == null
                      ? AssetImage("assets/images/default.jpg")
                      : AssetImage(viewModel.imagePath),
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
              viewModel.updateTitleCameraAndPicture('picture');
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: viewModel.isTakePicture
                        ? Colors.black38
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Picture',
                  style: TextStyle(
                      color: viewModel.isTakePicture
                          ? ThemePrimary.primaryColor
                          : Colors.white),
                )),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              viewModel.updateTitleCameraAndPicture('camera');
            },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: viewModel.isCamera
                        ? Colors.black38
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  'Camera',
                  style: TextStyle(
                      color: viewModel.isCamera
                          ? ThemePrimary.primaryColor
                          : Colors.white),
                )),
          ),
        ],
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .18,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          _bottomTitleCameraType(),
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
