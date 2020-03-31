library ts24_utils;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';


import '../app_localizations.dart';

BoxDecoration boxShaDow() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0),
        ]);

//Icon menu on appBar
//IconButton appBarIconSideMenu(BuildContext context) {
//  TabsPageViewModel tabsPageViewModel = ViewModelProvider.of(context);
//  GlobalKey<ScaffoldState> scaffoldTabbar = tabsPageViewModel != null
//      ? tabsPageViewModel.scaffoldTabbar
//      : GlobalKey<ScaffoldState>();
//  return IconButton(
//    icon: new Icon(Icons.menu),
//    tooltip: "Open side menu",
//    onPressed: () => scaffoldTabbar.currentState.openDrawer(),
//  );
//}

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg,
      {int color = 0xffffffff}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          color: Color(color),
          height: 100,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: new Text(
                  msg,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
    //Navigator.pop(context);
  }

  static void showMsgDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translation.text("POPUP_CONFIRM.TITLE")),
        content: Text(msg),
        actions: [
          new FlatButton(
            child: Text(translation.text("POPUP_CONFIRM.OK")),
            onPressed: () {
              Navigator.of(context).pop(LoadingDialog);
            },
          ),
        ],
      ),
    );
  }

  Future<bool> showMsgDialogWithButton(BuildContext context, String msg,
      {String textYes = "Tiếp tục", String textNo = "Hủy"}) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          translation.text("POPUP_CONFIRM.TITLE"),
          style: TextStyle(color: ThemePrimary.primaryColor),
        ),
        content: Text(
          msg,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          OutlineButton(
              borderSide: BorderSide(color: ThemePrimary.primaryColor),
              child: new Text(
                textNo,
                style:
                    TextStyle(fontSize: 16, color: ThemePrimary.primaryColor),
              ),
              onPressed: () {
//                result = false;
                Navigator.of(context).pop(false);
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0))),
          OutlineButton(
              borderSide: BorderSide(color: ThemePrimary.primaryColor),
              child: new Text(
                textYes,
                style:
                    TextStyle(fontSize: 16, color: ThemePrimary.primaryColor),
              ),
              onPressed: () {
//                result = true;
                Navigator.of(context).pop(true);
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0))),
        ],
      ),
    );
  }

  Future<bool> showMsgDialogWithCloseButton(
    BuildContext context,
    String msg,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          translation.text("POPUP_CONFIRM.TITLE"),
          style: TextStyle(color: ThemePrimary.primaryColor),
        ),
        content: Text(
          msg,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          OutlineButton(
              borderSide: BorderSide(color: ThemePrimary.primaryColor),
              child: new Text(
                translation.text("POPUP_CONFIRM.CLOSE"),
                style:
                    TextStyle(fontSize: 16, color: ThemePrimary.primaryColor),
              ),
              onPressed: () {
//                result = true;
                Navigator.of(context).pop(true);
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(0.0))),
        ],
      ),
    );
  }
}

class LoadingIndicator {
  static Widget spinner({BuildContext context, bool loading}) {
    if (loading)
      return Center(
        // child: SpinKitWave(
        //     color: Theme.of(context).primaryColor, type: SpinKitWaveType.start),
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      );

    return Container();
  }

  static Widget progress(
      {BuildContext context,
      bool loading,
      AlignmentGeometry position = Alignment.topCenter}) {
    if (loading)
      return Align(
        alignment: position,
        // child: SpinKitWave(
        //     color: Theme.of(context).primaryColor, type: SpinKitWaveType.start),
        child: SizedBox(
          height: 0.5,
          child: LinearProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),

          ),
        ),
      );

    return Container();
  }
}

class ToastController {
  static void show({
    BuildContext context,
    String message,
    Duration duration,
  }) {
    Flushbar(
      message: message,
      duration: duration,
      animationDuration: Duration(milliseconds: 300),
      //leftBarIndicatorColor: Colors.blue[300],
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundGradient: LinearGradient(
        colors: [Theme.of(context).primaryColor, Colors.teal],
      ),
      backgroundColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.blue[800],
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }
}

class LoadingSpinner {
  static Widget loadingView({BuildContext context, bool loading}) {
    if (loading)
      return Center(
        // child: SpinKitWave(
        //     color: Theme.of(context).primaryColor, type: SpinKitWaveType.start),
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
      );

    return Container();
  }
}
