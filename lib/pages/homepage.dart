import 'package:filit/pages/slider_page.dart';
import 'package:flutter/material.dart';
import 'slider_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This widget is the root of your application.
  var _team = 2;
  var _round = 5;

  initializeGame() {
    Navigator.pushNamed(
      context,
      StartGame.routeName,
      arguments: {
        'round': _round,
        'teams': _team,
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // riga per bottone impostazioni
            Align(
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('...',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black)),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Card(
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                        child: Text(
                          'Squadre',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ink(
                      height: 28,
                      decoration: const ShapeDecoration(
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        iconSize: 10,
                        color: Colors.white,
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_team > 2) {
                            setState(() {
                              _team--;
                            });
                          }
                        },
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                        child: Text(
                          '$_team',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Ink(
                      height: 28,
                      decoration: const ShapeDecoration(
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        //
                        iconSize: 15,
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_team < 5) {
                            setState(() {
                              _team++;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Card(
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                        child: Text(
                          'Round',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Ink(
                      height: 28,
                      decoration: const ShapeDecoration(
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        iconSize: 10,
                        color: Colors.white,
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (_round > 2) {
                            setState(() {
                              _round--;
                            });
                          }
                        },
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                        child: Text(
                          '$_round',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Ink(
                      height: 28,
                      decoration: const ShapeDecoration(
                        color: Colors.blue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        iconSize: 10,
                        color: Colors.white,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (_round < 8) {
                            setState(() {
                              _round++;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //bottone play
            Container(
              // color: Colors.amber,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 20.0),
              child: MaterialButton(
                height: 70.0,
                minWidth: 150.0,
                color: Colors.red,
                textColor: Colors.white,
                onPressed: initializeGame,
                child: const Text(
                  'Play!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
