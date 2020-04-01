import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/helpdesk-category.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
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
          "Tạo phiếu yêu cầu mới",
          style: TextStyle(color: Colors.grey[800]),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.grey[800],
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
//              Container(
//                decoration: BoxDecoration(
//                    color: viewModel.customPopupMenu.color,
//                    border: Border.all(
//                        color: viewModel.customPopupMenu.color, width: 1.0)),
//                width: 15,
//                height: 15,
//                alignment: Alignment.center,
//                child: Text(
//                  getCharStatusState(viewModel.statusState),
//                  style: TextStyle(
//                      fontSize: 12,
//                      fontWeight: FontWeight.bold,
//                      color: Colors.white),
//                ),
//              ),
//              SizedBox(
//                width: 5,
//              ),
              Text(viewModel.helpDeskCategory.name.toString()),
              SizedBox(
                width: 5,
              ),
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
            return viewModel.listHelpDeskCategory.map((item) {
              return PopupMenuItem<HelpDeskCategory>(
                height: 50,
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
//                    Icon(item.iconData,color: ThemePrimary.primaryColor,),
//                    Container(
//                      decoration: BoxDecoration(
//                          color: item.color,
//                          border: Border.all(color: item.color, width: 1.0)),
//                      width: 15,
//                      height: 15,
//                      alignment: Alignment.center,
//                      child: Text(
//                        getCharStatusState(item.state),
//                        style: TextStyle(
//                            fontSize: 12,
//                            fontWeight: FontWeight.bold,
//                            color: Colors.white),
//                      ),
//                    ),
//                    SizedBox(
//                      width: 10,
//                    ),
                    Text(
                      item.name.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
//                    Text(
//                      "Subject",
//                      style: TextStyle(
//                          color: Colors.grey,
//                          fontSize: 26,
//                          fontWeight: FontWeight.w600),
//                      textAlign: TextAlign.start,
//                    ),
                    TextFormField(
                      controller: viewModel.subjectTextEditingController,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 26,
                          fontWeight: FontWeight.w600),
//                      focusNode: viewModel.nameFocus,
                      decoration: InputDecoration(
//                        border: InputBorder.none,
//                        labelText: translation.text("USER_PROFILE.FULL_NAME"),
//                        labelStyle: __styleTextLabel,
                        hintText: "Tiêu đề",
//                        errorText: viewModel.errorName,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v) {
//f
                      },
                    ),
//                    Container(
//                      height: 85,
//                      width: MediaQuery.of(context).size.width,
//                      child: Row(
//                        children: <Widget>[
//                          Container(
//                            width: 55,
//                            height: 55,
//                            alignment: Alignment.center,
//                            decoration: BoxDecoration(
//                              shape: BoxShape.circle,
//                              color: Colors.grey[350],
//                            ),
//                            child: Icon(
//                              Icons.person_add,
//                              size: 30,
//                              color: Colors.white,
//                            ),
//                          ),
//                          Expanded(
//                            child: ListTile(
//                              title: Text(
//                                "No requester",
//                                style: TextStyle(
//                                    color: Colors.grey[800],
//                                    fontSize: 18,
//                                    fontWeight: FontWeight.bold),
//                              ),
//                              subtitle: Text(
//                                "Today",
//                                style:
//                                    TextStyle(color: Colors.grey, fontSize: 16),
//                              ),
//                            ),
//                          )
//                        ],
//                      ),
//                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Các thuộc tính",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
//                    Text(
//                      "See all",
//                      style: TextStyle(
//                          color: ThemePrimary.primaryColor, fontSize: 18),
//                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  "Trạng thái",
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),
                subtitle: Row(
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
                  ],
                )
//                __buildMenuStatusIcon(onSelected: (customPopupMenu) {
//                  viewModel.onSelectedTicketStatus(customPopupMenu);
//                }),
              ),
              if (viewModel.helpDeskCategory != null)
                ListTile(
                  title: Text(
                    "Dịch vụ",
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  ),
                  subtitle: __buildMenuCategory(onSelected: (helpDeskCategory) {
                    viewModel.onSelectedHelpDeskCategory(helpDeskCategory);
//                  viewModel.onSelectedTicketStatus(customPopupMenu.state);
                  }),
                ),
//              ListTile(
//                  title: Text(
//                    "Assignee",
//                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
//                  ),
//                  subtitle: Text(
//                    "Unassigned",
//                    style: TextStyle(color: Colors.grey),
//                  )),
//              ListTile(
//                  title: Text(
//                    "Priority",
//                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
//                  ),
//                  subtitle: Text(
//                    "_",
//                    style: TextStyle(color: Colors.grey),
//                  )),
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
//          elevation:  30.2,
            //initialValue: viewModel.selectedLanguage,
            onSelected: onSelected,
            //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
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

        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            bottom: true,
            child: Column(
              children: <Widget>[
                Container(
                  height: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    child: Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Row(
//                          children: <Widget>[
//                            Text(
//                              "Trả lời công khai",
//                              style: TextStyle(
//                                  color: ThemePrimary.primaryColor,
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                            IconButton(
//                              icon: Icon(
//                                Icons.arrow_drop_down,
//                                color: ThemePrimary.primaryColor,
//                              ),
//                              onPressed: () {},
//                            )
//                          ],
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Icon(
//                              Icons.add,
//                              color: ThemePrimary.primaryColor,
//                              size: 16,
//                            ),
//                            Text(
//                              "CC",
//                              style: TextStyle(
//                                  color: ThemePrimary.primaryColor,
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.bold),
//                            )
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: viewModel.descriptionEditingController,
                        decoration: InputDecoration(
                          hintText: "Nhập nội dung tại đây...",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                      if (viewModel.listAttachmentModel.length > 0)
                        TS24AddAttachmentWidget(
                          listIdAttachment: viewModel.listAttachmentModel,
                          onCallback: (_) {
                            viewModel.updateState();
                          },
                        ),
                      Row(
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
                      )
                    ],
                  ),
                )
              ],
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
