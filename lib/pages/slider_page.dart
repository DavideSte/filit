import 'package:filit/pages/finalscore.dart';
import 'package:filit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class StartGame extends StatefulWidget {
  static const routeName = '/start_game';

  const StartGame({Key? key}) : super(key: key);

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  static final rng = Random();
  static const double blockHeight = 12;
  static const double barHeight = 450;
  static const double width = 80;
  double bottomPlacement = rng.nextDouble() * (barHeight - blockHeight);

  int points = 0;
  double value = 75;

  static late Map<String, dynamic> jsonRead;
  String parola1 = '';
  String parola2 = '';
  int actualTeam = 1;
  int actualRound = 1;
  late int totalPlayer;
  late int totalRound;

  int tessera = rng.nextInt(100);
  bool guess = false;
  bool gameInitialized = false;

  var pointsList = [];

  void inizializzaPartita(teams, round) {
    gameInitialized = true;
    for (var i = 0; i < teams; i++) {
      pointsList.add(0);
    }
    totalPlayer = teams;
    totalRound = round;
  }

  void _refreshBottomPlacement() {
    setState(() {
      //i'm in red zone
      if (value >= bottomPlacement && value < bottomPlacement + blockHeight) {
        points = 5;
      }
      //i'm in orange zone
      else if ((value >= bottomPlacement + blockHeight &&
              value < bottomPlacement + 2 * blockHeight) ||
          (value <= bottomPlacement && value > bottomPlacement - blockHeight)) {
        points = 3;
      }
      //i'm in yellow zone
      else if ((value >= bottomPlacement + 2 * blockHeight &&
              value < bottomPlacement + 3 * blockHeight) ||
          (value <= bottomPlacement - blockHeight &&
              value > bottomPlacement - 2 * blockHeight)) {
        points = 1;
      } else {
        points = 0;
      }
    });
  }

  void guessPosition() {
    pointsList[actualTeam - 1] = pointsList[actualTeam - 1] + points;
    if (guess) {
      guess = false;
    } else {
      guess = true;
    }
    bottomPlacement = rng.nextDouble() * (barHeight - blockHeight);
    tessera = rng.nextInt(100);
    loadJsonData();
    if (actualTeam == totalPlayer && actualRound == totalRound) {
      Navigator.pushNamed(
        context,
        FinalScore.routeName,
        arguments: {
          'finalPoints': pointsList,
        },
      );
    }
    if (actualTeam < totalPlayer) {
      actualTeam++;
    } else {
      actualRound++;
      actualTeam = 1;
    }
    setState(() {});
  }

  void parolaScelta() {
    if (guess) {
      guess = false;
    } else {
      guess = true;
    }
    setState(() {});
  }

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/files/schede.json');
    jsonRead = json.decode(jsonText);
    setState(() {
      parola1 = jsonRead['scheda-$tessera']['Parola_1'];
      parola2 = jsonRead['scheda-$tessera']['Parola_2'];
    });
    return 'success';
  }

  @override
  void initState() {
    print('init state');
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    _refreshBottomPlacement();

    // solo la prima volta che costuisco il widget inizializzo parametri
    if (!gameInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments as Map;
      int teams = args['teams'];
      int round = args['round'];
      inizializzaPartita(teams, round);
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('ROUND: $actualRound / $totalRound'),
            Text('Squadra: $actualTeam / $totalPlayer'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  MyHomePage.routeName,
                );
              },
              child: const Text('Go Home!'),
            ),
            Card(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Text(
                  parola1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              color: Colors.black,
              height: barHeight,
              width: width,
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: width, //larghezza
                  thumbShape: SliderComponentShape
                      .noOverlay, //doesn't show the dot that's draggable
                  overlayShape: SliderComponentShape
                      .noOverlay, //its shade doesn't show up either
                  valueIndicatorShape: SliderComponentShape
                      .noOverlay, //no value tag when dragged

                  trackShape: const RectangularSliderTrackShape(),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: bottomPlacement,
                      child: Container(
                        width: width,
                        height: blockHeight,
                        color: !guess ? Colors.red : Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: bottomPlacement + blockHeight,
                      child: Container(
                        width: width,
                        height: blockHeight,
                        color: !guess ? Colors.orange : Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: bottomPlacement - blockHeight,
                      child: Container(
                        width: width,
                        height: blockHeight,
                        color: !guess ? Colors.orange : Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: bottomPlacement + 2 * blockHeight,
                      child: Container(
                        width: width,
                        height: blockHeight,
                        color: !guess ? Colors.yellow : Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: bottomPlacement - 2 * blockHeight,
                      child: Container(
                        width: width,
                        height: blockHeight,
                        color: !guess ? Colors.yellow : Colors.black,
                      ),
                    ),
                    if (guess)
                      Opacity(
                        opacity: 1,
                        child: RotatedBox(
                          quarterTurns: 3, //to rotate the slider
                          child: Slider(
                            value: value,
                            min: 0,
                            max: barHeight,
                            divisions: barHeight.toInt(),
                            label: value.round().toString(),
                            onChanged: (value) =>
                                setState(() => this.value = value),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Card(
              color: Colors.green,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                child: Text(
                  parola2,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
            guess
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      height: 40,
                      child: const Text('conferma'),
                      minWidth: 100,
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: guessPosition,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      height: 40,
                      child: const Text('prosegui'),
                      minWidth: 100,
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: parolaScelta,
                    ),
                  ),
            Text(
              '${value.round()}  $points',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
