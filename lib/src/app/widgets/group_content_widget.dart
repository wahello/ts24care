import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
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
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
                (tapMore != null)?
                InkWell(
                  onTap: tapMore,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Text(
                      translation.text('HELP_PAGE.VIEW_MORE'),
                      style: TextStyle(
                          fontSize: 15,
                          color: ThemePrimary.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ):Container(padding: EdgeInsets.all(15),child: SizedBox(),),
              ],
            ),
          ),
//          SizedBox(height: 5,),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              // change to white old : white white70
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: child,
          )
        ],
      ),
    );
  }
}
