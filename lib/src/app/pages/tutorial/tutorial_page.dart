import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/tutorial/tutorial_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class TutorialPage extends StatefulWidget {
  static const String routeName = '/tutorial';
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  TutorialPageViewModel viewModel = TutorialPageViewModel();
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _body() {
      return SingleChildScrollView(
//        width: MediaQuery.of(context).size.width,
//        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Swiper(
//              onIndexChanged: viewModel.onIndexChanged,
                layout: SwiperLayout.DEFAULT,
                itemWidth: 50,
                itemHeight: 50,
                outer: true,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
//                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                viewModel.title[index],
                                style: TextStyle(
                                    fontSize: 22,
                                    color: ThemePrimary.primaryColor,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                viewModel.subTitle[index],
                                style:
                                TextStyle(fontSize: 20, color: Colors.grey),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
//                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl: viewModel.urlImageSlide[index],
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width *0.8,
                              height: MediaQuery.of(context).size.width *0.8,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: viewModel.urlImageSlide.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(color: Colors.transparent,disableColor: Colors.transparent),
                viewportFraction: 1,
                scale: 1,
              ),
            ),
            SizedBox(height: 50,),
            Container(
              alignment: Alignment.center,
              child: TS24Button(
                onTap: () {
                  viewModel.onTapStart();
                },
                width: 350,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: ThemePrimary.primaryColor),
                child: Center(
                  child: Text(
                    "Bắt đầu",
                    style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            body: _body(),
          );
        },
      ),
    );
  }
}
