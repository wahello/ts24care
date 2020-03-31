import 'package:flutter/material.dart';

class ViewImageWidget extends StatelessWidget {
  final String pathImageFile;
  const ViewImageWidget({Key key, this.pathImageFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(pathImageFile,fit: BoxFit.cover,),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black54, shape: BoxShape.circle),
                child: InkWell(
//                          padding: EdgeInsets.all(2),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
