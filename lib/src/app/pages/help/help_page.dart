import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/pages/help/help_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/group_content_widget.dart';
import 'package:ts24care/src/app/widgets/item_help_widget.dart';
import 'package:ts24care/src/app/widgets/ts24SlideWidget/ts24_slide_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class HelpPage extends StatefulWidget {
  static const String routeName = "/helpPage";
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with AutomaticKeepAliveClientMixin{
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
        color: ThemePrimary.backgroundColor,
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
                    child: TS24Button(
                      onTap: (){},
                      child: ItemHelpWidget(
                        icons: Icons.phone_in_talk,
                        text: "Call custome service",
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: TS24Button(
                      onTap: (){
                        viewModel.onTapChat();
                      },
                      child: ItemHelpWidget(
                        icons: Icons.chat_bubble,
                        text: "Live chat",
                      ),
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
      backgroundColor: ThemePrimary.backgroundColor,
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
            backgroundColor: ThemePrimary.backgroundColor,
            appBar: _appBar(),
            body: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return;
              },
              child: CustomScrollView(
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
                        background: TS24SlideWidget(
                          listCurrentObject: viewModel.listApplication,
                          listFullObject: ItemApplicationModel.listApplication,
                          onChange: (index) {
                            print(index);
                          },
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
