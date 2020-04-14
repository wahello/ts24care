import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/app_setting.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/ticketStatistic.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ts24care/src/app/models/ts24_product_category.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page_viewmodel.dart';

class DashboardPageViewModel extends ViewModelBase {
  DashboardPageViewModel() {
    getStatisticTicket(month: 1);
    getStatisticTicketByCategory(month: 1);
  }
  TabsPageViewModel tabsPageViewModel;
  List<charts.Series> seriesList;
  bool animate = false;
  bool isSpinnerInText = true;
  Offset offset;
  RenderBox referenceBox;
  GlobalKey paintKey = GlobalKey();

  TicketStatistic ticketObjectForPainter;
  String messageTooltip = "";
  List<TicketStatistic> dataChart = [
//     TicketChart(0, 6, "#ff3300"),
//     TicketChart(1, 9, "#009900"),
//     TicketChart(2, 1, "#8c8c8c"),
//     TicketChart(3, 7, "#ff9900"),
  ];

  List<charts.Series<TicketStatistic, int>> _createChartData() {
    return [
      charts.Series<TicketStatistic, int>(
        id: 'Chart',
        domainFn: (TicketStatistic ticket, _) => ticket.index,
        measureFn: (TicketStatistic ticket, _) => ticket.ticketCount,
        colorFn: (TicketStatistic ticket, _) =>
            charts.Color.fromHex(code: ticket.xCatColor),
        data: dataChart,
//        labelAccessorFn: (TicketStatistic ticket, _) =>
//            "${translation.text("DASHBOARD_PAGE.VALUE")}: ${ticket.ticketCount}",
//                "\n${translation.text("DASHBOARD_PAGE.TIME_AVG")}: ${sales.ticketsAvgTime?? 0}"
//                "\n${translation.text("DASHBOARD_PAGE.TICKET_DONE")}: ${sales.ticketsDone??0}",
      )
    ];
  }

  var dropdownValue = "30";
  int monthValueRefresh = 1;
  List<String> listDropdownValue = ['30', '2', '3'];

  TicketStatistic ticketStatistic = TicketStatistic(
      category: "", ticketCount: 0, ticketsAvgTime: 0, ticketsDone: 0);

  double percentTicketDone = 0.0;
  final GlobalKey keyTooltip = GlobalKey();

  void onRefresh() {
    getStatisticTicketByCategory(month: monthValueRefresh);
    getStatisticTicket(month: monthValueRefresh);
  }

  void updateForCustomPainter(TicketStatistic ticket) {
    ticketObjectForPainter = ticket;
    this.updateState();
  }

  int i = 0;

  updateText() {
    messageTooltip = (i++).toString();
    dynamic tooltip = keyTooltip.currentState;
    tooltip.ensureTooltipVisible();
    this.updateState();
  }

  void updateMessageTooltip(String message) {
    print(messageTooltip);
    messageTooltip = "${translation.text("DASHBOARD_PAGE.VALUE")}: $message"
        "\n${translation.text("DASHBOARD_PAGE.TIME_AVG")}: ${ticketStatistic.ticketsAvgTime}"
        "\n${translation.text("DASHBOARD_PAGE.TICKET_DONE")}: ${ticketStatistic.ticketsDone}";
    this.updateState();

    dynamic tooltip = keyTooltip.currentState;
    print(tooltip.runtimeType);
    tooltip.ensureTooltipVisible();
  }

  void updateDropdownValue(String valueString) {
    isSpinnerInText = true;
    this.updateState();
    int monthValue = int.parse(valueString);
    if (monthValue == 30) monthValue = 1;
    dropdownValue = valueString;
    getStatisticTicket(month: monthValue);
    getStatisticTicketByCategory(month: monthValue);
    monthValueRefresh = monthValue;
    this.updateState();
  }

  String findColor(String nameCat) {
    String correctColor = "#999999";
    TS24ProductCategory.list.forEach((item) {
      if (nameCat.contains(item.name)) correctColor = item.colorString;
    });
    return correctColor;
  }

  Future<void> getStatisticTicketByCategory({int month}) async {
    dataChart = [];
    this.updateState();
    List<TicketStatistic> listData = await api.statisticTicketByCategory(month);
    print("hello and helelo");
    print(listData[0].ticketsDone);
    print(listData[0].category);
    print(listData[0].xCatColor);
    print(listData[0].ticketsAvgTime);

    for (var i = 0; i < listData.length; i++) {
      String categoryName = listData[i].category;
      String xCatColor = listData[i].xCatColor.toString();
      int ticketCount = listData[i].ticketCount;
      dataChart.add(TicketStatistic(
          index: i,
          ticketCount: ticketCount,
          ticketsAvgTime: listData[i].ticketsAvgTime,
          ticketsDone: listData[i].ticketsDone,
          xCatColor: xCatColor == "" || xCatColor == "false"
              ? findColor(categoryName)
              : xCatColor,
          category: categoryName == ""
              ? translation.text("DASHBOARD_PAGE.ITEM_OTHER")
              : categoryName));
    }
    seriesList = _createChartData();

    this.updateState();
  }

  Future<void> getStatisticTicket({int month}) async {
    try {
      TicketStatistic data = await api.statisticTicket(month);
      if (data != null) {
        double timeAvgToInt = data.ticketsAvgTime;
        ticketStatistic.ticketsDone = data.ticketsDone;
        ticketStatistic.ticketCount = data.ticketCount;
        ticketStatistic.ticketsAvgTime = timeAvgToInt.round();
        percentTicketDone = (data.ticketsDone * 100) / data.ticketCount;
        print("percent");
        print(percentTicketDone / 100);
        this.updateState();
      }
    } catch (e) {
      print(e);
    }
    isSpinnerInText = false;
    this.updateState();
  }

  onTapAnalyticSummary(String status) {
    switch (status) {
      case "done":
        tabsPageViewModel.onOpenTicketPage(3);
        break;
      case "all":
        tabsPageViewModel.onOpenTicketPage(0);
        break;
      default:
    }
  }
}

class TicketChart {
  final String categoryName;
  final int index;
  final int tickCount;
  final String color;

  TicketChart(this.index, this.tickCount, this.color, this.categoryName);
}
