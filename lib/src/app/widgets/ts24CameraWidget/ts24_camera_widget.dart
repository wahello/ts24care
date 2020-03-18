import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/top_control_camera_widget.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/bottom_control_camera_widget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class TS24CameraWidget extends StatefulWidget {
  @override
  _TS24CameraWidgetState createState() => _TS24CameraWidgetState();
}

class _TS24CameraWidgetState extends State<TS24CameraWidget>
    with WidgetsBindingObserver {
  TS24CameraWidgetViewModel viewModel = TS24CameraWidgetViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.fetchCameras(mounted);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    // App state changed before we got the chance to initialize.
//    if (viewModel.controller == null ||
//        !viewModel.controller.value.isInitialized) {
//      return;
//    }
//    if (state == AppLifecycleState.inactive) {
//      viewModel.controller?.dispose();
//    } else if (state == AppLifecycleState.resumed) {
//      if (viewModel.controller != null) {
//        viewModel.onNewCameraSelected(
//            viewModel.controller.description, mounted);
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    var mediaTool = MediaQuery.of(context);

//    Widget _cameraPreviewWidget() {
//      if (viewModel.controller == null ||
//          !viewModel.controller.value.isInitialized) {
//        return Container(
//          alignment: Alignment.center,
//          child: const Text(
//            'Tap a camera',
//            style: TextStyle(
//              color: Colors.black54,
//              fontSize: 24.0,
//              fontWeight: FontWeight.w900,
//            ),
//          )
//          ,
//        );
//      } else {
//        return AspectRatio(
//          aspectRatio: viewModel.controller.value.aspectRatio,
//          child: CameraPreview(viewModel.controller),
//        );
//      }
//    }

    Widget _cameraPreviewWidget() {
      if (viewModel.controller == null ||
          !viewModel.controller.value.isInitialized) {
        return const Text(
          'Loading',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        );
      }

      return Container(
        width: mediaTool.size.width,
        height: mediaTool.size.height,
        child: AspectRatio(
          aspectRatio: viewModel.controller.value.aspectRatio,
          child: CameraPreview(viewModel.controller),
        ),
      );
    }

    Widget _bottomControlWidget(viewModel) {
      return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: BottomControlCameraWidget(viewModel: viewModel));
    }

    Widget _topControllerWidget(viewModel) {
      return Positioned(
          top: 0, left: 0, right: 0, child: TopControlCameraWidget(viewModel));
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                GestureDetector(
                  child: _cameraPreviewWidget(),
                  onHorizontalDragEnd: (_) {
                    viewModel.onIndexSwipeChanged();
                  },
                ),
                _topControllerWidget(viewModel),
                _bottomControlWidget(viewModel),
              ],
            ),
          );
        },
      ),
    );
  }
}
