import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/helper/utils.dart';
import 'package:ts24care/src/app/models/blog-post.dart';
import 'package:ts24care/src/app/models/item_newfeed_model.dart';
import 'package:ts24care/src/app/pages/home/blogPost/home_blog_post_page.dart';
import 'package:ts24care/src/app/pages/home/newsAndTips/home_news_and_tips_page.dart';
import 'package:ts24care/src/app/pages/ticket/new/ticket_new_page.dart';

class HomePageViewModel extends ViewModelBase {
  List<ItemNewFeedModel> listNewFeed = List();
  int slideCurrentIndex = 1;
  HomePageViewModel() {
    onLoad();
  }
  onTapMoreNewAndTips() {
    Navigator.pushNamed(context, NewsAndTipsPage.routeName,
        arguments: listNewFeed);
  }

  onLoad() async {
    listNewFeed.clear();
    loading = true;
    List<BlogPost> listBlogPost = await api.getListBlogs(offset: 0, limit: 10);
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
      });
    loading = false;
    this.updateState();
  }

  onChangeSlideIndex(int index){
    this.slideCurrentIndex = index;
    this.updateState();
  }

  onTapBlogPost(ItemNewFeedModel itemNewFeedModel) {
    Navigator.pushNamed(context, BlogPostPage.routeName,
        arguments: itemNewFeedModel);
  }
  onTapCreateTicket() {
    Navigator.pushNamed(context, TicketNewPage.routeName);
  }
}
