import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/pages/tutorial/tutorial_page_viewmodel.dart';
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
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                                "Smarter Notifications",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Get ticket updates only when and where you want to receive them.",
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
                          child: Image.asset(
                            "assets/images/vegetable_natural.jpg",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    ],
                  );
                },
                itemCount: 3,
                pagination: new SwiperPagination(),
                control: new SwiperControl(color: Colors.transparent,disableColor: Colors.transparent),
                viewportFraction: 1,
                scale: 1,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: TS24Button(
                  onTap: () {
                    viewModel.onTapStart();
                  },
                  width: 350,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
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
