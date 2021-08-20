import 'package:flutter/material.dart';
import 'package:filit/pages/homepage.dart';
import 'pages/slider_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Filit',
      routes: {
        StartGame.routeName: (context) => const StartGame(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      // home: tempPage(),
    );
  }
}
