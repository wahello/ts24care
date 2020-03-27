import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/blog-post.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';

class NewsAndTipsPageViewModel extends ViewModelBase {
  List<ItemNewFeedModel> listNewFeedSearch = List();
  ScrollController controller = ScrollController();
  NewsAndTipsPageViewModel();
  onSearch(String keyword) {
    api
        .searchBlogs(keyword: keyword.toLowerCase(), offset: 0, limit: 10)
        .then((listBlogPost) {
      if (listBlogPost.length > 0) {
        int count = 0;
        //onLoadData(count,listNewFeedSearch,listBlogPost);
        listBlogPost.asMap().forEach((index, item) {
//          api.getBlogById(item.id).then((blogPost) {
//            if (blogPost.content != null)
//              listBlogPost[index].content =
//                  (blogPost.content == null || blogPost.content is bool)
//                      ? ""
//                      : blogPost.content;
            listNewFeedSearch.add(ItemNewFeedModel(
              id: index,
              title: item.name,
              avatarUrl: getUrlImage(item.coverProperties),
//              content: (blogPost.content == null || blogPost.content is bool)
//                  ? ""
//                  : blogPost.content,
              createDate: (item.createDate == null || item.createDate is bool)
                  ? ""
                  : item.createDate,
              subTitle: (item.subtitle == null || item.subtitle is bool)
                  ? ""
                  : item.subtitle, // item.subtitle is bool?"":item.subtitle,
              postDate: (item.postDate == null || item.postDate is bool)
                  ? ""
                  : item.postDate, //item.postDate,
              writeDate: (item.writeDate == null || item.writeDate is bool)
                  ? ""
                  : item.writeDate, //item.writeDate
            ));
//            if(blogPost!=null)
//              count++;
//            if(count == listBlogPost.length)
              this.updateState();
//          });
        });
      }
    });
  }
  onLoadData(int count,List<ItemNewFeedModel> listNewFeedSearch,List<BlogPost> listBlogPost){
    api.getBlogById(listBlogPost[count].id).then((blogPost) {
      if (blogPost != null) {
        listBlogPost[count].content =
        (blogPost.content == null || blogPost.content is bool)
            ? ""
            : blogPost.content;
        listNewFeedSearch.add(ItemNewFeedModel(
          id: count,
          title: listBlogPost[count].name,
          avatarUrl: getUrlImage(listBlogPost[count].coverProperties),
          content: (blogPost.content == null || blogPost.content is bool)
              ? ""
              : blogPost.content,
          createDate: (listBlogPost[count].createDate == null ||
              listBlogPost[count].createDate is bool)
              ? ""
              : listBlogPost[count].createDate,
          subTitle: (listBlogPost[count].subtitle == null ||
              listBlogPost[count].subtitle is bool)
              ? ""
              : listBlogPost[count].subtitle,
          // item.subtitle is bool?"":item.subtitle,
          postDate: (listBlogPost[count].postDate == null ||
              listBlogPost[count].postDate is bool)
              ? ""
              : listBlogPost[count].postDate,
          //item.postDate,
          writeDate: (listBlogPost[count].writeDate == null ||
              listBlogPost[count].writeDate is bool)
              ? ""
              : listBlogPost[count].writeDate, //item.writeDate
        ));
        count++;
        if (count == listBlogPost.length) {
          this.updateState();
          return;
        }
        print(count);
        onLoadData(count, listNewFeedSearch, listBlogPost);
      }
//      }else{
//        count++;
//        if (count == listBlogPost.length) {
//          this.updateState();
//          return;
//        }
//        print(count);
//        onLoadData(count, listNewFeedSearch, listBlogPost);
//      }
    });
  }
  onQuerySubmitted(String keyword){
    listNewFeedSearch.clear();
    print("Keyword:"+keyword);
    onSearch(keyword);
    this.updateState();
  }
}
