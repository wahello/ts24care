import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_custom_popup_menu.dart';
import 'package:ts24care/src/app/models/item_notification_model.dart';
import 'package:ts24care/src/app/pages/notification/notification_page_viewmodel.dart';

class ItemNotificationWidget extends StatefulWidget {
//  ItemNotificationWidget({this.notification});

  final ItemNotificationModel notification;
  final List<ItemNotificationModel> listNotification;

  const ItemNotificationWidget(
      {Key key, this.notification, this.listNotification})
      : super(key: key);

  @override
  _ItemNotificationWidgetState createState() => _ItemNotificationWidgetState();
}

class _ItemNotificationWidgetState extends State<ItemNotificationWidget> {
  NotificationPageViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    viewModel = ViewModelProvider.of(context);

    Widget _buildMenuIcon() {
      return PopupMenuButton<CustomPopupMenu>(
        child: IconButton(icon: Icon(Icons.more_vert)),
//          elevation:  30.2,
        //initialValue: viewModel.selectedLanguage,
        onSelected: (CustomPopupMenu menu) {
          if (menu.id == 1) {
            print('Delete');
            widget.listNotification.remove(widget.notification);
            viewModel.updateState();
          }
        },
        //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
        itemBuilder: (BuildContext context) {
          return CustomPopupMenu.listMenu.map((CustomPopupMenu item) {
            return PopupMenuItem<CustomPopupMenu>(
              height: 50,
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  item.icon,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.title.toString(),
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            );
          }).toList();
        },
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            alignment: Alignment.center,
            width: 30,
            height: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.notification.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.33,
                height: MediaQuery.of(context).size.width * 0.33,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                        widget.notification.type +
                            ' • ' +
                            widget.notification.time,
                        style: TextStyle(color: Colors.grey, fontSize: 14))),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(widget.notification.description,
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 16)))
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(right: 5),
                alignment: Alignment.centerRight,
                child: _buildMenuIcon()
//              IconButton(icon: Icon(Icons.more_vert), onPressed: (){
//                onEdit();
//              }),
                ),
          )
        ],
      ),
    );
  }
}
