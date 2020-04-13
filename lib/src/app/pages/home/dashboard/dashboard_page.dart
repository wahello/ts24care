import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/ticketStatistic.dart';
import 'package:ts24care/src/app/pages/home/dashboard/dashboard_page_viewmodel.dart';
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
        isCircleProgress = false}) {
      return Container(
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
                    ? LoadingIndicator.spinner(context: context, loading: true)
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
                      "${viewModel.percentTicketDone.round()}%",
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
      );
    }

    Widget __chartSection() {
      Widget ___chartColorDescription({Color color, String text}) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                color: color,
                margin: EdgeInsets.only(right: 5),
              ),
              Text(text)
            ],
          ),
        );
      }

      Widget ____tooltip() {
        return Container(
          width: 30,
          height: 30,
          color: Colors.white,
        );
      }

      return Container(
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
            Container(
                width: 300,
                height: 300,
                // decoration: BoxDecoration(
                //     color: Colors.red,
                //     borderRadius: BorderRadius.all(Radius.circular(20))),
                child: viewModel.seriesList == null
                    ? Offstage()
                    : Listener(onPointerDown: (PointerDownEvent event) {
                        print("listener");
                        setState(() {
                          viewModel.referenceBox = viewModel
                              .paintKey.currentContext
                              .findRenderObject();
                          viewModel.offset = viewModel.referenceBox
                              .globalToLocal(event.position);
                        });
                      }, child: Builder(
                        builder: (context) {
                          return CustomPaint(
                            key: viewModel.paintKey,
//                                painter: MyCustomPainter(viewModel.offset,
//                                    viewModel.ticketObjectForPainter),
                            foregroundPainter: MyCustomPainter(
                                viewModel.offset,
                                viewModel.ticketObjectForPainter ??
                                    TicketStatistic(
                                        category: null,
                                        ticketCount: 0,
                                        ticketsAvgTime: 0,
                                        ticketsDone: 0)),
                            child: charts.PieChart(
                              viewModel.seriesList,
                              animate: true,
                              selectionModels: [
                                charts.SelectionModelConfig(
                                  type: charts.SelectionModelType.info,
                                  changedListener:
                                      (charts.SelectionModel model) {
                                    print("change líterner");
//                                    print(model.selectedSeries[0]
//                                        .data[model.selectedDatum[0].index]);
                                    print(model.selectedSeries[0].measureFn(
                                        model.selectedDatum[0].index));
                                    setState(() {
//                                      viewModel.ticketObjectForPainter = model
//                                          .selectedSeries[0]
//                                          .data[model.selectedDatum[0].index];
                                      viewModel.ticketObjectForPainter =
                                          viewModel.ticketStatistic;
                                      viewModel.ticketObjectForPainter
                                              .chartValue =
                                          model.selectedSeries[0].measureFn(
                                              model.selectedDatum[0].index);
                                      print("*******");
                                      print(viewModel
                                          .ticketStatistic.ticketCount);
                                      print(viewModel
                                          .ticketStatistic.ticketsDone);
                                      print(viewModel
                                          .ticketStatistic.ticketsAvgTime);
                                      print(viewModel.ticketStatistic.category);
                                      print(
                                          viewModel.ticketStatistic.xCatColor);
                                      print("******");
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ))),
            Container(
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: viewModel.dataChart.length,
                  itemBuilder: (context, index) {
                    return ___chartColorDescription(
                        color: Color(int.parse(
                            "0xff${viewModel.dataChart[index].xCatColor.substring(1, viewModel.dataChart[index].xCatColor.length)}")),
                        text: viewModel.dataChart[index].category);
                  }),
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        viewModel.onRefresh();
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(image: decorationImageBackground()),
            child: Column(
              children: <Widget>[
                __timeLine(),
                __analyticSummary(
                    title: translation.text("DASHBOARD_PAGE.TOTAL_VOTE"),
                    countNumber: viewModel.ticketStatistic.ticketCount,
                    icon: Icons.insert_chart),
                __analyticSummary(
                    title: translation.text("DASHBOARD_PAGE.VOTE_DONE"),
                    countNumber: viewModel.ticketStatistic.ticketsDone,
                    icon: Icons.check_circle,
                    isCircleProgress: true),
                __analyticSummary(
                    title: translation.text("DASHBOARD_PAGE.TIME_RESPONSE"),
                    countNumber: viewModel.ticketStatistic.ticketsAvgTime,
                    icon: Icons.show_chart,
                    isTime: true),
                __chartSection()
              ],
            ),
          ),
        ),
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
    print("%%%%%%%%%%%%%%%%%%%%");
    print(offset);
    print(ticket.ticketsDone);
    // draw text
    final paragraphStyle = ParagraphStyle(textAlign: TextAlign.left);
    final paragraphBuilder = ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(color: Colors.black87))
      ..addText("${translation.text("DASHBOARD_PAGE.VALUE")}: ")
      ..addText(ticket.chartValue.toString())
      ..addText("\n${translation.text("DASHBOARD_PAGE.TIME_AVG")}: ")
      ..addText(ticket.ticketsAvgTime.toString())
      ..addText("\n${translation.text("DASHBOARD_PAGE.TICKET_DONE")}: ")
      ..addText(ticket.ticketsDone.toString());

    final paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: 300));

    if (offset == null) return;
    canvas.drawCircle(Offset(offset.dx, offset.dy - 3), 3.0,
        new Paint()..color = Colors.blue);
    canvas.drawParagraph(paragraph, offset);
  }

  @override
//  bool shouldRepaint(MyCustomPainter other) => other.offset != offset;
  bool shouldRepaint(MyCustomPainter other) => true;
}
