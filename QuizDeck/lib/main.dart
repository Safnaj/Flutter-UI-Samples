import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quizdeck/provider/flash_card_provider.dart';

import 'package:quizdeck/provider/preferencesProvider.dart';
import 'package:quizdeck/screens/add_deck_screen.dart';
import 'package:quizdeck/screens/add_flash_card.dart';
import 'package:quizdeck/screens/analytics_screen.dart';
import 'package:quizdeck/screens/authentication_screen.dart';
import 'package:quizdeck/screens/deck_screen.dart';
import 'package:quizdeck/screens/home_screen.dart';
import 'package:quizdeck/screens/settings_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Database db = await FlashCardProvider.initializeDb();
  runApp(MyApp(prefs, db));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final db;
  MyApp(this.prefs, this.db);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlashCardProvider(db)),
        ChangeNotifierProvider(create: (_) => PreferencesProvider(prefs)),
      ],
      child: MainApp(prefs: prefs),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
    required this.prefs,
  }) : super(key: key);

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    context.watch<PreferencesProvider>();
    return MaterialApp(
      title: "Quiz Deck",
      home: HomeScreen(),
      darkTheme: ThemeData(
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
          ),
          dialogBackgroundColor: Colors.grey[800],
          cardColor: Colors.grey[800],
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: "Inter",
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
          scaffoldBackgroundColor: Colors.grey[900],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              focusColor: Theme.of(context).accentColor,
              splashColor: Theme.of(context).accentColor,
              hoverColor: Theme.of(context).accentColor,
              backgroundColor: Color(0xFF4949f5),
              foregroundColor: Colors.white),
          fontFamily: "Inter",
          primaryColor: Color(0xFF4949f5),
          accentColor: Color(0xFF12e39d)),
      themeMode:
          prefs.getBool("darkMode") == true ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              focusColor: Theme.of(context).accentColor,
              splashColor: Theme.of(context).accentColor,
              backgroundColor: Color(0xFF4949f5),
              foregroundColor: Colors.white),
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: "Inter",
                bodyColor: Colors.black,
                displayColor: Colors.black,
              ),
          fontFamily: "Inter",
          primaryColor: Color(0xFF4949f5),
          accentColor: Color(0xFF12e39d)),
      routes: {
        AuthenticationScreen.routeName: (context) => AuthenticationScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        AddDeckScreen.routeName: (context) => AddDeckScreen(),
        DeckScreen.routeName: (context) => DeckScreen(),
        AddFlashCardScreen.routeName: (context) => AddFlashCardScreen(),
        AnalyticsScreen.routeName: (context) => AnalyticsScreen(),
      },
    );
  }
}
