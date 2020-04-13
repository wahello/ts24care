import 'package:flutter/cupertino.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/blog-post.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';

class NewsAndTipsPageViewModel extends ViewModelBase {
  List<ItemNewFeedModel> listNewFeedSearch = List();
  List<ItemNewFeedModel> listNewFeed = List();
  ScrollController controller = ScrollController();
  bool loadingMore = false;
  bool loadMoreDone = false;
//  int _take = 10;
  int _skip = 10;
  NewsAndTipsPageViewModel(){
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent &&
          !controller.position.outOfRange) onLoadMore();
    });
    loading = true;
    this.updateState();
    onLoad();
  }

  onLoad() async {
    loading = true;
    this.updateState();
    listNewFeed.clear();
     api.getListBlogs(offset: 0, limit: 10).then((listResult){
         List<BlogPost> listBlogPost = listResult;
         int count = 0;
         if (listBlogPost.length > 0)
           listBlogPost.forEach((item) {
             listNewFeed.add(ItemNewFeedModel(
               id: item.id,
               title: item.name,
               avatarUrl: getUrlImage(item.coverProperties),
               content: "",
               createDate: (item.createDate == null || item.createDate is bool)
                   ? ""
                   : item.createDate,
               subTitle: (item.subtitle == null || item.subtitle is bool)
                   ? ""
                   : item.subtitle,
               // item.subtitle is bool?"":item.subtitle,
               postDate: (item.postDate == null || item.postDate is bool)
                   ? ""
                   : item.postDate,
               //item.postDate,
               writeDate: (item.writeDate == null || item.writeDate is bool)
                   ? ""
                   : item.writeDate, //item.writeDate
             ));
             count++;
             if(count == listBlogPost.length) {
               loading = false;
               this.updateState();
             }
           });
//         loading = false;
//         this.updateState();
    });
  }
  onLoadMore() {
    if (loadMoreDone) return;
    loadingMore = true;
    this.updateState();
//    int countItemLoad = 0;
    api.getListBlogs(limit: 10, offset: _skip).then((list) {
      if (list.length > 0) {
        // list.forEach((historyDriver) {
        //   countItemLoad += historyDriver.listHistory.length;
        // });
        // if (countItemLoad < _take) loadMoreDone = true;
        list.forEach((item) {
          listNewFeed.add(ItemNewFeedModel(
            id: item.id,
            title: item.name,
            avatarUrl: getUrlImage(item.coverProperties),
            content: "",
            createDate: (item.createDate == null || item.createDate is bool)
                ? ""
                : item.createDate,
            subTitle: (item.subtitle == null || item.subtitle is bool)
                ? ""
                : item.subtitle,
            // item.subtitle is bool?"":item.subtitle,
            postDate: (item.postDate == null || item.postDate is bool)
                ? ""
                : item.postDate,
            //item.postDate,
            writeDate: (item.writeDate == null || item.writeDate is bool)
                ? ""
                : item.writeDate, //item.writeDate
          ));
        });
        _skip += 10;
        loadingMore = false;
//        _getImageHistory();
      } else {
        print("loadmore done");
        loadingMore = false;
        loadMoreDone = true;
        this.updateState();
      }
      //  _getImageHistoryPositions();
      this.updateState();
    });
  }

  onSearch(String keyword) {
    api
        .searchBlogs(keyword: keyword.toLowerCase(), offset: 0, limit: 10)
        .then((listBlogPost) {
      if (listBlogPost.length > 0) {
//        int count = 0;
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
//  onLoadData(int count,List<ItemNewFeedModel> listNewFeedSearch,List<BlogPost> listBlogPost){
//    api.getBlogById(listBlogPost[count].id).then((blogPost) {
//      if (blogPost != null) {
//        listBlogPost[count].content =
//        (blogPost.content == null || blogPost.content is bool)
//            ? ""
//            : blogPost.content;
//        listNewFeedSearch.add(ItemNewFeedModel(
//          id: count,
//          title: listBlogPost[count].name,
//          avatarUrl: getUrlImage(listBlogPost[count].coverProperties),
//          content: (blogPost.content == null || blogPost.content is bool)
//              ? ""
//              : blogPost.content,
//          createDate: (listBlogPost[count].createDate == null ||
//              listBlogPost[count].createDate is bool)
//              ? ""
//              : listBlogPost[count].createDate,
//          subTitle: (listBlogPost[count].subtitle == null ||
//              listBlogPost[count].subtitle is bool)
//              ? ""
//              : listBlogPost[count].subtitle,
//          // item.subtitle is bool?"":item.subtitle,
//          postDate: (listBlogPost[count].postDate == null ||
//              listBlogPost[count].postDate is bool)
//              ? ""
//              : listBlogPost[count].postDate,
//          //item.postDate,
//          writeDate: (listBlogPost[count].writeDate == null ||
//              listBlogPost[count].writeDate is bool)
//              ? ""
//              : listBlogPost[count].writeDate, //item.writeDate
//        ));
//        count++;
//        if (count == listBlogPost.length) {
//          this.updateState();
//          return;
//        }
//        print(count);
//        onLoadData(count, listNewFeedSearch, listBlogPost);
//      }
////      }else{
////        count++;
////        if (count == listBlogPost.length) {
////          this.updateState();
////          return;
////        }
////        print(count);
////        onLoadData(count, listNewFeedSearch, listBlogPost);
////      }
//    });
//  }
  onQuerySubmitted(String keyword){
    listNewFeedSearch.clear();
    print("Keyword:"+keyword);
    onSearch(keyword);
    this.updateState();
  }
}
