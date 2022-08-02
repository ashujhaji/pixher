import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:pixer/model/dashboard_model.dart';

class HomePage extends StatefulWidget {
  static const tag = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<TabBarModel> bottomNavigationItems = TabBarModel.getTabBarItems();
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pixher'),
        toolbarHeight: 44,
        leading: IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.menu)),
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
    super.dispose();
  }
}
