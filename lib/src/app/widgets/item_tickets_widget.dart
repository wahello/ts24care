import 'package:flutter/material.dart';

class ItemTicketsWidget extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String title;
  final String content;
  final String time;

  const ItemTicketsWidget(
      {Key key, this.avatarUrl, this.name, this.title, this.content, this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 10),
          alignment: Alignment.center,
          width: 50,
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(45.0),
            child: avatarUrl != null
                ? Image.network(
                    avatarUrl,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: MediaQuery.of(context).size.width * 0.33,
                  )
                : Image.asset(
                    "assets/images/vegetable_natural.jpg",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: MediaQuery.of(context).size.width * 0.33,
                  ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (name != null)
                  Text(
                    name,
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (title != null)
                  Text(
                    title,
                    style: TextStyle(fontSize: 17),
                    overflow: TextOverflow.ellipsis,
                  ),
                if(content != null)
                Text(content,style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              time.toString(),
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}
