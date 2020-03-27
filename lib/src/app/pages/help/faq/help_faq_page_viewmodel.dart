import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';
import 'package:ts24care/src/app/models/knowsystem-section.dart';
import 'package:ts24care/src/app/models/ts24_product_category.dart';

class FAQPageViewModel extends ViewModelBase {
  FAQPageViewModel() {
    getListCategory();
  }

  List<KnowsystemSection> listCategory = [];
  List<KnowsystemArticle> listResultSearch = [];
  List<KnowsystemSection> listCategoryHaveColorsAndImages = [];

  Future<void> getListCategory() async {
    try{
      listCategory = await api.getCategoryFAQ();
    }
    catch(e){
      print(e);
    }
    if(listCategory.length>0) {
      listCategory.forEach((eachCategory) {
        TS24ProductCategory.list.forEach((catModel) {
          if (eachCategory.name == catModel.name) {
            listCategoryHaveColorsAndImages.add(KnowsystemSection(
                id: eachCategory.id,
                color: catModel.color,
                name: eachCategory.name,
                urlIcon: catModel.photo
            ));
          }
        });
      });

      listCategory.forEach((eachCategory) {
        TS24ProductCategory.list.forEach((catModel) {
          if (eachCategory.name != catModel.name) {
            listCategoryHaveColorsAndImages.add(KnowsystemSection(
                id: eachCategory.id,
                color: Colors.grey,
                name: eachCategory.name,
                urlIcon: TS24ProductCategory.list[0].photo
            ));
          }
        });
      });
    }

    this.updateState();
  }

  Future<void> onQuerySubmitted(String keyword) async {
    print('keyword $keyword');
    onSearch(keyword);
  }

  onSearch(String keyword) async {
    try{
      listResultSearch =
      await api.searchFAQ(keyword: keyword.toLowerCase(), offset: 0, limit: 50);
    }
    catch(e){
      print(e);
    }
    print(listResultSearch);
    this.updateState();

  }
}
