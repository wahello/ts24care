import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';
import 'package:ts24care/src/app/pages/home/home_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/group_content_widget.dart';
import 'package:ts24care/src/app/widgets/item_newfeed_widget.dart';
import 'package:ts24care/src/app/widgets/ts24BottomScrollWithBackground/ts24_bottom_scroll_with_background_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageViewModel viewModel = HomePageViewModel();
  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "HOME",
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget _body() {
    Widget __content() {
      return SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20,),
                  TS24Button(
                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "Benefit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                  SizedBox(width: 10,),
                  TS24Button(
                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      "Benefit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
              GroupContentWidget(
                title: "New & tip",
                tapMore: () {
                  viewModel.tapMoreNewAndTips();
                },
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  itemCount: ItemNewFeedModel.listItemNewFeedModel.length,
                  itemBuilder: (context, index) =>
//                  Container(color: Colors.red,height: 500,)
                      Container(
                    child: ItemNewFeedHorizontalWidget(
                      title: ItemNewFeedModel.listItemNewFeedModel[index].title,
                      url: ItemNewFeedModel.listItemNewFeedModel[index].url,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return TS24BottomScrollWithBackgroundWidget(
      shadow: false,
      title: "",
      background: Container(
        height: 200,
        child: Swiper(
          itemHeight: 50,
          itemBuilder: (BuildContext context, int index) {
            return new Image.asset(
              "assets/images/vegetable_natural.jpg",
              fit: BoxFit.fitWidth,
            );
          },
          itemCount: 3,
//                          pagination: new SwiperPagination(),
          control: new SwiperControl(color: Colors.transparent),
//                          viewportFraction: 0.4,
//                          scale: 0.2,
        ),
      ),
      child: __content(),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
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
