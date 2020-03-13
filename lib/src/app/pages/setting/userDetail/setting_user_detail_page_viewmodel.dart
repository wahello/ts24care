import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/user_model.dart';

import '../../../app_localizations.dart';

class UserDetailPageViewModel extends ViewModelBase {
  UserModel user;
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();

  int selectedLanguage; // 1 EN, 2 VI
  Uint8List imagePicker;
  File imageFile;
  dynamic pickImageError;
  String retrieveDataError;

  initData() {
    user = UserModel();
    //print('test parent ${parent.email}');
    /*selectedLanguage = (translation.currentLanguage == 'vi') ? 2 : 1;
    if (parent != null) {
      nameEditingController.text = parent.name;
      phoneEditingController.text =
      (parent.phone is bool || parent.phone == null)
          ? ''
          : parent.phone.toString();
      addressEditingController.text =
      (parent.contactAddress is bool || parent.contactAddress == null)
          ? ''
          : parent.contactAddress.toString();
    }*/
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file == null) {
      imageFile = response.file;
      this.updateState();
    }
  }

  void onImageButtonPressed(ImageSource source) async {
    try {
      imageFile = await ImagePicker.pickImage(source: source);
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.original,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio16x9
        ]
            : [
//          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
//          CropAspectRatioPreset.ratio3x2,
//          CropAspectRatioPreset.ratio4x3,
//          CropAspectRatioPreset.ratio5x3,
//          CropAspectRatioPreset.ratio5x4,
//          CropAspectRatioPreset.ratio7x5,
//          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: translation.text("COMMON.CROPPER"),//translation.text("COMMON.CROPPER"),
            toolbarColor: Colors.red,//ThemePrimary.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
      );
      if (croppedFile != null) {
        imageFile = croppedFile;
      }
      readFileByte(imageFile.path).then((bytesData) {
        imagePicker = bytesData;
        this.updateState();
      });
    } catch (e) {
      pickImageError = e;
    }
  }
  // test
  /*onChangeLanguage(String language) async {
    await translation.setNewLanguage(language, true);
    //OneSignalService.sendTags(parent.toJsonOneSignal(language: language));
    RestartWidget.restartApp(context);
  }*/

}