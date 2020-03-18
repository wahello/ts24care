import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';


class TS24CameraWidgetViewModel extends ViewModelBase {
  CameraController controller;
  List cameras;
  int selectedCameraIndex;
  String imagePath;
  int indexSwipe = 0;
  bool isRecorder = false;
  bool isFlashOn = false;
  void fetchCameras(bool mounted) {
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        selectedCameraIndex = 0;
        this.updateState();
        initCameraController(cameras[selectedCameraIndex], mounted)
            .then((void v) {});
      } else {
        print("No camera");
      }
    }).catchError((onError) {
      print("error on fetchCameras function");
    });
  }

  Future initCameraController(
      CameraDescription camera, bool mounted) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(camera, ResolutionPreset.high);
    controller.addListener(() {
      if (mounted) {
        this.updateState();
      }
      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e);
    }

    if (mounted) {
      this.updateState();
    }
  }

  // need if use icon
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }


  void onFlashButtonClicked(){
    isFlashOn = !isFlashOn;
    this.updateState();
  }

  void onSwitchCamera(bool mounted) {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCameraController(selectedCamera, mounted);
  }

  void onIndexSwipeChanged(){
    isRecorder = !isRecorder;
    this.updateState();
  }
}
