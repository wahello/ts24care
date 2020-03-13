import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class TicketNewPage extends StatefulWidget {
  static const String routeName = "/CreateTicketPage";
  @override
  _TicketNewPageState createState() => _TicketNewPageState();
}

class _TicketNewPageState extends State<TicketNewPage> {
  TicketNewPageViewModel viewModel = TicketNewPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorEnd: ThemePrimary.backgroundColor,
        backgroundColorStart: ThemePrimary.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.grey[800],
          ),
          onPressed: () {
            viewModel.onTapBack();
          },
        ),
        title: Text(
          "New Ticket",
          style: TextStyle(color: Colors.grey[800]),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.grey[800],
            ),
            onPressed: () {},
          )
        ],
      );
    }

    Widget _body() {
      Widget __background() {
        return Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Subject",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                    Container(
                      height: 85,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 55,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[350],
                            ),
                            child: Icon(
                              Icons.person_add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "No parameter",
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Today",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Properties",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(color: ThemePrimary.primaryColor, fontSize: 18),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Status",
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange[300],
                          border:
                              Border.all(color: Colors.deepOrange, width: 1.0)),
                      width: 15,
                      height: 15,
                      alignment: Alignment.center,
                      child: Text(
                        "N",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "New",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              ListTile(
                  title: Text(
                    "Assignee",
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                  subtitle: Text(
                    "Unassigned",
                    style: TextStyle(color: Colors.grey),
                  )),
              ListTile(
                  title: Text(
                    "Priority",
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                  subtitle: Text(
                    "_",
                    style: TextStyle(color: Colors.grey),
                  )),
            ],
          ),
        );
      }

      Widget __inputText() {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            bottom: true,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 0.5,
                    color: ThemePrimary.backgroundColor,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Public replay",
                              style: TextStyle(
                                  color: ThemePrimary.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: ThemePrimary.primaryColor,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: ThemePrimary.primaryColor,
                              size: 16,
                            ),
                            Text(
                              "CC",
                              style: TextStyle(
                                  color: ThemePrimary.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter a description",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.image),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(Icons.tag_faces),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }

      return Stack(
        children: <Widget>[__background(), __inputText()],
      );
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