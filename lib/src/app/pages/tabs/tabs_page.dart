import 'package:flutter/material.dart';
import 'package:ts24care/src/app/app_localizations.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
import 'package:ts24care/src/app/models/menu.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:ts24care/src/app/theme/theme_primary.dart';
import 'package:ts24care/src/app/widgets/float_button_widget.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TabsPage extends StatefulWidget {
  static const String routeName = '/tabs';
  final TabsArgument args;
  TabsPage(this.args);
  @override
  _TabsPageState createState() => _TabsPageState();
}

class TabsArgument {
  final String routeChildName;
  TabsArgument({this.routeChildName});
}

class _TabsPageState extends State<TabsPage> {
  TabsPageViewModel viewModel = TabsPageViewModel();
  List<Widget> tabs;
  @override
  void initState() {
    super.initState();
    viewModel.navigateChild(widget.args);
  }
  void reloadText(){
    Menu.reload();
    tabs = Menu.tabMenu.map((menu) => menu.page).toList();
  }
  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    reloadText();
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
//            body:  viewModel.menu.page,
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: viewModel.controller,
              // onPageChanged: (index) {
              //   print(index);
              // },
              children: Menu.tabMenu.map((menu) => menu.page).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                viewModel.onTap(index);
              },
              currentIndex: viewModel.menu.index,
              items: Menu.tabMenu
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(
                          item.iconData,
//size: 30,
//                    color: menu.index == item.index
//                        ? ThemePrimary.primaryColor
//                        : Colors.grey,
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(fontSize: 12),
                        ),
                      ))
                  .toList(),
            ),
            floatingActionButton:
                // remove floating icon in dashboard index 0 (Menu file)
              viewModel.menu.index == 0 || viewModel.menu.index == 1 || viewModel.menu.index == 2
//                viewModel.menu.index == 1
                    ? FloatButtonWidget(
                        tooltip: translation.text("TAB_PAGE.HINT_MENU"),
                        onPressed: () {},
                        listFAB: [
                          FloatingActionButton(
                            backgroundColor: ThemePrimary.primaryColor,
                            heroTag: 10,
                            onPressed: () {
                              viewModel.onTapCreateTicket();
                            },
                            tooltip: translation.text("TAB_PAGE.HINT_ADD"),
                            child: Icon(Icons.create),
                          ),
                          FloatingActionButton(
                            backgroundColor: ThemePrimary.primaryColor,
                            heroTag: 11,
                            onPressed: (){
                              launch("tel://19006154");
                            },
                            tooltip: translation.text("TAB_PAGE.HINT_CARE"),
                            child: Icon(Icons.call),
                          ),
                          FloatingActionButton(
                            backgroundColor: ThemePrimary.primaryColor,
                            heroTag: 12,
                            onPressed: () {
                              viewModel.onTapChat();
                            },
                            tooltip: translation.text("TAB_PAGE.HINT_LIVE_CHAT"),
                            child: Icon(Icons.message),
                          )
                        ],
                        icon: Icons.menu,
                      )
                    : null,
          );
        },
      ),
    );
  }
}
