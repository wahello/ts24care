import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/knowsystem-article.dart';
import 'package:ts24care/src/app/pages/help/faq/help_faq_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/help/faqDetail/faqArticleDetail/faq_article_detail_web_view_page.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/item_help_widget.dart';
import 'package:ts24care/src/app/widgets/ts24SearchBarWidget/ts24_search_bar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_appbar_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';

class FAQPage extends StatefulWidget {
  static const String routeName = "/FAQpage";

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  FAQPageViewModel viewModel = FAQPageViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _appBar() {
      return TS24AppBar(
        backgroundColorStart: ThemePrimary.backgroundColor,
        backgroundColorEnd: ThemePrimary.backgroundColor,
        title: Text(
          "FAQ",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }

    Widget _body() {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: EdgeInsets.only(left: 0, right: 0, bottom: 0),
                itemCount: viewModel.listCategory.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ItemHelpWidget(
                      showCircle: true,
                      categoryId:
                          viewModel.listCategoryHaveColorsAndImages[index].id,
                      iconPath: viewModel
                          .listCategoryHaveColorsAndImages[index].urlIcon,
                      text: viewModel
                          .listCategoryHaveColorsAndImages[index].name,
                      color: viewModel
                          .listCategoryHaveColorsAndImages[index].color,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget _renderResultSearch(List<KnowsystemArticle> listResultItem) {
      return ListView.builder(
        itemCount: listResultItem.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, FaqArticleDetailPage.routeName,
                    arguments: [
                      [listResultItem[index].description],
                      listResultItem[index].name
                    ]);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: ListTile(
                      title: Text(listResultItem[index].name.toString()),
                      subtitle: Text(
                        listResultItem[index].createDate.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null) return Offstage();
          return TS24SearchBarWidget(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'FAQ',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              backgroundColor: Colors.white,
              primaryColor: ThemePrimary.primaryColor,
              searchBarStateCallBack: (_) {},
              onQueryChangedCallBack: (_) {},
              onQuerySubmittedCallBack: viewModel.onQuerySubmitted,
              countResult: viewModel.listResultSearch.length,
              resultWidget: _renderResultSearch(viewModel.listResultSearch),
              contentWidget: viewModel.listCategory.length == 0
                  ? !viewModel.isLoading
                      ? Center(
                          child: Text("FAQ_DETAIL_PAGE.NO_DATA"),
                        )
                      : LoadingIndicator.spinner()
                  : _body());
        },
      ),
    );
  }
}
