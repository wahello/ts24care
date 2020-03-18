import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/index.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/models/res-partner.dart';

import '../../../app_localizations.dart';

class UserDetailPageViewModel extends ViewModelBase {
  Customer customer;
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();

  Uint8List imagePicker;
  File imageFile;
  dynamic pickImageError;
  String retrieveDataError;

  String errorName;
  String errorPhone;
  String errorAddress;

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode mailFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  UserDetailPageViewModel() {
    createEvent();
  }

  createEvent() {
    nameEditingController.addListener(() => {isValidName()});
    phoneEditingController.addListener(() => {isValidPhone()});
    addressEditingController.addListener(() => {isValidAddress()});
  }

  initData() {
    if (customer != null) {
      nameEditingController.text = customer.name;
      phoneEditingController.text =
          (customer.phone is bool || customer.phone == null)
              ? ''
              : customer.phone.toString();
      addressEditingController.text =
          (customer.contactAddress is bool || customer.contactAddress == null)
              ? ''
              : customer.contactAddress.toString();
    }
  }

  bool isValidPhone() {
    errorPhone = null;
    var resultPhone = Validator.validatePhone(phoneEditingController.text);
    if (resultPhone != null) {
      errorPhone = resultPhone;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidName() {
    errorName = null;
    var resultName = Validator.validateName(nameEditingController.text);
    if (resultName != null) {
      errorName = resultName.toString();
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidAddress() {
    errorAddress = null;
    var result = Validator.validAddress(addressEditingController.text);
    if (result != null) {
      errorAddress = result;
      this.updateState();
      return false;
    } else
      this.updateState();
    return true;
  }

  bool isValidInfo() {
    if (isValidName() &&
        // isValidGender() &&
        isValidPhone() /* && isValidEmail()*/ &&
        isValidAddress()) {
      this.updateState();
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    nameEditingController.dispose();
    phoneEditingController.dispose();
    addressEditingController.dispose();
  }

  updateCustomer(Customer customer) {
    if (customer.name != nameEditingController.text)
      customer.name = nameEditingController.text;
    if (customer.contactAddress != addressEditingController.text)
      customer.contactAddress = addressEditingController.text;
    if (customer.phone != phoneEditingController.text)
      customer.phone = phoneEditingController.text;

    if (imagePicker != null) customer.photo = imagePicker;
  }

  Future<bool> saveCustomer(Customer customer) async {
    print("save profile Customer");
    //this.updateState();
    if (isValidInfo()) {
      if (customer != null) {
        if (nameEditingController.text != "") {
          Customer _customer = Customer();
          updateCustomer(_customer);
          print('address ${_customer.contactAddress}');
          bool result = await updateCustomerSever(_customer);
          if (result) {
            //print('OK OK');
            customer = _customer;
            //print('cus ${customer.name}');
            return true;
          }
        }
      }
    }
    return false;
  }

  Future<bool> updateCustomerSever(Customer customer) async {
    ResPartner resPartner = ResPartner.fromCustomer(customer);
    bool result = await api.updateCustomer(resPartner);
    if (result) {
      customer.photo =
          '$domainApi/web/image?model=res.partner&field=image&id=${customer.id}&${api.sessionId}';
      //await api.getCustomerInfoAfterLogin();
      //api.getTicketOfListChildren();
      return true;
    }
    return false;
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
            toolbarTitle: translation
                .text("COMMON.CROPPER"), //translation.text("COMMON.CROPPER"),
            toolbarColor: Colors.red, //ThemePrimary.primaryColor,
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
}
