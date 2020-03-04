import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/help/help_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/group_content_widget.dart';
import 'package:ts24care/src/app/widgets/item_help_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
class HelpPage extends StatefulWidget {
  static const String routeName = "/helpPage";
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  HelpPageViewModel viewModel = HelpPageViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final _style = TextStyle(
    fontSize: 16,
  );
  Widget _body() {
    return SingleChildScrollView(

      child: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            GroupContentWidget(
              title: "FAQ",
              tapMore: () {
                viewModel.onTapFAQ();
              },
              child: Text(
                "Where are my photo and video files save?",
                style: _style,
              ),
            ),
            GroupContentWidget(
                title: "Feedback",
                tapMore: () {
                  viewModel.onTapFeedback();
                },
                child: Column(
                  children: <Widget>[
                    Text(
                      "Send your feedback and get your answers to your questions ringh away?",
                      style: _style,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Send Feedback",
                        style: TextStyle(
                            fontSize: _style.fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            Container(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ItemHelpWidget(
                      icons: Icons.phone_in_talk,
                      text: "Call custome service",
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: ItemHelpWidget(
                      icons: Icons.chat_bubble,
                      text: "Live chat",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.grey[200],
      elevation: 0,
      title: Text(
        "Help",
        style: TextStyle(color: Colors.black87),
      ),
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
            backgroundColor: Colors.grey[200],
            appBar: _appBar(),
//            body: _body(),
            body:  NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child:
               CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 220.0,
                  floating: false,
                  pinned: false,
                  snap: false,
                  elevation: 50,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Stack(
                        children: <Widget>[
                          Container(
                            color: Colors.grey[200],
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(bottom: 110),
                            child: Swiper(
                              onIndexChanged: viewModel.onIndexChanged,
                              layout: SwiperLayout.DEFAULT,
                              itemWidth: 50,
                              itemHeight: 50,
                              controller: viewModel.controller,
                              outer: true,
                              loop: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: index == viewModel.indexCurrent
                                              ? Colors.blue
                                              : Colors.black26)),
                                  child: 
//                                  Icon(
//                                    Icons.phone_iphone,
//                                    size: 65,
//                                  ),
                                  Image.network(viewModel.listApplication[index].imageLogo,height: 60,width: 60,fit: BoxFit.cover,)
                                );
                              },
                              itemCount: viewModel.listApplication.length,
//                              pagination: new SwiperPagination(),
                              control:
                                  new SwiperControl(color: Colors.transparent,disableColor: Colors.transparent),
                              viewportFraction: 0.3,
                              scale: 0.2,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 120,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
                              color: Colors.grey[200],
                              alignment: Alignment.center,
                              child: Text(
                                viewModel.listApplication[viewModel.indexCurrent].name,
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 170,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 35,
//                              color: Colors.yellow,
                              padding: EdgeInsets.only(left: 25, right: 25),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    onTap:(){
                                      viewModel.onTapAll();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(Icons.list,
                                              color: Colors.grey[800]),
                                          Text(
                                            "All",
                                            style: TextStyle(
                                                color: Colors.grey[800]),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[600],
                                              width: 2.0),
//                                        color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      viewModel.onTapAdd();
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 30,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Icon(Icons.add,
                                              color: Colors.grey[800]),
                                          Text(
                                            "Add",
                                            style: TextStyle(
                                                color: Colors.grey[800]),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[600],
                                              width: 2.0),
//                                        color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                new SliverList(
                    delegate: new SliverChildListDelegate([_body()])),
              ],
            ),
            ),

          );
        },
      ),
    );
  }
}
