import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';

class WebHtmlPageViewModel extends ViewModelBase {
  WebHtmlPageViewModel();

  KnowsystemArticle htmlData;

  Future<void> fetchArticleHtmlContent(int idArticle) async {
   try{
     htmlData = await api.getFAQDetail(idArticle);
   }
   catch(e){
     print(e);
   }
  }
}
