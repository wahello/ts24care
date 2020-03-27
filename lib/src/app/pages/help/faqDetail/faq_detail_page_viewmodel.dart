import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';

class FaqDetailPageViewModel extends ViewModelBase {
  FaqDetailPageViewModel();

  List<KnowsystemArticle> listArticle = [];
  List<KnowsystemArticle> listResultSearch = [];

  Future<void> getListFAQByCategoryId(int idCategoryProduct) async {
   try{
     listArticle =
     await api.getListFAQByCategoryId(categoryId: idCategoryProduct, offset: 0, limit: 50);

   }
   catch(e){
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
    try{
      listResultSearch = await api.searchFAQ(keyword: keyword.toLowerCase(), offset: 0, limit: 10);
      this.updateState();
    }
    catch(e){
      print(e);
    }
    print(listResultSearch);
  }
}
