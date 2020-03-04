import 'package:flutter/material.dart';
import 'package:ts24care/src/app/models/menu.dart';
import 'package:ts24care/src/app/pages/tabs/tabs_page_viewmodel.dart';
import 'package:ts24care/src/app/widgets/ts24_scaffold_widget.dart';

class TabsPage extends StatefulWidget {
  static const String routeName = '/tabs';
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  TabsPageViewModel viewModel = TabsPageViewModel();
  Menu menu = Menu.tabMenu[0];
  Widget _body(Menu menu) {
    return menu.page;
  }

  onTap(int index) {
    setState(() {
      menu = Menu.tabMenu[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return TS24Scaffold(
//      appBar: TS24AppBar(
//        title: Text("Xero app"),
//      ),
      body: _body(menu),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: menu.index,
        items: Menu.tabMenu
            .map((item) => BottomNavigationBarItem(
          icon: Icon(
            item.iconData,
//                    color: menu.index == item.index
//                        ? ThemePrimary.primaryColor
//                        : Colors.grey,
          ),
          title: Text(
            item.title,
//                    style: TextStyle(color:  menu.index == item.index
//                        ? ThemePrimary.primaryColor
//                        : Colors.grey),
          ),
        ))
            .toList(),
      ),
    );
  }
}
