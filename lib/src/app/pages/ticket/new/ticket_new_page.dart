import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/models/wk-team.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_add_attachment_widget.dart';
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
      return AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
//            color: Colors.white,
          ),
          onPressed: () {
            viewModel.onTapBack();
          },
        ),
        title: Text(
          translation.text("TICKET_NEW_PAGE.TITLE"),
//          style: TextStyle(color: Colors.grey[800]),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
//              color: ThemePrimary.primaryColor,
            ),
            onPressed: () {
              viewModel.onSend();
            },
          )
        ],
      );
    }

    Widget _body() {
      Widget __buildMenuStatusIcon(
          {void onSelected(CustomPopupMenu customPopupMenu)}) {
        return PopupMenuButton<CustomPopupMenu>(
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: viewModel.customPopupMenu.color,
                    border: Border.all(
                        color: viewModel.customPopupMenu.color, width: 1.0)),
                width: 15,
                height: 15,
                alignment: Alignment.center,
                child: Text(
                  getCharStatusState(viewModel.customPopupMenu.state),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(viewModel.customPopupMenu.title.toString()),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
              )
            ],
          ),
//          elevation:  30.2,
          //initialValue: viewModel.selectedLanguage,
          onSelected: onSelected,
          //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
          itemBuilder: (BuildContext context) {
            return CustomPopupMenu.listTicketStatus.map((CustomPopupMenu item) {
              return PopupMenuItem<CustomPopupMenu>(
                height: 50,
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
//                    Icon(item.iconData,color: ThemePrimary.primaryColor,),
                    Container(
                      decoration: BoxDecoration(
                          color: item.color,
                          border: Border.all(color: item.color, width: 1.0)),
                      width: 15,
                      height: 15,
                      alignment: Alignment.center,
                      child: Text(
                        getCharStatusState(item.state),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      item.title.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    )
                  ],
                ),
              );
            }).toList();
          },
        );
      }

      Widget __buildMenuCategory(
          {void onSelected(HelpDeskCategory helpDeskCategory)}) {
        return PopupMenuButton<HelpDeskCategory>(
          child: Row(
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  child: Text(
                    viewModel.helpDeskCategory.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  )),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
              )
            ],
          ),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            return viewModel.listHelpDeskCategory.map((item) {
              return PopupMenuItem<HelpDeskCategory>(
                height: 50,
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    )
                  ],
                ),
              );
            }).toList();
          },
        );
      }

      Widget __buildMenuSupportTeam({void onSelected(WkTeam supportTeam)}) {
        return PopupMenuButton<WkTeam>(
          child: Row(
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.65,
                  ),
                  child: Text(
                    viewModel.supportTeam.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  )),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
              )
            ],
          ),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            return viewModel.listSupportTeam.map((item) {
              return PopupMenuItem<WkTeam>(
                height: 50,
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    )
                  ],
                ),
              );
            }).toList();
          },
        );
      }

      Widget __background() {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translation.text("TICKET_NEW_PAGE.INPUT_TITLE"),
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      controller: viewModel.subjectTextEditingController,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          hintText:
                              translation.text("TICKET_NEW_PAGE.HINT_TITLE"),
                          errorText: viewModel.errorSubject,
                          focusColor: Colors.black,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ))),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v) {
//f
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      translation.text("TICKET_NEW_PAGE.REQUIRE_SUPPORT"),
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
//              ListTile(
//                  title: Text(
//                    translation.text("TICKET_NEW_PAGE.STATUS"),
//                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
//                  ),
//                  subtitle: Row(
//                    children: <Widget>[
//                      Container(
//                        decoration: BoxDecoration(
//                            color: viewModel.customPopupMenu.color,
//                            border: Border.all(
//                                color: viewModel.customPopupMenu.color,
//                                width: 1.0)),
//                        width: 15,
//                        height: 15,
//                        alignment: Alignment.center,
//                        child: Text(
//                          getCharStatusState(viewModel.customPopupMenu.state),
//                          style: TextStyle(
//                              fontSize: 12,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.white),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5,
//                      ),
//                      Text(viewModel.customPopupMenu.title.toString()),
//                    ],
//                  )),

              if (viewModel.supportTeam != null)
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                      Text(
//                        translation.text("TICKET_DETAIL_PAGE.SERVICE"),
//                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
//                      ),
                      __buildMenuSupportTeam(
                          onSelected: viewModel.onSelectedTeam
//                  viewModel.onSelectedTicketStatus(customPopupMenu.state);
                          ),
                      if (viewModel.errorRequest != null)
                        Text(
                          viewModel.errorRequest,
                          style: TextStyle(color: Colors.red),
                        )
                    ],
                  ),
                ),
              if (viewModel.helpDeskCategory != null)
                Container(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        translation.text("TICKET_NEW_PAGE.PROPERTIES"),
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              if (viewModel.helpDeskCategory != null)
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
//                      Text(
//                        translation.text("TICKET_DETAIL_PAGE.SERVICE"),
//                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
//                      ),
                      __buildMenuCategory(onSelected: (helpDeskCategory) {
                        viewModel.onSelectedHelpDeskCategory(helpDeskCategory);
//                  viewModel.onSelectedTicketStatus(customPopupMenu.state);
                      }),
                      if (viewModel.errorService != null)
                        Text(
                          viewModel.errorService,
                          style: TextStyle(color: Colors.red),
                        )
                    ],
                  ),
                ),
            ],
          ),
        );
      }

      Widget __inputText() {
        Widget ___buildMenuIcon(
            {IconData iconData,
            void onSelected(CustomPopupMenu customPopupMenu)}) {
          return PopupMenuButton<CustomPopupMenu>(
            child: IconButton(
              icon: Icon(
                Icons.attach_file,
                color: ThemePrimary.primaryColor,
              ),
            ),
            onSelected: onSelected,
            itemBuilder: (BuildContext context) {
              return CustomPopupMenu.listMenuAttachment
                  .map((CustomPopupMenu item) {
                return PopupMenuItem<CustomPopupMenu>(
                  height: 50,
                  value: item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        item.iconData,
                        color: ThemePrimary.primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        item.title.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      )
                    ],
                  ),
                );
              }).toList();
            },
          );
        }

        return Column(
          children: <Widget>[
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            Expanded(
              child: Container(
//                color: Colors.red,
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 14,
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          TextField(
                              controller: viewModel.descriptionEditingController,
                              decoration: InputDecoration(
                                hintText:
                                translation.text("TICKET_NEW_PAGE.HINT_INPUT_TEXT"),
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: null//viewModel.listAttachmentModel.length > 0 ? 3 : 7,
                          ),

//                  Container(height: 1,color: Colors.grey,width: MediaQuery.of(context).size.width,),

                        ],
                      ),
                    ),
                    if (viewModel.listAttachmentModel.length > 0)
                      TS24AddAttachmentWidget(
                        listIdAttachment: viewModel.listAttachmentModel,
                        onCallback: (_) {
                          viewModel.updateState();
                        },
                      ),
                    if (viewModel.listAttachmentModel.length > 0)
                      SizedBox(
                        height: 10,
                      ),
                    Container(
                      child: Text(
                        translation.text("TICKET_NEW_PAGE.ATTACH_FILE"),
                        style: TextStyle(color: Colors.grey),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              ___buildMenuIcon(
                                  iconData: Icons.attach_file,
                                  onSelected: (customPopupMenu) {
                                    viewModel.onSelectedAttachment(
                                        customPopupMenu.state);
                                  }),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  viewModel.onSelectedCamera();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: ThemePrimary.primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
//                          IconButton(
//                            icon: Icon(Icons.tag_faces),
//                          ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
//                      IconButton(
//                        icon: Icon(Icons.thumb_up),
//                      )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }

      return SingleChildScrollView(
        reverse: true,
        child: (MediaQuery.of(context).orientation == Orientation.portrait)
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    AppBar().preferredSize.height,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: __background()),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          AppBar().preferredSize.height - 250,
                        child: __inputText())
                  ],
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(height: 250, child: __background()),
                    Container(height: 300, child: __inputText())
                  ],
                ),
              ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
//            resizeToAvoidBottomPadding: true,
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
