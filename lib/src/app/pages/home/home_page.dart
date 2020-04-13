import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/home/home_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/group_content_widget.dart';
import 'package:ts24care/src/app/widgets/item_newfeed_widget.dart';
import 'package:ts24care/src/app/widgets/shimmer/shimmer_item_news_and_tips.dart';
import 'package:ts24care/src/app/widgets/ts24BottomScrollWithBackgroundWidget/ts24_bottom_scroll_with_background_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomePageViewModel viewModel = HomePageViewModel();
  Widget _appBar() {
    return TS24AppBar(
      leading: SizedBox(),
      elevation: 0,
      backgroundColorStart: ThemePrimary.backgroundColor,
      backgroundColorEnd: ThemePrimary.backgroundColor,
      title: Text(
        "Trang chủ",
        style: TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget _body() {
    Widget __content() {
      return SingleChildScrollView(
        child: Container(
          color: ThemePrimary.backgroundColor,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  SizedBox(
//                    width: 20,
//                  ),
//                  TS24Button(
//                    onTap: () {},
//                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
//                    decoration: BoxDecoration(
//                        color: Color(0xFFD9D9D9),
//                        borderRadius: BorderRadius.all(Radius.circular(10))),
//                    child: Center(
//                        child: Text(
//                      "Benefit",
//                      style: TextStyle(
//                          fontWeight: FontWeight.w600,
//                          color: Color(0xFF292929)),
//                    )),
//                  ),
//                  SizedBox(
//                    width: 10,
//                  ),
//                  TS24Button(
//                    onTap: () {},
//                    padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
//                    decoration: BoxDecoration(
//                        color: Color(0xFFD9D9D9),
//                        borderRadius: BorderRadius.all(Radius.circular(10))),
//                    child: Center(
//                        child: Text(
//                      "News & tips",
//                      style: TextStyle(
//                          fontWeight: FontWeight.w600,
//                          color: Color(0xFF292929)),
//                    )),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 20,
//              ),
//              GroupContentWidget(
//                title: "Community",
//                child: Container(
//                  height: 70,
//                ),
//              ),

              (viewModel.loading)
                  ? GroupContentWidget(
                      title: translation.text("HOME_PAGE.NEW_POSTS"),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: 4,
                          itemBuilder: (context, index) =>
                              ShimmerItemNewFeedHorizontalWidget()),
                    )
                  : GroupContentWidget(
                      title: translation.text("HOME_PAGE.NEW_POSTS"),
                      tapMore: () {
                        viewModel.onTapMoreNewAndTips();
                      },
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: viewModel.listNewFeed.length,
                        itemBuilder: (context, index) => TS24Button(
                          onTap: () {
                            viewModel
                                .onTapBlogPost(viewModel.listNewFeed[index]);
                          },
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ItemNewFeedHorizontalWidget(
                            title: viewModel.listNewFeed[index].title,
                            url: viewModel.listNewFeed[index].avatarUrl,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      );
    }

    return TS24BottomScrollWithBackgroundWidget(
      shadow: false,
      hideAppBar: true,
      background: Builder(builder: (context) {
        return Container(
            height: 200,
            child: SafeArea(
              top: true,
              child: Stack(
                children: <Widget>[
                  (viewModel.listNewFeed.length > 0)
                      ? Swiper(
                          onIndexChanged: (index) {
                            viewModel.onChangeSlideIndex(index);
                            print(index);
                          },
                          onTap: (index) {
                            viewModel
                                .onTapBlogPost(viewModel.listNewFeed[index]);
                          },
                          itemHeight: 50,
                          itemBuilder: (BuildContext context, int index) {
                            return viewModel.listNewFeed[index].avatarUrl !=
                                    null
                                ? Image.network(
                                    viewModel.listNewFeed[index].avatarUrl,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/default.jpg",
                                    fit: BoxFit.cover,
                                  );
                          },
                          itemCount: viewModel.listNewFeed.length,
//                    list: viewModel.listNewFeed
//                        .map((item) => item.avatarUrl != null
//                            ? Image.network(
//                                item.avatarUrl,
//                                fit: BoxFit.cover,
//                              )
//                            : Image.asset(
//                                "assets/images/default.jpg",
//                                fit: BoxFit.cover,
//                              ))
//                        .toList(),
                          control: new SwiperControl(color: Colors.transparent),
                        )
                      : LoadingIndicator.spinner(
                          context: context, loading: viewModel.loading),
                  if (viewModel.listNewFeed.length > 0)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
//                  width: 50,
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                  height: 20,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          (viewModel.slideCurrentIndex + 1).toString() +
                              "/" +
                              viewModel.listNewFeed.length.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )
                ],
              ),
            ));
      }),
      onFreshCallback: () async {
        viewModel.onLoad();
      },
      controllerCallback: (_) {},
      child: __content(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
//            appBar: _appBar(),
            body: _body(),
//            floatingActionButton: new FloatButtonWidget(
//              tooltip: "add",
//              onPressed: () {},
//              listFAB: [
//                FloatingActionButton(
//                  backgroundColor: ThemePrimary.primaryColor,
//                  heroTag: 10,
//                  onPressed: () {
//                    viewModel.onTapCreateTicket();
//                  },
//                  tooltip: 'add',
//                  child: Icon(Icons.add),
//                ),
//                FloatingActionButton(
//                  backgroundColor: ThemePrimary.primaryColor,
//                  heroTag: 11,
//                  onPressed: null,
//                  tooltip: 'call',
//                  child: Icon(Icons.call),
//                ),
//                FloatingActionButton(
//                  backgroundColor: ThemePrimary.primaryColor,
//                  heroTag: 12,
//                  onPressed: () {
////                    viewModel.onTapChat();
//                  },
//                  tooltip: 'message',
//                  child: Icon(Icons.message),
//                )
//              ],
//              icon: Icons.menu,
//            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
