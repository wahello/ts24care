import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24SlideWidget/ts24_slide_widget_viewmodel.dart';

typedef TS24SlideCallback = void Function(
    List<dynamic> listItemApplicationModel);
typedef TS24SlideCallbackIndexChange = void Function(int index);

class TS24SlideWidget extends StatefulWidget {
  final List<dynamic> listFullObject;
  final List<dynamic> listCurrentObject;
  final TS24SlideCallback onAddItem;
  final TS24SlideCallbackIndexChange onChange;

  const TS24SlideWidget(
      {Key key,
      @required this.listFullObject,
      @required this.listCurrentObject,
      this.onAddItem,
      this.onChange})
      : super(key: key);

  @override
  _TS24SlideWidgetState createState() => _TS24SlideWidgetState();
}

class _TS24SlideWidgetState extends State<TS24SlideWidget> {
  TS24SlideWidgetViewModel viewModel = TS24SlideWidgetViewModel();

  @override
  void initState() {
    viewModel.listApplication = widget.listCurrentObject;
    viewModel.listApplicationFull = widget.listFullObject;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    Widget _body() {
      Widget __button({Function onTap, String name, IconData iconData}) {
        return InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(2),
            height: 30,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(iconData, color: Colors.grey[800]),
                Text(
                  name,
                  style: TextStyle(color: Colors.grey[800]),
                ),
                SizedBox(
                  width: 4,
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey[600], width: 2.0),
                borderRadius: BorderRadius.circular(15)),
          ),
        );
      }

      return GestureDetector(
        onHorizontalDragStart: (dragStartDetails) {
          viewModel.getPositionDragStar(dragStartDetails.localPosition.dx);
        },
        onHorizontalDragDown: (dragDownDetails) {
          viewModel.getPositionDragDown(dragDownDetails.localPosition.dx);
        },
        onHorizontalDragEnd: (_) {
          viewModel.handleDrag();
        },
        child: Stack(
          children: <Widget>[
            Container(
              color: ThemePrimary.backgroundColor,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 110),
              child: Swiper(
                onTap: (index) {
                  viewModel.controller.move(index);
                },
                physics: NeverScrollableScrollPhysics(),
                onIndexChanged: (index) {
                  viewModel.onIndexChanged(index, widget.onChange);
                },
                layout: SwiperLayout.DEFAULT,
                itemWidth: 50,
                itemHeight: 50,
                controller: viewModel.controller,
                outer: true,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  return (index == viewModel.indexCurrent)
                      ? CircularPercentIndicator(
                        radius: 100.0,
                        animation: true,
                        animationDuration: 1000,
                        lineWidth: 3.0,
                        percent: 1,
                        startAngle: 0,
                        center: Image.network(
                          viewModel.listApplication[index].imageLogo,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: Colors.black26,
                        progressColor: ThemePrimary.primaryColor,
                      )
                      : Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 3,
                                  color: index == viewModel.indexCurrent
                                      ? ThemePrimary.primaryColor
                                      : Colors.black26)),
                          child: Image.network(
                            viewModel.listApplication[index].imageLogo,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ));
                },
                itemCount: viewModel.listApplication.length,
//                              pagination: new SwiperPagination(),
                control: new SwiperControl(
                    color: Colors.transparent,
                    disableColor: Colors.transparent),
                viewportFraction: 0.3,
                scale: 0.2,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 120,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                color: ThemePrimary.backgroundColor,
                alignment: Alignment.center,
                child: Text(
                  viewModel.listApplication[viewModel.indexCurrent].name,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 170,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
//                              color: Colors.yellow,
                padding: EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    __button(
                        name: translation.text('HELP_PAGE.ALL_BUTTON'),
                        iconData: Icons.list,
                        onTap: () => viewModel.onTapAll()),

//                    __button(
//                        name: translation.text('HELP_PAGE.ADD_BUTTON'),
//                        iconData: Icons.add,
//                        onTap: () {
//                          viewModel.onTapAdd(widget.onAddItem);
//                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return _body();
        },
      ),
    );
  }
}
