import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';
import 'package:flutter/material.dart';

class FaqDetailPageViewModel extends ViewModelBase {
  List<KnowsystemArticle> listArticle = List();
  List<KnowsystemArticle> listResultSearch = [];
  bool isLoading = true;
  bool isNoData = true;
  int idCategoryForFetchArticle;

  ScrollController controller = ScrollController();
  int offset = 0;
  int limit = 10;
  bool isAddMoreArticleToList = false;

  onScrollHappened(ScrollController controller) {
    print(controller.offset);
    if (controller.offset >= controller.position.maxScrollExtent) {
      onLoadMore();
    }
  }

  FaqDetailPageViewModel() {
//      print('scroll ${controller.offset}');
//      if (controller.offset >= controller.position.maxScrollExtent &&
//          !controller.position.outOfRange){ onLoadMore();}
//    onLoad();
  }

  void updateIdCategoryForFetchArticle(int idCategoryArticle) {
    idCategoryForFetchArticle = idCategoryArticle;
    onLoad();
  }

  onLoadMore() {
    if(!isAddMoreArticleToList) {
      isAddMoreArticleToList = true;
      this.updateState();
      api
          .getListFAQByCategoryId(
          categoryId: idCategoryForFetchArticle, offset: offset, limit: limit)
          .then((data) {
        if (data.length > 0) {
          listArticle.addAll(data);
          print("data load more");
          print(data);
          offset = (limit + 1);
          limit = (offset + 9);
          isAddMoreArticleToList = false;
          this.updateState();
        }
        else{

        }
      });
    }
  }

  onLoad() {
    api
        .getListFAQByCategoryId(
            categoryId: idCategoryForFetchArticle, offset: offset, limit: limit)
        .then((data) {
      if (data.length > 0) {
        listArticle = data;
        isLoading = false;
        isNoData = false;
        offset = (limit + 1);
        limit = (offset + 9);
        this.updateState();
      }
      else{
        isLoading = false;
        isNoData = true;
        this.updateState();
      }
    });
  }



  Future<void> getListFAQByCategoryId(int idCategoryProduct) async {
    try {
      listArticle = await api.getListFAQByCategoryId(
          categoryId: idCategoryProduct, offset: 0, limit: 50);
      if (listArticle.length == 0) {
        isLoading = false;
        this.updateState();
      }
    } catch (e) {
      print(e);
    }
    this.updateState();
  }

  Future<KnowsystemArticle> fetchHtmlByArticleId(int idArticle) async {
    return await api.getFAQDetail(idArticle);
  }

  Future<void> onQuerySubmitted(String keyword) async {
    print('keyword $keyword');
    onSearch(keyword);
  }

  onSearch(String keyword) async {
    try {
      listResultSearch = await api.searchFAQ(
          keyword: keyword.toLowerCase(), offset: 0, limit: 10);
      this.updateState();
    } catch (e) {
      print(e);
    }
    print(listResultSearch);
  }
}
