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
//    var create = DateTime.parse(
//        viewModel.productWarranty.createDate.toString().replaceAll('/', '-'));
    var startDate =
        DateTime.parse(viewModel.productWarranty.warrantyCreateDate);
    var endDate = DateTime.parse(viewModel.productWarranty.warrantyEndDate);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ThemePrimary.backgroundColor,
          borderRadius: BorderRadius.circular(20)
      ),

//      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(25),
            decoration: BoxDecoration(
                color: Colors.white70,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: <Widget>[
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Text(
                        '${viewModel.productWarranty.name}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold,),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
                Divider(indent: 20,endIndent: 20,),
                Container(

                    width: double.infinity,
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Text('${translation.text('WANRRANTY_DETAIL_PAGE.DATE_REMAINING')}:'),
                      trailing: Text(
                          '${endDate.difference(startDate).inDays == 0 ? 'Expired' : endDate.difference(startDate).inDays} days'),
                    )),
                Divider(indent: 20,endIndent: 20,),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Text('${translation.text('WANRRANTY_DETAIL_PAGE.SERIAL')}:'),
                      trailing:
                          Text('${viewModel.productWarranty.productSerialId}'),
                    )),
                Divider(indent: 20,endIndent: 20,),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Text('${translation.text('WANRRANTY_DETAIL_PAGE.PHONE')}:'),
                      trailing: Text('${viewModel.productWarranty.phone}'),
                    )),
              ],
            ),
          )
        ],
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
    print(viewModel.productWarranty);
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
