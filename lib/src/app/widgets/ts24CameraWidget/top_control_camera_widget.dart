import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ts24care/src/app/widgets/ts24CameraWidget/ts24_camera_widget_viewmodel.dart';


class TopControlCameraWidget extends StatefulWidget {
  final TS24CameraWidgetViewModel viewModel;

  TopControlCameraWidget(this.viewModel);

  @override
  _TopControlCameraWidgetState createState() => _TopControlCameraWidgetState();
}

class _TopControlCameraWidgetState extends State<TopControlCameraWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }


  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      height: 50,
      color: Colors.black12,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
//          Expanded(
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: <Widget>[
//                IconButton(
//                  onPressed: () {
//                    widget.viewModel.onFlashButtonClicked();
////                    TorchCompat.turnOn();
////                    if(widget.viewModel.isFlashOn){
////                      TorchCompat.turnOn();
////                    }
////                    if(widget.viewModel.isFlashOn){
////                      TorchCompat.turnOff();
////                    }
//                  },
//                  icon: Icon(
//                    widget.viewModel.isFlashOn
//                        ? Icons.flash_on
//                        : Icons.flash_off,
//                    color: Colors.white,
//                  ),
//                )
//              ],
//            ),
//          )
        ],
      ),
    );
  }
}
