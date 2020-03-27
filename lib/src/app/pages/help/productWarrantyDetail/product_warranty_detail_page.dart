import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      title: Text(
        'Chi tiết dịch vụ',
        style: TextStyle(color: Colors.black87),
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
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Icon(
                      Icons.account_box,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Display name: '),
                  trailing: Text('${viewModel.productWarranty.displayName}'),
                )),
          ),
          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.date_range,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Date remaining:'),
                  trailing: Text(
                      '${endDate.difference(startDate).inDays == 0 ? 'Expired' : endDate.difference(startDate).inDays} days'),
                )),
          ),
//          Card(
//            child: Container(
//                width: double.infinity,
//                padding: EdgeInsets.all(5),
//                child: ListTile(
//                  leading: CircleAvatar(
//                    backgroundColor: Colors.redAccent,
//                    child: Icon(Icons.vpn_key,color: Colors.white,),
//                  ),
//                  title: Text('License key: '),
//                  trailing:
//                      Text('${viewModel.productWarranty.}'),
//                )),
//          ),
          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Icon(
                      Icons.explicit,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Serial number: '),
                  trailing:
                      Text('${viewModel.productWarranty.productSerialId}'),
                )),
          ),
          Card(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Phone: '),
                  trailing: Text('${viewModel.productWarranty.phone}'),
                )),
          ),
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
            backgroundColor: Colors.white,
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}
