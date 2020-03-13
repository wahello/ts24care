import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';

import '../../../app_localizations.dart';
import 'settings_feedback_viewmodel.dart';

class SettingsFeedbackPage extends StatefulWidget {
  static const String routeName = "/feedBackPage";
  @override
  SettingsFeedbackPageState createState() => SettingsFeedbackPageState();
}

class SettingsFeedbackPageState extends State<SettingsFeedbackPage>{
  SettingsFeedbackPageViewModel viewModel = SettingsFeedbackPageViewModel();


  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
          stream: viewModel.stream,
          builder: (context, snapshot){
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 1,
                backgroundColor: Colors.white,
                title: Text(translation.text("SETTINGS_FEEDBACK_PAGE.TITLE"), style: TextStyle(color: Colors.black),),
                iconTheme: new IconThemeData(color: Colors.black),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.check),
                  )
                ],
              ),
              body: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              translation.text("SETTINGS_FEEDBACK_PAGE.I'M_TELLING_YOU_ABOUT"),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              //textAlign: TextAlign.left,
                            ),
                          )
                      ),
                      Row(
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            groupValue: viewModel.radioValue,
                            onChanged: viewModel.handleRadioValueChange,
                          ),
                          new Text(
                            translation.text("SETTINGS_FEEDBACK_PAGE.A_BUG"),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          new Radio(
                            value: 2,
                            groupValue: viewModel.radioValue,
                            onChanged:  viewModel.handleRadioValueChange,
                          ),
                          new Text(
                            translation.text("SETTINGS_FEEDBACK_PAGE.AN_ENHANCEMENT"),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          new Radio(
                            value: 3,
                            groupValue: viewModel.radioValue,
                            onChanged:  viewModel.handleRadioValueChange,
                          ),
                          new Text(
                            translation.text("SETTINGS_FEEDBACK_PAGE.KUDOS"),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              translation.text("SETTINGS_FEEDBACK_PAGE.DETAILS"),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              //textAlign: TextAlign.left,
                            ),
                          )
                      ),
                      new Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 150.0,
                          child: new TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: translation.text("SETTINGS_FEEDBACK_PAGE.PLEASE_TELL_US_THE_DETAILS"),
                              ),
                              style: new TextStyle(
                                  color: Colors.black
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              translation.text("SETTINGS_FEEDBACK_PAGE.HOW_ARE_WE_DOING"),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              //textAlign: TextAlign.left,
                            ),
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 50),
                          child: RatingBar(
                            initialRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemPadding: EdgeInsets.symmetric(horizontal: 15.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.blueAccent,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
    // TODO: implement build

  }
}
