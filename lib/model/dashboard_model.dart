import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../screens/home/create.dart';
import '../screens/home/dashboard.dart';


class TabBarModel {
  Widget? page;
  String? title;
  IconData? icon;
  Widget? activeIcon;

  TabBarModel({this.page, this.title, this.icon, this.activeIcon});

  static List<TabBarModel> getTabBarItems(
      {BuildContext? context, Function? tabClickHandler}) {
    return [
      TabBarModel(
          page: const DashboardPage(), title: 'Home', icon: FeatherIcons.home),
      TabBarModel(page: const CreatePage(), title: 'Create', icon: FeatherIcons.hash),
      TabBarModel(
          page: Container(), title: 'Plans', icon: FeatherIcons.user)
    ];
  }
}
