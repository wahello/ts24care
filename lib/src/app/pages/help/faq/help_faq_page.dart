import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_help_model.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/group_content_widget.dart';
import 'package:ts24care/src/app/widgets/item_help_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class FAQPage extends StatefulWidget {
  static const String routeName = "/FAQpage";
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  FAQPageViewModel viewModel = FAQPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorStart: ThemePrimary.backgroundColor,
        backgroundColorEnd: ThemePrimary.backgroundColor,
        title: Text(
          "FAQ",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
          )
        ],
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            GroupContentWidget(
              title: "FAQ",
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                itemCount: ItemHelpModel.listItemHelpModel.length,
                itemBuilder: (context, index) =>
//                  Container(color: Colors.red,height: 500,)
                    Container(
//                  height: 30,
//                  width: 20,
//                  color: Colors.red,
                  child: ItemHelpWidget(
                    showCircle: true,
                    icons: ItemHelpModel.listItemHelpModel[index].icon,
                    text: ItemHelpModel.listItemHelpModel[index].textName,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            backgroundColor: ThemePrimary.backgroundColor,
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
