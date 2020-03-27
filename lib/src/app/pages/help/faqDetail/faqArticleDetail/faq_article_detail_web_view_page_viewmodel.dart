import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';

class FaqArticleDetailPageViewModel extends ViewModelBase {
  FaqArticleDetailPageViewModel();

  KnowsystemArticle htmlData;

  Future<void> fetchArticleHtmlContent(int id) async {
   try{
     htmlData = await api.getFAQDetail(id);
   }
   catch(e){
     print(e);
   }
  }
}
