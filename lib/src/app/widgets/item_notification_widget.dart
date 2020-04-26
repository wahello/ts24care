import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/onesignal-notification-messages.dart';
import 'package:ts24care/src/app/pages/notification/notification_page_viewmodel.dart';

class ItemNotificationWidget extends StatefulWidget {
//  ItemNotificationWidget({this.notification});

  final OneSignalNotificationMessages notification;

  //final List<ItemNotificationModel> listNotification;
  final Color color;

  const ItemNotificationWidget(
      {Key key, this.notification, this.color = Colors.grey})
      : super(key: key);

  @override
  _ItemNotificationWidgetState createState() => _ItemNotificationWidgetState();
}

class _ItemNotificationWidgetState extends State<ItemNotificationWidget> {
  NotificationPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = ViewModelProvider.of(context);
//    Widget _buildMenuIcon() {
//      return PopupMenuButton<CustomPopupMenu>(
//        child: IconButton(icon: Icon(Icons.more_vert)),
////          elevation:  30.2,
//        //initialValue: viewModel.selectedLanguage,
//        onSelected: (CustomPopupMenu menu) {
//          if (menu.id == 1) {
//            print('Delete');
//            widget.listNotification.remove(widget.notification);
//            viewModel.updateState();
//          }
//        },
//        //offset: Offset(50, viewModel.selectedLanguage.id == 0 ? 50 : 100),
//        itemBuilder: (BuildContext context) {
//          return CustomPopupMenu.listMenu.map((CustomPopupMenu item) {
//            return PopupMenuItem<CustomPopupMenu>(
//              height: 50,
//              value: item,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  Icon(item.iconData),
//                  SizedBox(
//                    width: 10,
//                  ),
//                  Text(
//                    item.title.toString(),
//                    style: TextStyle(fontSize: 14),
//                  )
//                ],
//              ),
//            );
//          }).toList();
//        },
//      );
//    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 10,
            decoration: BoxDecoration(
                color: widget.color,
//                borderRadius: BorderRadius.only(
//                    topLeft: Radius.circular(10),
//                    bottomLeft: Radius.circular(10))
            ),
          ),
//          Container(
////          margin: EdgeInsets.only(left: 10, right: 10),
//            alignment: Alignment.center,
//            width: 50,
//            height: 50,
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(45.0),
//              child: avatarUrl != null
//                  ? CachedNetworkImage(
//                imageUrl: avatarUrl,
//                imageBuilder: (context, imageProvider) => Container(
//                  width: MediaQuery.of(context).size.width * 0.33,
//                  height: MediaQuery.of(context).size.width * 0.33,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      image: imageProvider,
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//                placeholder: (context, url) =>
//                    CircularProgressIndicator(),
//                errorWidget: (context, url, error) => Image.asset(
//                  "assets/images/default.jpg",
//                  fit: BoxFit.cover,
//                  width: MediaQuery.of(context).size.width * 0.33,
//                  height: MediaQuery.of(context).size.width * 0.33,
//                ),
//              )
//                  : Image.asset(
//                "assets/images/default.jpg",
//                fit: BoxFit.cover,
//                width: MediaQuery.of(context).size.width * 0.33,
//                height: MediaQuery.of(context).size.width * 0.33,
//              ),
//            ),
//          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (widget.notification.createDate != null)
                    Text(
                      widget.notification.createDate.toString().substring(0,
                          widget.notification.createDate.toString().length - 3),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
//                Container(
//                  color: Colors.grey,
//                  height: 0.5,
//                  width: MediaQuery.of(context).size.width * 0.7,
//                ),
                  Container(
                    //width: MediaQuery.of(context).size.width * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            height: 60,
                            child: (widget.notification.contents != null)
                                ? Text(
                                    widget.notification.contents,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );

//    return Padding(
//      padding: EdgeInsets.symmetric(vertical: 8),
//      child: Row(
//        children: <Widget>[
//          Container(
//            margin: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
//            alignment: Alignment.center,
//            width: 30,
//            height: 30,
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(8.0),
//              child: Image.network(
//                widget.notification.image,
//                fit: BoxFit.cover,
//                width: MediaQuery.of(context).size.width * 0.33,
//                height: MediaQuery.of(context).size.width * 0.33,
//              ),
//            ),
//          ),
//          Expanded(
//            flex: 3,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                    padding: EdgeInsets.only(top: 10, left: 10),
//                    child: Text(
//                        widget.notification.type +
//                            ' • ' +
//                            widget.notification.time,
//                        style: TextStyle(color: Colors.grey, fontSize: 14))),
//                Padding(
//                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                    child: Text(widget.notification.description,
//                        style: TextStyle(
//                            fontWeight: FontWeight.normal, fontSize: 16)))
//              ],
//            ),
//          ),
////          Expanded(
////            flex: 1,
////            child: Container(
////                padding: EdgeInsets.only(right: 5),
////                alignment: Alignment.centerRight,
////                child: _buildMenuIcon()
//////              IconButton(icon: Icon(Icons.more_vert), onPressed: (){
//////                onEdit();
//////              }),
////                ),
////          )
//        ],
//      ),
//    );
  }
}
