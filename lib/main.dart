import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixer/screens/stories.dart';
import 'package:provider/provider.dart';

import 'screens/home/home.dart';
import 'screens/playground.dart';
import 'theme/theme.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

  const MyApp myApp = MyApp(
    initialRoute: HomePage.tag,
  );

  Firebase.initializeApp();

  runApp(myApp);
}

class MyApp extends StatefulWidget {
  final String? initialRoute;

  const MyApp({Key? key, this.initialRoute}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = true;
    //await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              initialRoute: widget.initialRoute,
              title: 'Pixher',
              onGenerateRoute: (RouteSettings settings) {
                List<dynamic> args = settings.arguments != null
                    ? (settings.arguments as List<dynamic>)
                    : [];
                switch (settings.name) {
                  case HomePage.tag:
                    {
                      return MaterialPageRoute(
                          builder: (context) => const HomePage(),
                          settings: RouteSettings(name: settings.name));
                    }

                  case StoriesPage.tag:
                    {
                      return MaterialPageRoute(
                          builder: (context) => StoriesPage(
                                category: ((args.isNotEmpty) ? args[0] : null),
                                currentPage: (args.length >= 2) ? args[1] : 0,
                              ),
                          settings: RouteSettings(name: settings.name));
                    }
                  case PlaygroundPage.tag:
                    {
                      return MaterialPageRoute(
                          builder: (context) => PlaygroundPage(
                            dimensions: ((args.isNotEmpty) ? args[0] : null),
                            template: (args.length >= 2) ? args[1] : null,
                          ),
                          settings: RouteSettings(name: settings.name));
                    }
                }
                return null;
              });
        },
      ),
    );
  }
}
