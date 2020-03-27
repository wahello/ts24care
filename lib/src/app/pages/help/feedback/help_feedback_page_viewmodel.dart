import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';

class FeedbackPageViewModel extends ViewModelBase {
  FeedbackPageViewModel();

  List<KnowsystemArticle> listArticle = [];

  Future<void> getListFAQByCategoryId(int id) async {
    print('CATEGORY ID: $id');
    listArticle =
        await api.getListFAQByCategoryId(categoryId: id, offset: 0, limit: 3);
    print(listArticle);
    this.updateState();
  }
}
