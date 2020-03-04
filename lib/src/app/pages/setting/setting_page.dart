import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/setting/setting_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class SettingPage extends StatefulWidget {
  static const String routeName = "/SettingsPage";
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  SettingPageViewModel viewModel = SettingPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar(){
      return TS24AppBar(
        backgroundColorStart: Colors.grey[200],
        backgroundColorEnd: Colors.grey[200],
        title: Text("Settings",style: TextStyle(color: Colors.black87),),
        elevation: 1,
      );
    }
    Widget _body(){
      Widget __item({@required String title,String subtitle,IconData iconTrailing}){
        return Column(
          children: <Widget>[
            ListTile(
              title: Text(title,style: TextStyle(color: Colors.grey[800],fontSize: 16),),
              subtitle: subtitle!=null?Text(subtitle,style: TextStyle(color: Colors.grey,fontSize: 14),):null,
              trailing: iconTrailing!=null?Icon(iconTrailing,color: Colors.grey[800],):null,
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              height: 0.5,
              color: Colors.grey[300],
            )
          ],
        );
      }
      return ListView(
        children: <Widget>[
          __item(title: "Notifications",iconTrailing: Icons.navigate_next),
          __item(title: "Leave feedback",iconTrailing: Icons.navigate_next),
          __item(title: "Licenses",iconTrailing: Icons.navigate_next),
          __item(title: "Licenses",iconTrailing: Icons.navigate_next),
          __item(title: "Licenses",iconTrailing: Icons.navigate_next),
          __item(title: "Zendesk support",subtitle: "version 2.2.7",iconTrailing: Icons.navigate_next),
          __item(title: "Sign out"),
        ],
      );
    }
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context,snapshot){
          return TS24Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
