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
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PointsSlider(),
      ),
    );
  }
}

class PointsSlider extends StatefulWidget {
  const PointsSlider({Key? key}) : super(key: key);

  @override
  _PointsSliderState createState() => _PointsSliderState();
}

class _PointsSliderState extends State<PointsSlider> {
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
  int actualTeam = 0;
  int actualRound = 0;
  int tessera = rng.nextInt(100);


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
    super.initState();
    loadJsonData();

  }

  @override
  Widget build(BuildContext context) {
    _refreshBottomPlacement();
    //positioning using a relative distance from the top or the bottom
    //we first place the max points block using random positioning in the stack and then build the
    //rest of the point bar working from it.
    return Column(
      children: [
        Card(
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
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
              valueIndicatorShape:
                  SliderComponentShape.noOverlay, //no value tag when dragged

              trackShape: const RectangularSliderTrackShape(),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: bottomPlacement,
                  child: Container(
                    width: width,
                    height: blockHeight,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  bottom: bottomPlacement + blockHeight,
                  child: Container(
                    width: width,
                    height: blockHeight,
                    color: Colors.orange,
                  ),
                ),
                Positioned(
                  bottom: bottomPlacement - blockHeight,
                  child: Container(
                    width: width,
                    height: blockHeight,
                    color: Colors.orange,
                  ),
                ),
                Positioned(
                  bottom: bottomPlacement + 2 * blockHeight,
                  child: Container(
                    width: width,
                    height: blockHeight,
                    color: Colors.yellow,
                  ),
                ),
                Positioned(
                  bottom: bottomPlacement - 2 * blockHeight,
                  child: Container(
                    width: width,
                    height: blockHeight,
                    color: Colors.yellow,
                  ),
                ),
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
                      onChanged: (value) => setState(() => this.value = value),
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
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: MaterialButton(
            height: 40,
            child: Text('conferma'),
            minWidth: 100,
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(
                context,
                StartGame.routeName,
              );
            },
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
    );
  }
}
