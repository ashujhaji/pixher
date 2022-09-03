import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/model/dashboard_model.dart';
import 'package:pixer/screens/home/more.dart';
import 'package:pixer/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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
  final GlobalKey _scaffoldKey = GlobalKey();
  final drawerItems = [
    'Support',
    'Leave Rating',
    'Terms of Use',
    'Privacy Policy',
    'Licenses'
  ];
  bool darkTheme = false;

  @override
  void initState() {
    bottomNavigationItems = [
      TabBarModel(
        page: dashboardPage,
        title: 'Pick',
        icon: FeatherIcons.smartphone,
      ),
      TabBarModel(
        page: Container(),
        title: '',
        icon: FeatherIcons.hash,
        activeIcon: Image.asset(
          'assets/images/hashtag.png',
        ),
      ),
      TabBarModel(
        page: morePage,
        title: 'Join',
        icon: FeatherIcons.grid,
      )
    ];
    _pageController = PageController(initialPage: 0, keepPage: true);
    eventbus = EventBusHelper.instance
        .getEventBus()
        .on<GenerateHashtagEvent>()
        .listen((event) {
      if (event.file != null) {
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
      key: _scaffoldKey,
      extendBody: true,
      extendBodyBehindAppBar: true,
      drawer: _drawerWidget(context),
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
    );
  }

  Route _openCreate() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => createPage,
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

  Widget _drawerWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: MediaQuery.of(context).size.width / 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              FeatherIcons.x,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                drawerItems[index],
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () {},
            );
          },
          itemCount: drawerItems.length,
        ),
        bottomSheet: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            ListTile(
              title: Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: Transform.scale(
                scale: 0.7,
                child: FutureBuilder<bool>(
                  future: Provider.of<DarkThemeProvider>(context)
                      .darkThemePreference
                      .getTheme(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      darkTheme = snapshot.data ?? false;
                      return CupertinoSwitch(
                        value: darkTheme,
                        onChanged: (value) async {
                          darkTheme = !darkTheme;
                          Provider.of<DarkThemeProvider>(context, listen: false)
                              .darkTheme = value;
                        },
                        activeColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        thumbColor: Theme.of(context).backgroundColor,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(FeatherIcons.instagram),
                  const SizedBox(width: 8,),
                  Text(
                    'pixher.app',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              onTap: (){

              },
            ),
            const SizedBox(height: 20,),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
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
