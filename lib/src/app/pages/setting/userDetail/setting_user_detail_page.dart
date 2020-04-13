import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/customer.dart';
import 'package:ts24care/src/app/pages/setting/userDetail/setting_user_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

import '../../../app_localizations.dart';

class UserDetailPage extends StatefulWidget {
  static const String routeName = "/userDetailPage";
  final Customer customer;

  UserDetailPage(this.customer);

  @override
  UserDetailPageState createState() => UserDetailPageState();
}

class UserDetailPageState extends State<UserDetailPage> {
  UserDetailPageViewModel viewModel = UserDetailPageViewModel();

  @override
  void initState() {
    // TODO: implement initState
    viewModel.customer = Customer();
    //viewModel.imagePicker = widget.parent.photo;
    viewModel.initData();
//    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
//      viewModel.scrollController.animateTo(
//          viewModel.scrollController.position.maxScrollExtent,
//          duration: Duration(milliseconds: 200),
//          curve: Curves.easeOut);
//    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    print('1 ${viewModel.customer.contactAddress.toString().length}');
    print('2 ${viewModel.customer.contactAddress is bool || viewModel.customer.contactAddress == null}');
    final __styleTextLabel = TextStyle(
        color: ThemePrimary.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16);

    Widget _avatar() {
      Widget _initImage() {
        // return Image(
        //   image: viewModel.parent == null
        //       ? AssetImage('assets/images/user.png')
        //       : MemoryImage(viewModel.imagePicker),
        //   fit: BoxFit.cover,
        // );
        return Image(
          image: (viewModel.customer == null && viewModel.imagePicker == null)
              ? AssetImage('assets/images/user.png')
              : (viewModel.customer != null && viewModel.imagePicker == null
                  ? (viewModel.customer.photo == null
                      ? AssetImage('assets/images/user.png')
                      : NetworkImage(viewModel.customer.photo))
                  : MemoryImage(viewModel.imagePicker)),
          fit: BoxFit.cover,
        );
      }

      Widget _resultImage() {
        final Text retrieveError = _getRetrieveErrorWidget();
        if (retrieveError != null) {
          return retrieveError;
        }
        if (viewModel.imageFile != null) {
          return Image(
            image: MemoryImage(viewModel.imagePicker),
            fit: BoxFit.cover,
          );
        } else if (viewModel.pickImageError != null) {
          return Text(
            'Pick image error: $viewModel.pickImageError',
            textAlign: TextAlign.center,
          );
        } else {
          return _initImage();
        }
      }

      final __editBtn = Positioned(
        bottom: 5.0,
        right: 5,
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.2),
          ),
          child: IconButton(
            icon: Icon(Icons.edit, size: 30, color: Colors.white),
            onPressed: () =>
                viewModel.onImageButtonPressed(ImageSource.gallery),
            iconSize: 20.0,
          ),
        ),
      );
      return Stack(
        children: <Widget>[
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            child: Platform.isAndroid
                ? FutureBuilder<void>(
                    future: viewModel.retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return _initImage();
                        case ConnectionState.done:
                          return _resultImage();
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return _initImage();
                          }
                      }
                    },
                  )
                : (_resultImage()),
          ),
          __editBtn,
        ],
      );
    }

    Widget _backButton() {
      return Positioned(
        top: 0,
        left: 0,
        child: SafeArea(
          top: true,
          bottom: false,
          child: TS24Button(
            onTap: () {
              Navigator.of(context).pop();
            },
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topRight: Radius.circular(25)),
              color: Colors.black38,
            ),
            width: 70,
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget _card(Customer customer) {
      return Container(
        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: viewModel.nameEditingController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        focusNode: viewModel.nameFocus,
                        decoration: InputDecoration(
                          labelText: translation.text("USER_PROFILE.FULL_NAME"),
                          hintText: customer != null
                              ? customer.name
                              : translation.text("USER_PROFILE.INPUT_NAME"),
                          labelStyle: __styleTextLabel,
                          errorText: viewModel.errorName,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.black, width: 0.25)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: ThemePrimary.primaryColor, width: 1)),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          viewModel.fieldFocusChange(context,
                              viewModel.nameFocus, viewModel.phoneFocus);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: viewModel.phoneEditingController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        focusNode: viewModel.phoneFocus,
                        decoration: InputDecoration(
                          labelText:
                              translation.text("USER_PROFILE.PHONE_NUMBER"),
                          hintText: customer != null
                              ? customer.phone.toString()
                              : translation.text("USER_PROFILE.INPUT_PHONE"),
                          labelStyle: __styleTextLabel,
                          errorText: viewModel.errorPhone,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.black, width: 0.25)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: ThemePrimary.primaryColor, width: 1)),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (v) {
                          viewModel.phoneFocus.unfocus();
                          viewModel.saveCustomer(viewModel.customer);
//                          viewModel.fieldFocusChange(context,
//                              viewModel.phoneFocus, viewModel.addressFocus);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
//            SizedBox(height: 15.0),
//            Container(
//              width: MediaQuery.of(context).size.width,
//              child: Row(
//                children: <Widget>[
//                  Flexible(
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: TextFormField(
//                        focusNode: viewModel.mailFocus,
//                        controller: viewModel.emailEditingController,
//                        decoration: InputDecoration(
//                            labelText: translation.text("USER_PROFILE.EMAIL"),
//                            labelStyle: __styleTextLabel,
//                            hintText: parent != null
//                                ? parent.email
//                                : translation.text("USER_PROFILE.INPUT_EMAIL"),
//                            errorText: viewModel.errorEmail),
//                        textInputAction: TextInputAction.next,
//                        keyboardType: TextInputType.text,
//                        onFieldSubmitted: (v){
//                          viewModel.fieldFocusChange(context, viewModel.mailFocus, viewModel.addressFocus);
//                        },
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          enabled: false,
                          focusNode: viewModel.addressFocus,
                          controller: viewModel.addressEditingController,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          decoration: InputDecoration(
                              labelText:
                              translation.text("USER_PROFILE.ADDRESS"),
                              labelStyle: __styleTextLabel,
                              errorText: viewModel.errorAddress),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          enabled: false,
                          controller: viewModel.tinEditingController,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          decoration: InputDecoration(
                              labelText:
                                  translation.text("USER_PROFILE.TIN"),
                              labelStyle: __styleTextLabel,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          enabled: false,
                          //focusNode: viewModel.addressFocus,
                          controller: viewModel.mailEditingController,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          decoration: InputDecoration(
                              labelText:
                              translation.text("USER_PROFILE.EMAIL"),
                              labelStyle: __styleTextLabel,
                              //errorText: viewModel.errorAddress
                          ),
//                          textInputAction: TextInputAction.done,
//                          keyboardType: TextInputType.text
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                          enabled: false,
                          controller: viewModel.companyEditingController,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          decoration: InputDecoration(
                            labelText: translation.text("USER_PROFILE.COMPANY"),
                            hintText: translation.text("USER_PROFILE.COMPANY"),
                            labelStyle: __styleTextLabel,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    // TODO: implement build
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
              body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                //controller: viewModel.scrollController,
                reverse: true,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: Stack(
                        children: <Widget>[
                          _avatar(),
                          _backButton(),
                        ],
                      ),
                    ),
                    _card(viewModel.customer),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: ThemePrimary.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[500],
                            offset: Offset(0.0, 1.5),
                            blurRadius: 1.5,
                          ),
                        ],
                        //borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () async {
                              LoadingDialog.showLoadingDialog(context,
                                  translation.text("COMMON.IN_PROCESS"));
                              viewModel
                                  .saveCustomer(viewModel.customer)
                                  .then((v) {
                                if (v) {
                                  LoadingDialog.hideLoadingDialog(context);
                                  Navigator.pop(context);
                                } else {
                                  LoadingDialog.hideLoadingDialog(context);
//                                      Navigator.pop(context);
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                translation.text("COMMON.SAVE").toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ));
        },
      ),
    );
  }

//  void _handleSelectLanguage() {
//    viewModel.selectedLanguage = viewModel.selectedLanguage == 1 ? 2 : 1;
//    print('lang ${viewModel.selectedLanguage}');
//    viewModel.onChangeLanguage(viewModel.selectedLanguage == 1 ? 'en' : 'vi');
//  }
  Text _getRetrieveErrorWidget() {
    if (viewModel.retrieveDataError != null) {
      final Text result = Text(viewModel.retrieveDataError);
      viewModel.retrieveDataError = null;
      return result;
    }
    return null;
  }
}
