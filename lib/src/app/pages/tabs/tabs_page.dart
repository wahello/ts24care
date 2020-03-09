import 'package:flutter/material.dart';
import 'package:ts24care/src/app/core/baseViewModel.dart';
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

  @override
  Widget build(BuildContext context) {
    viewModel.context = context;
    return ViewModelProvider(
      viewmodel: viewModel,
      child: StreamBuilder(
        stream: viewModel.stream,
        builder: (context, snapshot) {
          return TS24Scaffold(
            body: PageView(
              controller: viewModel.controller,
              onPageChanged: viewModel.onTap,
              children: Menu.tabMenu.map((menu) => menu.page).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: viewModel.onTap,
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
          );
        },
      ),
    );
  }
}
