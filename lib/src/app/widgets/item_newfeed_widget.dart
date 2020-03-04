import 'dart:ui';

import 'package:flutter/material.dart';

class ItemNewFeedHorizontalWidget extends StatefulWidget {
  final String url;
  final String title;

  const ItemNewFeedHorizontalWidget({Key key, this.url, this.title}) : super(key: key);
  @override
  _ItemNewFeedHorizontalWidgetState createState() => _ItemNewFeedHorizontalWidgetState();
}

class _ItemNewFeedHorizontalWidgetState extends State<ItemNewFeedHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            widget.url,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.43,
            height: MediaQuery.of(context).size.width * 0.43,
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
          child: Text(widget.title,style: TextStyle(fontSize: 16),maxLines: 2,),
        )
      ],
    );
  }
}

class ItemNewFeedVerticalWidget extends StatefulWidget {
  final String url;
  final String title;

  const ItemNewFeedVerticalWidget({Key key, this.url, this.title}) : super(key: key);
  @override
  _ItemNewFeedVerticalWidgetState createState() => _ItemNewFeedVerticalWidgetState();
}

class _ItemNewFeedVerticalWidgetState extends State<ItemNewFeedVerticalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.network(
              widget.url,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.width * 0.33,
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.width *0.33,
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                  Text("Always-on care, for your device",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  Text("Always-on care, for your device",style: TextStyle(fontSize: 14,color: Colors.grey[500]),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.star,color: Colors.grey[500],),
                      Row(
                        children: <Widget>[
                          Icon(Icons.favorite_border,color: Colors.grey[500],),
                          Text("100",style: TextStyle(fontSize: 14,color: Colors.grey[500]),)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

