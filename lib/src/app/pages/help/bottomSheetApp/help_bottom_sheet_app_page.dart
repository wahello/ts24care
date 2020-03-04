import 'package:flutter/material.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/pages/help/bottomSheetApp/help_bottom_sheet_app_page_viewmodel.dart';

class BottomSheetAppPage extends StatefulWidget {
  final List<ItemApplicationModel> listItemApplicationModel;
  final Function onTapItem;
  const BottomSheetAppPage({Key key, this.listItemApplicationModel,this.onTapItem}) : super(key: key);
  @override
  _BottomSheetAppPageState createState() => _BottomSheetAppPageState();
}

class _BottomSheetAppPageState extends State<BottomSheetAppPage> {
  BottomSheetAppPageViewModel viewModel = BottomSheetAppPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Text("ALL APPLICATION"),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              padding: EdgeInsets.only(top: 25),
              child: GridView.builder(
                itemCount: widget.listItemApplicationModel.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.0,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap:(){
                      widget.onTapItem(index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              alignment: Alignment.topCenter,
                              child: Image.network(widget.listItemApplicationModel[index].imageLogo),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      widget.listItemApplicationModel[index].name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      widget.listItemApplicationModel[index].description,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
