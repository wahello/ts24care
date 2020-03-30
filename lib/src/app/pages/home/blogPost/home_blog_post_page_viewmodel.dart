import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';

class BlogPostPageViewModel extends ViewModelBase{
  BlogPostPageViewModel();
  ItemNewFeedModel itemNewFeedModel;
  onGetContentById(ItemNewFeedModel item){
    api.getBlogById(item.id).then((blogPost){
      if (blogPost != null) {
        item.content = blogPost.content;
      }
      this.updateState();
    });

  }
}