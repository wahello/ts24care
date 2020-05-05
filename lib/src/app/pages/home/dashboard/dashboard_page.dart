import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/ticketStatistic.dart';
import 'package:ts24care/src/app/pages/home/dashboard/dashboard_page_viewmodel.dart';
import 'package:ts24care/src/app/pages/ticket/ticket_page.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_utils_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Thông số màu:
//-	Xanh đậm: #3154aa
//-	Xám nhạt (menu only): #999999
//-	Xám đậm: #666666
class Dashboard extends StatefulWidget {
  static const String routeName = "dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardPageViewModel viewModel = DashboardPageViewModel();

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        translation.text("DASHBOARD_PAGE.DASHBOARD"),
      ),
    );
  }

  Widget _body() {
    Widget __timeLine() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(bottom: 30, top: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translation.text("DASHBOARD_PAGE.TIMELINE"),
                style: TextStyle(fontSize: 17, color: Color(0xff666666)),
              ),
              DropdownButton<String>(
                value: viewModel.dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 10,
                style: TextStyle(color: Colors.black87),
                onChanged: (String newValue) {
                  viewModel.updateDropdownValue(newValue);
                },
                items: viewModel.listDropdownValue
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value +
                          ' ${int.parse(value) / 10 == 3 ? translation.text("DASHBOARD_PAGE.DAY") : translation.text("DASHBOARD_PAGE.MONTH")}',
                      style: TextStyle(color: ThemePrimary.primaryColor),
                    ),
                  );
                }).toList(),
              ),
            ],
          ));
    }

    Widget __analyticSummary(
        {String title,
        dynamic countNumber,
        IconData icon,
        bool isTime = false,
        isCircleProgress = false,
        String route,
        String status}) {
      return InkWell(
        onTap: () {
          viewModel.onTapAnalyticSummary(status);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 17, color: Color(0xff666666)),
                  ),
                  viewModel.isSpinnerInText
                      ? LoadingIndicator.spinner(
                          context: context, loading: true)
                      : Text(
                          countNumber.toString() +
                              '${isTime ? ' ${translation.text("DASHBOARD_PAGE.MINUTE")}' : ''}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff666666),
                              fontWeight: FontWeight.bold),
                        ),
                ],
              ),
              isCircleProgress
                  ? CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 7.0,
                      animation: true,
                      percent: viewModel.percentTicketDone / 100,
                      center: Text(
                        "${viewModel.percentTicketDone == 0 ? 0 : viewModel.percentTicketDone.round()}%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: ThemePrimary.primaryColor,
                    )
                  : Icon(
                      icon,
                      size: 60,
                      color: ThemePrimary.primaryColor,
                    )
            ],
          ),
        ),
      );
    }

    Widget __chartSection() {
      Widget ___chartColorDescription({Color color, String text, int index}) {
        return Tooltip(
          message:
              "${translation.text("DASHBOARD_PAGE.VALUE")}: ${viewModel.dataChart[index].ticketCount ?? 0}"
              "\n${translation.text("DASHBOARD_PAGE.TIME_AVG")}: ${viewModel.dataChart[index].ticketsAvgTime.toStringAsFixed(0) ?? 0}"
              "\n${translation.text("DASHBOARD_PAGE.TICKET_DONE")}: ${viewModel.dataChart[index].ticketsDone ?? 0}",
          child: Container(
            margin: EdgeInsets.only(right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  color: color,
                  margin: EdgeInsets.only(right: 5),
                ),
                Container(
                  child: Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }

      return GestureDetector(
        onTap: () {
          setState(() {
            viewModel.offset = null;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          margin: MediaQuery.of(context).orientation == Orientation.landscape
              ? EdgeInsets.only(bottom: 30)
              : EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  translation.text("DASHBOARD_PAGE.SERVICE_SUPPORT"),
                  style: TextStyle(fontSize: 17, color: Color(0xff999999)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              viewModel.seriesList == null
                  ? Offstage()
                  : Material(
                      elevation: 0,
                      color: Colors.white,
                      shape: CircleBorder(),
                      child: Listener(
                          onPointerDown: (PointerDownEvent event) {
                            print("listener");
                            setState(() {
                              viewModel.referenceBox = viewModel
                                  .paintKey.currentContext
                                  .findRenderObject();
                              viewModel.offset = viewModel.referenceBox
                                  .globalToLocal(event.position);
                            });
                          },
                          child: CustomPaint(
                            foregroundPainter: MyCustomPainter(
                                viewModel.offset,
                                viewModel.ticketObjectForPainter ??
                                    viewModel.ticketStatistic),
                            key: viewModel.paintKey,
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  width: MediaQuery.of(context).size.width - 50,
                                  height:
                                      MediaQuery.of(context).size.width - 50),
                              child: charts.PieChart(
                                viewModel.seriesList,
                                animate: true,
//                              defaultRenderer: charts.ArcRendererConfig(
//                                  arcRendererDecorators: [
//                                    charts.ArcLabelDecorator(
//                                        labelPosition:
//                                            charts.ArcLabelPosition.outside)
//                                  ]),
                                selectionModels: [
                                  charts.SelectionModelConfig(
                                    type: charts.SelectionModelType.info,
                                    changedListener:
                                        (charts.SelectionModel model) {
                                      print("change líterner");
                                      print(model.selectedSeries[0]
                                          .data[model.selectedDatum[0].index]);
                                      setState(() {
                                        viewModel.ticketObjectForPainter = model
                                            .selectedSeries[0]
                                            .data[model.selectedDatum[0].index];
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          )

//                      Container(
//                        padding: EdgeInsets.all(0),
//                        margin: EdgeInsets.all(0),
//                        width: 300,
//                        height: 300,
//                        child: CustomPaint(
//                          key: viewModel.paintKey,
//                          foregroundPainter: MyCustomPainter(
//                              viewModel.offset,
//                              viewModel.ticketObjectForPainter ??
//                                  viewModel.ticketStatistic),
//                          child: charts.PieChart(
//                            viewModel.seriesList,
//                            animate: true,
//                            selectionModels: [
//                              charts.SelectionModelConfig(
//                                type: charts.SelectionModelType.info,
//                                changedListener: (charts.SelectionModel model) {
//                                  print("change líterner");
//                                  print(model.selectedSeries[0]
//                                      .data[model.selectedDatum[0].index]);
//                                  setState(() {
//                                    viewModel.ticketObjectForPainter = model
//                                        .selectedSeries[0]
//                                        .data[model.selectedDatum[0].index];
//                                  });
//                                },
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
                          ),
                    ),
              Container(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.8, crossAxisCount: 2),
                    itemCount: viewModel.dataChart.length,
                    itemBuilder: (context, index) {
                      return ___chartColorDescription(
                          color: Color(int.parse(
                              "0xff${viewModel.dataChart[index].xCatColor.substring(1, viewModel.dataChart[index].xCatColor.length)}")),
                          text: viewModel.dataChart[index].category,
                          index: index);
                    }),
              )
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        viewModel.onRefresh();
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
//            decoration: BoxDecoration(image: decorationImageBackground()),
            decoration:
                BoxDecoration(color: ThemePrimary.backgroundPrimaryColor),
          ),
          SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.9),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  __timeLine(),
                  __analyticSummary(
                      title: translation.text("DASHBOARD_PAGE.TOTAL_VOTE"),
                      countNumber: viewModel.ticketStatistic.ticketCount,
                      icon: Icons.insert_chart,
                      route: TicketsPage.routeName,
                      status: "all"),
                  __analyticSummary(
                      title: translation.text("DASHBOARD_PAGE.VOTE_DONE"),
                      countNumber: viewModel.ticketStatistic.ticketsDone,
                      icon: Icons.check_circle,
                      isCircleProgress: true,
                      route: TicketsPage.routeName,
                      status: "done"),
                  __analyticSummary(
                      title: translation.text("DASHBOARD_PAGE.TIME_RESPONSE"),
                      countNumber: viewModel.ticketStatistic.ticketsAvgTime,
                      icon: Icons.show_chart,
                      isTime: true),
                  __chartSection(),
                  SizedBox(
                    height: 65,
                  )
                ],
              ),
            ),
          )
        ],

//        Column(
//          children: <Widget>[
//            __timeLine(),
//            __analyticSummary(
//                title: translation.text("DASHBOARD_PAGE.TOTAL_VOTE"),
//                countNumber: viewModel.ticketStatistic.ticketCount,
//                icon: Icons.insert_chart,
//                route: TicketsPage.routeName,
//                status: "all"),
//            __analyticSummary(
//                title: translation.text("DASHBOARD_PAGE.VOTE_DONE"),
//                countNumber: viewModel.ticketStatistic.ticketsDone,
//                icon: Icons.check_circle,
//                isCircleProgress: true,
//                route: TicketsPage.routeName,
//                status: "done"),
//            __analyticSummary(
//                title: translation.text("DASHBOARD_PAGE.TIME_RESPONSE"),
//                countNumber: viewModel.ticketStatistic.ticketsAvgTime,
//                icon: Icons.show_chart,
//                isTime: true),
//            __chartSection()
//          ],
//        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.tabsPageViewModel = ViewModelProvider.of(context);
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder<Object>(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            appBar: _appBar(),
            body: _body(),
          );
        },
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final Offset offset;
  final TicketStatistic ticket;

  MyCustomPainter(this.offset, this.ticket);

  @override
  void paint(Canvas canvas, Size size) {
    if (offset == null) return;
    print("${offset.dx}  ${offset.dy}");

    String messageTooltip =
        "${translation.text("DASHBOARD_PAGE.VALUE")}: ${ticket.ticketCount ?? 0}\n"
        "${translation.text("DASHBOARD_PAGE.TIME_AVG")}: ${ticket.ticketsAvgTime.toStringAsFixed(0) ?? 0}\n"
        "${translation.text("DASHBOARD_PAGE.TICKET_DONE")}: ${ticket.ticketsDone ?? 0}";

    final paragraphStyle = ParagraphStyle(textAlign: TextAlign.left);
    final paragraphBuilder = ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(
        color: Colors.white,
      ))
//          color: Colors.white, background: Paint()..color = Colors.black38))
      ..addText(messageTooltip);

    final paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: 240));

//    final right = paragraph.width;
//    final right = paragraph.longestLine;
//    final right = paragraph.maxIntrinsicWidth;
//    final right = paragraph.minIntrinsicWidth;
//    final bottom = paragraph.height;
//    final rect = Rect.fromLTRB(offset.dx - 40, offset.dy, 100, 100);
    var rect = Rect.fromLTWH(offset.dx - 10, offset.dy - 3,
        paragraph.longestLine + 15, paragraph.height + 10);

    if (offset.dx.round() > 230) {
      rect = Rect.fromLTWH(offset.dx - 160, offset.dy - 3,
          paragraph.longestLine + 15, paragraph.height + 10);
    }
    final paint = Paint()
      ..color = Colors.black38
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(5)), paint);

    if (offset.dx.round() > 230) {
      canvas.drawParagraph(
        paragraph,
        Offset(offset.dx - 150, offset.dy),
      );
    } else {
      canvas.drawParagraph(
        paragraph,
        offset,
      );
    }
  }

  @override
//  bool shouldRepaint(MyCustomPainter other) => other.offset != offset;
  bool shouldRepaint(MyCustomPainter other) => other.offset != offset;
}
