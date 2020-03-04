import 'package:flutter/material.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';

class GroupContentWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final Function tapMore;
  const GroupContentWidget({Key key, this.title,this.child,this.tapMore})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold),
                ),
                (tapMore != null)?
                InkWell(
                  onTap: tapMore,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                    child: Text(
                      "View more",
                      style: TextStyle(
                          fontSize: 16,
                          color: ThemePrimary.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ):Container(),
              ],
            ),
          ),
//          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: child,
          )
        ],
      ),
    );
  }
}
