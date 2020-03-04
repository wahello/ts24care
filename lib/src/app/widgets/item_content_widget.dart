//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter/material.dart';
//import 'package:xero_app/src/app/service/common-service.dart';
//
//class ItemProductAndServicesWidget extends StatelessWidget {
//  final int colorStatus;
//  final String title;
//  final double price;
//  final String subTitle;
//  final String currency;
//  final Function onTap;
//  final int count;
//  final double totalPrice;
//  const ItemProductAndServicesWidget(
//      {Key key,
//      this.colorStatus,
//      this.title,
//      this.price,
//      this.subTitle,
//      this.currency,
//      this.onTap,
//      this.count,
//      this.totalPrice})
//      : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return InkWell(
//      onTap: onTap,
//      child: Container(
//        color: Colors.white,
//        width: MediaQuery.of(context).size.width,
//        padding: EdgeInsets.only(top: 10, bottom: 10),
////        height: 60,
////      margin: EdgeInsets.only(left: 15,right: 15),
////        child: ListTile(
////          leading:
//////        Icon(Icons.adjust,color: Colors.blue,),
////          (colorStatus != null)
////              ?
////              Container(
////            margin: EdgeInsets.only(top: 8),
////            width: 10,
////            height: 10,
////            decoration: BoxDecoration(
////              shape: BoxShape.circle,
////              color: Colors.blue,
////            ),
////          )
////              : Container(
////            width: 5,
////            height: 10,
////          ),
////          title: Container(
////            child: Row(
////              mainAxisAlignment: MainAxisAlignment.spaceBetween,
////              children: <Widget>[
////                Text(
////                  title,
////                  style: TextStyle(fontSize: 18),
////                  overflow: TextOverflow.ellipsis,
////                ),
////
////                Text(
////                  content != null ? content : "",
////                  style: TextStyle(fontSize: 18),
////                )
////              ],
////            ),
////          ),
////          subtitle: subTitle != null
////              ? Row(
////            mainAxisAlignment: MainAxisAlignment.spaceBetween,
////            children: <Widget>[
////              Text(
////                subTitle,
////                style: TextStyle(fontSize: 16),
////                overflow: TextOverflow.ellipsis,
////              ),
////              Text(currency != null ? currency : '')
////            ],
////          )
////              : Container(),
////          trailing: content!=null? Icon(
////            Icons.navigate_next,
////            size: 25,
////            color: Colors.grey,
////          ):Container(width: 1,),
////        ),
//        child: Row(
//          children: <Widget>[
//            Expanded(
//              flex: 1,
//              child: (colorStatus != null)
//                  ? Container(
//                      margin: EdgeInsets.only(top: 8),
//                      width: 10,
//                      height: 10,
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        color: Colors.blue,
//                      ),
//                    )
//                  : Container(),
//            ),
//            Expanded(
//              flex: 6,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    title,
//                    style: TextStyle(fontSize: 18),
//                    overflow: TextOverflow.clip,
//                  ),
//                  if (subTitle != null)
//                    Text(
//                      subTitle,
//                      style: TextStyle(fontSize: 16, color: Colors.grey),
//                      overflow: TextOverflow.ellipsis,
//                    ),
//                  if (count != null && count != 0)
//                    Text(
//                      count.toString() + " x " + Common.formatMoney(price),
//                      style: TextStyle(color: Colors.grey),
//                      overflow: TextOverflow.ellipsis,
//                    )
//                ],
//              ),
//            ),
//            Expanded(
//              flex: 3,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: <Widget>[
//                  AutoSizeText(
//                    (price != null) ?Common.formatMoney((count!=null)? totalPrice : price):"",
//                    style: TextStyle(fontSize: 18.0),
//                    maxLines: 1,
//                  ),
//                  if(currency != null)
//                  Text(
//                    currency,
//                    style: TextStyle(color: Colors.grey),
//                  )
//                ],
//              ),
//            ),
//            if (price != null)
//              Container(
//                padding: EdgeInsets.only(left: 3, right: 3),
//                width: 30,
//                alignment: Alignment.center,
//                child: Icon(
//                  Icons.navigate_next,
//                  color: Colors.grey,
//                ),
//              )
//          ],
//        ),
//      ),
//    );
//  }
//}
