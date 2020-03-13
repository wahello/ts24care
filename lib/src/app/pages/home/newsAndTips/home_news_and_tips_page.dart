import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';
import 'package:ts24care/src/app/pages/home/newsAndTips/home_news_and_tips_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_newfeed_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class NewsAndTipsPage extends StatefulWidget {
  static const String routeName = "/newsAndTipsPage";
  @override
  _NewsAndTipsPageState createState() => _NewsAndTipsPageState();
}

class _NewsAndTipsPageState extends State<NewsAndTipsPage> {
  NewsAndTipsPageViewModel viewModel = NewsAndTipsPageViewModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorEnd: ThemePrimary.backgroundColor,
        backgroundColorStart: ThemePrimary.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          "News and Tips",
          style: TextStyle(color: Colors.black87),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black87,
            ),
          ),
        ],
        bottom: PreferredSize(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "All",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star_half,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Favorites",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
        ),
      );
    }

    Widget _body() {
      return Container(
          color: ThemePrimary.backgroundColor,
          child: ListView(
              itemExtent: 150,
              controller: viewModel.controller,
              children: ItemNewFeedModel.listItemNewFeedModel
                  .map((item) => TS24Button(
                        onTap: (){},
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        alignment: Alignment.center,
                        child: ItemNewFeedVerticalWidget(
                          title: item.title,
                          url: item.url,
                        ),
                      ))
                  .toList()));
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}