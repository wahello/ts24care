import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/product-warranty.dart';
import 'package:ts24care/src/app/pages/help/productWarrantyDetail/product_warranty_detail_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';

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
      backgroundColor: ThemePrimary.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      title: Text(
        'Chi tiết dịch vụ',
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }

  Widget _body() {
    var todayDate = DateTime.now();
    var endDate = DateTime.parse(viewModel.productWarranty.warrantyEndDate);
    var dateFormat =
        viewModel.productWarranty.warrantyEndDate.toString().split("-");
    var dateFormatOk = dateFormat[2].toString() +
        '-' +
        dateFormat[1].toString() +
        '-' +
        dateFormat[0].toString();
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: ThemePrimary.backgroundColor,
            borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    '${viewModel.productWarranty.name}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3),
                  child: ListTile(
                    leading: Text(
                        '${translation.text('WANRRANTY_DETAIL_PAGE.DATE_REMAINING')}'),
                    trailing: Text(
                      '${endDate.difference(todayDate).inDays <= 0 ? translation.text("WANRRANTY_DETAIL_PAGE.DATE_EXPIRED") : endDate.difference(todayDate).inDays > 30 ? dateFormatOk : endDate.difference(todayDate).inDays.toString() + ' ' + translation.text("WANRRANTY_DETAIL_PAGE.DATE_STRING")}',
                      style: TextStyle(
                          color: endDate.difference(todayDate).inDays <= 0
                              ? Colors.red
                              : Colors.black),
                    ),
                  )),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3),
                  child: ListTile(
                    leading: Text(
                        '${translation.text('WANRRANTY_DETAIL_PAGE.SERIAL')}'),
                    trailing: Text(
                        '${viewModel.productWarranty.productSerialId[1] ?? translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA")}'),
                  )),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3),
                  child: ListTile(
                    leading: Text(
                        '${translation.text('WANRRANTY_DETAIL_PAGE.LICENSE')}'),
                    trailing: Text(
                        '${viewModel.productWarranty.modelNo ?? translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA")}'),
                  )),
              Divider(
                indent: 20,
                endIndent: 20,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3),
                  child: ListTile(
                    leading: Text(
                        '${translation.text('WANRRANTY_DETAIL_PAGE.PHONE')}'),
                    trailing: Text(
                        '${viewModel.productWarranty.phone ?? translation.text("WANRRANTY_DETAIL_PAGE.NO_DATA")}'),
                  )),
            ],
          ),
        ),
      ),
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
