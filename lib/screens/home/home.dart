import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/model/dashboard_model.dart';

import '../../util/events.dart';
import 'create.dart';
import 'dashboard.dart';

class HomePage extends StatefulWidget {
  static const tag = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  PageController? _pageController;
  int _currentPage = 0;
  late List<TabBarModel> bottomNavigationItems;
  DashboardPage dashboardPage = const DashboardPage();
  CreatePage createPage = CreatePage();
  late StreamSubscription eventbus;

  @override
  void initState() {
    bottomNavigationItems = [
      TabBarModel(page: dashboardPage, title: 'Home', icon: FeatherIcons.home),
      TabBarModel(page: createPage, title: 'Create', icon: FeatherIcons.hash),
      TabBarModel(page: Container(), title: 'Plans', icon: FeatherIcons.user)
    ];
    _pageController = PageController(initialPage: 0, keepPage: true);
    eventbus = EventBusHelper.instance
        .getEventBus()
        .on<GenerateHashtagEvent>()
        .listen((event) {
      if (event.file != null) {
        _pageController?.animateToPage(1,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
        setState(() {
          _currentPage = 1;
        });
        createPage.getLabels(event.file!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pixher'),
        toolbarHeight: 44,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.menu)),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: bottomNavigationItems.map((item) => item.page!).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationItems.map((item) {
          final index = bottomNavigationItems.indexOf(item);
          return BottomNavigationBarItem(
            icon: Icon(
              item.icon,
              size: 20,
            ),
            label: item.title,
          );
        }).toList(),
        currentIndex: _currentPage,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
          _pageController?.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    eventbus.cancel();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
