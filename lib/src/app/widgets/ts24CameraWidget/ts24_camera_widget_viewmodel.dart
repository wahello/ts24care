import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TS24CameraWidgetViewModel extends ViewModelBase {
  List<CameraDescription> cameras;
  CameraController controller;
  int selectedCameraIndex;
  String imagePath;
  int indexSwipe = 0;
  bool isRecorder = false;
  bool isTakePicture = true;
  bool isCamera = false;
  bool isFlashOn = false;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;

  bool isRecorderStop = true;
  bool isRecorderStarting = false;
  // bool mounted = false;
  TS24CameraWidgetViewModel();
  // chay I dung I Flat
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

  // void onNewCameraSelected(CameraDescription cameraDescription) async {
  //   if (controller != null) {
  //     await controller.dispose();
  //   }
  //   controller = CameraController(
  //     cameraDescription,
  //     ResolutionPreset.max,
  //     enableAudio: enableAudio,
  //   );
  //   // If the controller is updated then update the UI.
  //   controller.addListener(() {
  //     if (mounted) this.updateState();
  //     if (controller.value.hasError) {
  //       print('Camera error ${controller.value.errorDescription}');
  //     }
  //   });

  //   try {
  //     await controller.initialize();
  //   } on CameraException catch (e) {
  //     print(e);
  //   }

  //   if (mounted) {
  //     this.updateState();
  //   }
  // }

  Future initCameraController(CameraDescription camera, bool mounted) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(camera, ResolutionPreset.max);
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

  void onFlashButtonClicked() {
    isFlashOn = !isFlashOn;
    this.updateState();
  }

  void onSwitchCamera(bool mounted) {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCameraController(selectedCamera, mounted);
  }

  void updateTitleCameraAndPicture(String state) {
    if (state == 'picture') {
      isTakePicture = true;
      isCamera = false;
      this.updateState();
    }
    if (state == 'camera') {
      isTakePicture = false;
      isCamera = true;
      this.updateState();
    }
    if (state == 'swipe') {
      isTakePicture = !isTakePicture;
      isCamera = !isCamera;
      this.updateState();
    }
  }

  void onTakePictureButtonPressed(
    bool mounted,
  ) {
    print('picture');
    takePicture().then((String filePath) {
      if (mounted) {
        imagePath = filePath;
        videoController?.dispose();
        videoController = null;
        this.updateState();
        if (filePath != null) {
          print('Picture saved to $filePath');
          Navigator.pop(context, filePath);
        }
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
//      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
    return filePath;
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

//  recoder
  void onVideoRecordButtonPressed(bool mounted) {
    isRecorderStarting = true;
    isRecorderStop = false;

    startVideoRecording().then((String filePath) {
      if (mounted) this.updateState();
      if (filePath != null) print('Saving video to $filePath');
    });
  }

  void toogleFlatRunCamera() {
    isRecorderStarting = !isRecorderStarting;
    this.updateState();
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      print('Error: select a camera first.');
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    isRecorderStarting = false;
    isRecorderStop = true;

    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      print(e);
      return null;
    }

//    await _startVideoPlayer();
  }

  void updateIsRecorderStop() {
    isRecorderStop = !isRecorderStop;
    this.updateState();
  }
}
