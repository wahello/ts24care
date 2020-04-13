import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';

class ItemNewFeedHorizontalWidget extends StatefulWidget {
  final String url;
  final String title;

  const ItemNewFeedHorizontalWidget({Key key, this.url, this.title})
      : super(key: key);
  @override
  _ItemNewFeedHorizontalWidgetState createState() =>
      _ItemNewFeedHorizontalWidgetState();
}

class _ItemNewFeedHorizontalWidgetState
    extends State<ItemNewFeedHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1.0),
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -1.0),
                    blurRadius: 1.0),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: widget.url != null
                ? CachedNetworkImage(
                    imageUrl: widget.url,
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/default.jpg",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.width * 0.43,
                    ),
                  )
                : Image.asset(
                    "assets/images/default.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: MediaQuery.of(context).size.width * 0.43,
                  ),
          ),
        ),
//        Container(
////          width: MediaQuery.of(context).size.width * 0.3,
//          alignment: Alignment.center,
//          margin: EdgeInsets.all(10),
//          decoration: BoxDecoration(
//            color: Colors.red,
//            borderRadius: BorderRadius.all(Radius.circular(12.0)),
//          ),
//          child: Image.network(widget.url,fit: BoxFit.cover,),
//        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.center,
//          width: MediaQuery.of(context).size.width * 0.3,
//          height: 200,
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}

class ItemNewFeedVerticalWidget extends StatefulWidget {
  final ItemNewFeedModel itemNewFeedModel;

  const ItemNewFeedVerticalWidget({Key key, this.itemNewFeedModel})
      : super(key: key);
  @override
  _ItemNewFeedVerticalWidgetState createState() =>
      _ItemNewFeedVerticalWidgetState();
}

class _ItemNewFeedVerticalWidgetState extends State<ItemNewFeedVerticalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0),
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -1.0),
                      blurRadius: 1.0),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: widget.itemNewFeedModel.avatarUrl != null
                  ? Image.network(
                      widget.itemNewFeedModel.avatarUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.width * 0.33,
                    )
                  : Image.asset(
                      "assets/images/default.jpg",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.width * 0.33,
                    ),
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.33,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.itemNewFeedModel.postDate.substring(
                        0, widget.itemNewFeedModel.postDate.length - 3),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    widget.itemNewFeedModel.title.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    widget.itemNewFeedModel.subTitle.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
