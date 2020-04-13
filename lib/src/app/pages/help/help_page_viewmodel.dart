import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_application_model.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';
import 'package:ts24care/src/app/models/knowsystem-section.dart';
import 'package:ts24care/src/app/models/product-category.dart';
import 'package:ts24care/src/app/models/product-warranty.dart';
import 'package:ts24care/src/app/models/ts24_product_category.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page.dart';
import 'package:ts24care/src/app/pages/help/feedback/help_feedback_page.dart';
import 'package:ts24care/src/app/pages/help/helpChat/helpChat_page.dart';

class HelpPageViewModel extends ViewModelBase {
  List<ItemApplicationModel> listApplication = List();
  List<ProductWarranty> listProductWarranty = List();
  List<KnowsystemArticle> listArticle = List();
  List<KnowsystemSection> listCategory = List();
  bool isIndexCategoryChanged = false;
  bool isLoading = true;

  HelpPageViewModel() {
//    listApplication.addAll(ItemApplicationModel.listApplicationActive);
    fetchCategoryTS24Product();
    getListCategory();
    this.updateState();
  }

//  fetch data api and add icon, url from TS24ProductCategory.list
//  add id from listCategory for fetch article list in TS24SlideProduct
  Future<void> fetchCategoryTS24Product() async {
    List<ProductCategory> data = await api.getCategoryTS24Product();
    List<ItemApplicationModel> dataListApplication = [];
    if (data.length > 0)
      for (var itemProduct = 0; itemProduct < data.length; itemProduct++) {
        for (var itemProductMap = 0;
            itemProductMap < TS24ProductCategory.list.length;
            itemProductMap++) {
          if (data[itemProduct].name.toString().contains(
              TS24ProductCategory.list[itemProductMap].name.toString())) {
            for (var itemCategoryArticle = 0;
                itemCategoryArticle < listCategory.length;
                itemCategoryArticle++) {
              if (data[itemProduct].name.toString().contains(
                  listCategory[itemCategoryArticle].name.toString())) {
                dataListApplication.add(ItemApplicationModel(
                    idCategoryServices: data[itemProduct].id,
                    idCategoryArticle: listCategory[itemCategoryArticle].id,
                    name: data[itemProduct].name.toString(),
                    imageLogo: TS24ProductCategory.list[itemProductMap].photo
                        .toString(),
                    description: data[itemProduct].name));
              }
            }
          }
        }
      }

    listApplication = dataListApplication;
    isLoading = false;
    this.updateState();
    print(listApplication);
    if (!isIndexCategoryChanged) {
      onFirstCategoryIndexUnChanged(listApplication);
    }
    this.updateState();
  }

//  load when index category not changed
  onFirstCategoryIndexUnChanged(
      List<ItemApplicationModel> listUserProduct) async {
    print('on unchange');
    if (listUserProduct.length > 0) {
      int categoryProductId = listUserProduct[0].idCategoryServices;
      int categoryArticleId = listUserProduct[0].idCategoryArticle;
      listProductWarranty =
          await api.getProductWarrantyByCategoryId(categoryProductId);
      listArticle = await api.getListFAQByCategoryId(
          categoryId: categoryArticleId, offset: 0, limit: 50);
      this.updateState();
      if (listArticle.length >= 5) {
        listArticle = listArticle.sublist(0, 5);
        this.updateState();
      }
    }
  }

//  fetch listProductWarranty when category product changed
  Future<void> onCategoryIndexChanged(int idCategoryProduct) async {
    listProductWarranty = [];
    isIndexCategoryChanged = true;
    this.updateState();
    try {
      listProductWarranty =
          await api.getProductWarrantyByCategoryId(idCategoryProduct);
      this.updateState();
    } catch (e) {
      print(e);
    }
  }

// get list KnowsystemSection
  Future<void> getListCategory() async {
    try {
      listCategory = await api.getCategoryFAQ();
      this.updateState();
    } catch (e) {
      print(e);
    }
  }

//  fetch article by category id
  Future<void> getListFAQByCategoryId(int idCategoryArticle) async {
    listArticle = [];
    this.updateState();
    listArticle = await api.getListFAQByCategoryId(
        categoryId: idCategoryArticle, offset: 0, limit: 50);
    print(listArticle);
    if (listArticle.length > 4) {
      listArticle = listArticle.sublist(0, 5);
      this.updateState();
    }
    this.updateState();
  }

  onTapFAQ() {
    Navigator.pushNamed(context, FAQPage.routeName);
  }

  onTapFeedback() {
    Navigator.pushNamed(context, FeedbackPage.routeName);
  }

  onTapChat() {
    Navigator.pushNamed(context, HelpChatPage.routeName);
  }
}
