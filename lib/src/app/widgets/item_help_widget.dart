import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faq_detail_page.dart';

class ItemHelpWidget extends StatelessWidget {
  final IconData icons;
  final String text;
  final bool showCircle;
  final String iconPath;
  final int categoryId;
  final Color color;

  const ItemHelpWidget({Key key,
    this.icons,
    this.text,
    this.showCircle = false,
    this.iconPath,
    this.categoryId, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: (showCircle
                  ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, FaqDetailPage.routeName,
                      arguments: [categoryId, color, iconPath, text]);
                },
                child: Container(
                    width: 75,
                    height: 75,
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[300]),
                    child: CircleAvatar(
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: iconPath,
                        ),
                    )),
              )
                  : Center(
                child: Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icons,
                        color: Color(0xff999999),
                        size: 32,
                      ),
                      Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ))),
//          Expanded(
//            flex: 1,
//            child: Center(
//              child: Text(
//                text,
//                textAlign: TextAlign.center,
//                style: TextStyle(color: Colors.grey[600]),
//              ),
//            ),
//          )
        ],
      ),
    );
  }
}
