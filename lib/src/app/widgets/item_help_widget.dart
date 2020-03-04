import 'package:flutter/material.dart';

class ItemHelpWidget extends StatelessWidget {
  final IconData icons;
  final String text;
  final bool showCircle;
  const ItemHelpWidget(
      {Key key, this.icons, this.text, this.showCircle = false})
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
                  ? Container(
                      width: 70,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[300]),
                      child: Icon(
                        icons,
                        color: Colors.grey[600],
                        size: 27,
                      ),
                    )
                  : Center(
                      child: Icon(
                        icons,
                        color: Colors.grey[600],
                        size: 32,
                      ),
                    ))),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
