import 'package:flutter/material.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/pages/help/bottomSheetApp/help_bottom_sheet_app_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';

class BottomSheetAppPage extends StatefulWidget {
  final List<ItemApplicationModel> listItemApplicationModel;
  final Function onTapItem;
  const BottomSheetAppPage(
      {Key key, this.listItemApplicationModel, this.onTapItem})
      : super(key: key);
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
          color: ThemePrimary.backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "Tất cả ứng dụng",
              style: TextStyle(color: ThemePrimary.primaryColor),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              padding: EdgeInsets.only(top: 25),
              child: ListView.builder(
//                itemExtent: 85,
                itemCount: widget.listItemApplicationModel.length,
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 2,
//                  childAspectRatio: 3.0,
//                  crossAxisSpacing: 2,
//                  mainAxisSpacing: 10,
//                ),
                itemBuilder: (context, index) {
                  return TS24Button(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
//                    padding: EdgeInsets.only(top: 20,bottom: 20),
                    height: 80,
                    alignment: Alignment.center,
                    onTap: () {
                      widget.onTapItem(index);
                    },
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Image.network(widget
                                .listItemApplicationModel[index].imageLogo),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.listItemApplicationModel[index].name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    widget.listItemApplicationModel[index]
                                        .description,
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
