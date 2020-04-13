import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';

class ItemTicketsWidget extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String title;
  final String content;
  final String time;
  final Color color;

  const ItemTicketsWidget(
      {Key key,
      this.avatarUrl,
      this.name,
      this.title,
      this.content,
      this.time,
      this.color = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 10,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
          ),
          Container(
//          margin: EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(45.0),
              child: avatarUrl != null
                  ? CachedNetworkImage(
                      imageUrl: avatarUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width * 0.33,
                        height: MediaQuery.of(context).size.width * 0.33,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/default.jpg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.33,
                        height: MediaQuery.of(context).size.width * 0.33,
                      ),
                    )
                  : Image.asset(
                      "assets/images/default.jpg",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.width * 0.33,
                    ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
//            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (name != null)
                  Row(
                    children: <Widget>[
                      Text(
                          "${translation.text("TICKET_PAGE.TICKET_NUMBER")} : "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        name,
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          height: 60,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (title != null)
                                Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800]),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (content != null)
                                Text(
                                  content,
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Text(
                                time.toString(),
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
