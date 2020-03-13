
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/user_model.dart';
import 'package:ts24care/src/app/pages/setting/userDetail/setting_user_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';

import '../../../app_localizations.dart';


class UserDetailPage extends StatefulWidget {
  static const String routeName = "/userDetailPage";
  //final Parent parent;
  //ProfilePage(this.parent);
  @override
  UserDetailPageState createState() => UserDetailPageState();
}

class UserDetailPageState extends State<UserDetailPage>{
  UserDetailPageViewModel viewModel = UserDetailPageViewModel();
  @override
  void initState() {
    // TODO: implement initState
    //viewModel.parent = Parent();
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

    Widget _avatar() {
      Widget _initImage() {
        return Image(
          image: (viewModel.user == null && viewModel.imagePicker == null)
              ? AssetImage('assets/images/user.png')
              : (viewModel.user != null && viewModel.imagePicker == null
              ? (viewModel.user.photo == null
              ? AssetImage('assets/images/user.png')
              : NetworkImage(viewModel.user.photo))
              : MemoryImage(viewModel.imagePicker)),
          fit: BoxFit.cover,
        );
        return Image(
          image: NetworkImage("https://bain.design/wp-content/uploads/2013/03/People-Avatar-Set-Rectangular-13.jpg"),
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
            onPressed: () => viewModel.onImageButtonPressed(ImageSource.gallery),
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

    Widget _card(UserModel user) {
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
                        //focusNode: viewModel.nameFocus,
                        decoration: InputDecoration(
                          labelText: translation.text("USER_PROFILE.FULL_NAME"),
                          hintText: user != null
                              ? user.name
                              : translation.text("USER_PROFILE.INPUT_NAME"),
                          //labelStyle: __styleTextLabel,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (v) {
                          //viewModel.fieldFocusChange(context,
                          //   viewModel.nameFocus, viewModel.phoneFocus);
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
                        //focusNode: viewModel.phoneFocus,
                        decoration: InputDecoration(
                          labelText: translation.text("USER_PROFILE.PHONE_NUMBER"),
                          hintText: user != null
                              ? user.phone.toString()
                              : translation.text("USER_PROFILE.INPUT_PHONE"),
                          //labelStyle: __styleTextLabel,
                          //errorText: viewModel.errorPhone,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (v) {
                          //viewModel.fieldFocusChange(context,
                          //    viewModel.phoneFocus, viewModel.addressFocus);
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
                    flex: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        //focusNode: viewModel.addressFocus,
                        controller: viewModel.addressEditingController,
                        decoration: InputDecoration(
                          labelText: translation.text("USER_PROFILE.ADDRESS"),
                          hintText: translation.text("USER_PROFILE.INPUT_ADDRESS"),
                          //labelStyle: __styleTextLabel,
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (v) {
                          //viewModel.addressFocus.unfocus();
                          //viewModel.saveParent(viewModel.parent);
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          //viewModel.onTapPickMaps();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_on,
                            //color: ThemePrimary.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
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
        builder: (context,snapshot){
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
                        _card(viewModel.user),
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
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[500],
                                  offset: Offset(0.0, 1.5),
                                  blurRadius: 1.5,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: () {
                                  //_handleSelectLanguage();
                                  //viewModel.onTapSave();
                                },
                                child: Center(
                                  child: Text(
                                    translation
                                        .text("COMMON.SAVE")
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
          );
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