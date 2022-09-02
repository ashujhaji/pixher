import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/model/dashboard_model.dart';
import 'package:pixer/screens/home/more.dart';

import '../../util/circle_transition_clipper.dart';
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
  MorePage morePage = MorePage();
  late StreamSubscription eventbus;

  @override
  void initState() {
    bottomNavigationItems = [
      TabBarModel(
          page: dashboardPage, title: 'Pick', icon: FeatherIcons.smartphone),
      TabBarModel(
        page: Container(),
        title: '',
        icon: FeatherIcons.hash,
        activeIcon: Image.asset(
          'assets/images/hashtag.png',
        ),
      ),
      TabBarModel(page: morePage, title: 'About', icon: FeatherIcons.grid)
    ];
    _pageController = PageController(initialPage: 0, keepPage: true);
    eventbus = EventBusHelper.instance
        .getEventBus()
        .on<GenerateHashtagEvent>()
        .listen((event) {
      if (event.file != null) {
        /*_pageController?.animateToPage(1,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
        setState(() {
          _currentPage = 1;
        });*/
        Navigator.of(context).push(_openCreate());
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
      extendBodyBehindAppBar: true,
      /*appBar: AppBar(
        centerTitle: true,
        title: const Text('Pixher'),
        toolbarHeight: 44,
        leading:
            IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.menu)),
      ),*/
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: bottomNavigationItems.map((item) => item.page!).toList(),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          elevation: 10,
          type: BottomNavigationBarType.fixed,
          items: bottomNavigationItems.map((item) {
            final index = bottomNavigationItems.indexOf(item);
            return BottomNavigationBarItem(
              icon: index == 1
                  ? FloatingActionButton(
                      onPressed: () {
                        /*setState(() {
                          _currentPage = index;
                        });
                        _pageController?.animateToPage(index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);*/
                        Navigator.of(context).push(_openCreate());
                      },
                      backgroundColor: const Color(0xff282828),
                      child: Image.asset(
                        'assets/images/hashtag.png',
                        height: 35,
                      ),
                    )
                  : (_currentPage == index && item.activeIcon != null)
                      ? item.activeIcon!
                      : Icon(
                          item.icon,
                          size: 20,
                        ),
              label: item.title,
            );
          }).toList(),
          currentIndex: _currentPage,
          /*selectedItemColor: theme.APP_COLOR,
              unselectedItemColor: theme.iconColor.withOpacity(0.6),*/
          showUnselectedLabels: true,
          backgroundColor: Theme.of(context).backgroundColor,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
            _pageController?.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
          },
        ),
      ),

      /* BottomNavigationBar(
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
      ),*/
    );
  }

  Route _openCreate() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            createPage,
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var screenSIze = MediaQuery.of(context).size;
          var centerCircleClipper =
          Offset(screenSIze.width / 2, screenSIze.height - 60);

          double beginRadius = 0.0;
          double endRadius = screenSIze.height * 1.2;

          var radiusTween = Tween(begin: beginRadius, end: endRadius);
          var radiusTweenAnimation = animation.drive(radiusTween);

          return ClipPath(
            child: child,
            clipper: CircleTransitionClipper(
              radius: radiusTweenAnimation.value,
              center: centerCircleClipper,
            ),
          );
        });
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
