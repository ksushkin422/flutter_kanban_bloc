import 'package:flutter/material.dart';
// import 'package:kanban/screens/cards.dart';
import 'package:kanban/screens/cards_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then((instance) async {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'auth/',
      routes: {
        'auth/': (context) => Auth(),
        // 'cards/': (context) => Cards(),
        'cardsB/': (context) => CardWidget(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
