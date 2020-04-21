import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/product-warranty.dart';

class ProductWarrantyDetailPageViewModel extends ViewModelBase {
  ProductWarranty productWarranty;

  void updateProductWarranty(ProductWarranty productWarrantyParam){
    productWarranty = productWarrantyParam;
    this.updateState();
  }

//  Future<void> fetchGetProductWarranty() async {
//    List<ProductWarranty> data = await api.getProductWarranty();
//    print(data);
//  }

}
