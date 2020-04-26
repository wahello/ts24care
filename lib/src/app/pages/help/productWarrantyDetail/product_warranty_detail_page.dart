import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/product-warranty.dart';
import 'package:ts24care/src/app/pages/help/productWarrantyDetail/product_warranty_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class ProductWarrantyDetailPage extends StatefulWidget {
  static const String routeName = "/productWarrantyDetail";
  final ProductWarranty productWarranty;

  ProductWarrantyDetailPage({this.productWarranty});

  @override
  _ProductWarrantyDetailPageState createState() =>
      _ProductWarrantyDetailPageState();
}

class _ProductWarrantyDetailPageState extends State<ProductWarrantyDetailPage> {
  ProductWarrantyDetailPageViewModel viewModel =
      ProductWarrantyDetailPageViewModel();

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        translation.text("WANRRANTY_DETAIL_PAGE.TITLE"),
      ),
    );
  }

  Widget _body() {
    var todayDate,
        endDate,
        dateFormat,
        dateFormatOk,
        stringDateRemain,
        inDays = 0;
    if (!(viewModel.productWarranty.warrantyEndDate is bool)) {
      todayDate = DateTime.now();
      endDate = DateTime.parse(viewModel.productWarranty.warrantyEndDate);
      dateFormat =
          viewModel.productWarranty.warrantyEndDate.toString().split("-");
      dateFormatOk = dateFormat[2].toString() +
          '-' +
          dateFormat[1].toString() +
          '-' +
          dateFormat[0].toString();
      inDays = endDate.difference(todayDate).inDays;
      print(inDays.toString());
      stringDateRemain =
          '${inDays <= 0 ? translation.text("WANRRANTY_DETAIL_PAGE.DATE_EXPIRED") : inDays > 30 ? dateFormatOk : inDays.toString() + ' ' + translation.text("WANRRANTY_DETAIL_PAGE.DATE_STRING")}';
    } else {
      inDays = null;
      print(viewModel.productWarranty.warrantyEndDate);
    }
    Widget __warrantyDetailItem({title, value}) {
      return Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text(
                  title,
                  style: TextStyle(color: Color(0xff999999)),
                  textAlign: TextAlign.start,
                ),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: SelectableText(
                    '${value == null || value == false ? translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA") : value}',
                    style: TextStyle(
                        color: Color(
                          0xff999999,
                        ),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  )),
            ],
          ));

//      Container(
//          width: double.infinity,
//          padding: EdgeInsets.all(3),
//          child: ListTile(
//            leading: Text(
//              title,
//              style: TextStyle(color: Color(0xff999999)),
//            ),
//            trailing: SelectableText(
//              '${value == null || value == false ? translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA") : value} ',
//              style: TextStyle(color: Color(0xff999999)),
//            ),
//          ));
    }

    Widget __divider() {
      return Divider(
        indent: 20,
        endIndent: 20,
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
//          decoration: BoxDecoration(image: decorationImageBackground()),
          decoration: BoxDecoration(
              color: ThemePrimary.backgroundPrimaryColor
          ),
        ),
        SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        '${translation.text("WANRRANTY_DETAIL_PAGE.CUSTOMER_INFO")}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  __warrantyDetailItem(
                      title: translation.text('WANRRANTY_DETAIL_PAGE.CUSTOMER'),
                      value: viewModel.productWarranty.partnerId[1]),
                  __divider(),
                  __warrantyDetailItem(
                      title: translation.text('WANRRANTY_DETAIL_PAGE.PHONE'),
                      value: viewModel.productWarranty.phone),
                  __divider(),
                  __warrantyDetailItem(
                      title: translation.text('WANRRANTY_DETAIL_PAGE.EMAIL'),
                      value: viewModel.productWarranty.email),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),

//              PRODUCT
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text(
                        "${translation.text('WANRRANTY_DETAIL_PAGE.SERVICE_INFO')}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff666666),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  __warrantyDetailItem(
                      title: translation
                          .text('WANRRANTY_DETAIL_PAGE.NAME_SERVICE'),
                      value: viewModel.productWarranty.name),

//                  Container(
//                      width: double.infinity,
////
//                      child: ListTile(
//                        leading: Text(
//                            '${translation.text('WANRRANTY_DETAIL_PAGE.DATE_REMAINING')}',
//                            style: TextStyle(color: Color(0xff999999))),
//                        trailing: SelectableText(
//                          viewModel.productWarranty.warrantyEndDate is bool
//                              ? "Không xác định"
//                              : '$stringDateRemain',
//                          style: TextStyle(
//                              color: viewModel.productWarranty.warrantyEndDate
//                                      is bool
//                                  ? Color(0xff999999)
//                                  : inDays <= 0
//                                      ? Colors.red
//                                      : Color(0xff999999)),
//                        ),
//                      )),
                  __divider(),
//                  __warrantyDetailItem(
//                      title: translation.text('WANRRANTY_DETAIL_PAGE.SERIAL'),
//                      value: viewModel.productWarranty.productSerialId[1]),
//                  __divider(),
                  __warrantyDetailItem(
                      title: translation.text('WANRRANTY_DETAIL_PAGE.LICENSE'),
                      value: viewModel.productWarranty.modelNo),
                  // change 17/4/2020
                  __divider(),
                  __warrantyDetailItem(
                      title:
                          translation.text('WANRRANTY_DETAIL_PAGE.START_DAY'),
                      value: DateFormat("dd-MM-yyyy").format(DateTime.parse(
                          viewModel.productWarranty.warrantyCreateDate))),
                  __divider(),
                  __warrantyDetailItem(
                      title: translation.text('WANRRANTY_DETAIL_PAGE.END_DAY'),
//                    DateFormat("dd-MM-yyyy").format(DateTime.parse(viewModel.productWarranty.warrantyCreateDate))
                      value: viewModel.productWarranty.warrantyEndDate is bool
                          ? null
                          : DateFormat("dd-MM-yyyy").format(DateTime.parse(
                              viewModel.productWarranty.warrantyEndDate))),

                  inDays != null ? __divider() : Offstage(),

                  inDays != null
                      ? inDays <= 30
                          ? Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      '${translation.text('WANRRANTY_DETAIL_PAGE.DATE_REMAINING')}',
                                      style:
                                          TextStyle(color: Color(0xff999999)),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Flexible(
                                      fit: FlexFit.tight,
                                      flex: 1,
                                      child: SelectableText(
                                        viewModel.productWarranty
                                                .warrantyEndDate is bool
                                            ? "${translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA")}"
                                            : '$stringDateRemain',
                                        style: TextStyle(
                                            color: viewModel.productWarranty
                                                    .warrantyEndDate is bool
                                                ? Color(0xff999999)
                                                : inDays <= 0
                                                    ? Colors.red
                                                    : Color(0xff999999),
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      )),
                                ],
                              ))
                          : Offstage()
                      : Offstage(),

//                  inDays <= 30 && endDate != null ? Container(
//                      padding: EdgeInsets.all(15),
//                      child: Row(
//                        children: <Widget>[
//                          Flexible(
//                            flex: 1,
//                            fit: FlexFit.tight,
//                            child: Text(
//                              '${translation.text('WANRRANTY_DETAIL_PAGE.DATE_REMAINING')}',
//                              style: TextStyle(color: Color(0xff999999)),
//                              textAlign: TextAlign.start,
//
//                            ),
//                          ),
//                          Flexible(
//                              fit: FlexFit.tight,
//                              flex: 1,
//                              child: SelectableText(
//                                viewModel.productWarranty.warrantyEndDate is bool
//                                    ? "${translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA")}"
//                                    : '$stringDateRemain',
//                                style: TextStyle(
//                                    color: viewModel.productWarranty.warrantyEndDate
//                                    is bool
//                                        ? Color(0xff999999)
//                                        : inDays <= 0
//                                        ? Colors.red
//                                        : Color(0xff999999), fontWeight: FontWeight.bold),
//                                textAlign: TextAlign.end,
//                              )),
//                        ],
//                      )) : Offstage(),
                  __divider(),
                  __warrantyDetailItem(
                      title: translation
                          .text('WANRRANTY_DETAIL_PAGE.ACTIVE_COMPANY'),
                      value: viewModel.productWarranty.merchant),
                ],
              ),
            ),
          ],
        ))
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.updateProductWarranty(widget.productWarranty);
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
//    test quick
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: ThemePrimary.backgroundColor,
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
