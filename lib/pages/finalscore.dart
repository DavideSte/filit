import 'package:flutter/material.dart';
import 'homepage.dart';

class FinalScore extends StatefulWidget {
  static const routeName = '/final_score';

  const FinalScore({Key? key}) : super(key: key);

  @override
  State<FinalScore> createState() => _FinalScoreState();
}

class _FinalScoreState extends State<FinalScore> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    List finalScore = args['finalPoints'];
    String esito = '';
    for (var i = 0; i < finalScore.length; i++) {
      esito = esito + 'Squadra${i+1} = ${finalScore[i]}\n';
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(esito),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  MyHomePage.routeName,
                );
              },
              child: const Text('Go Home!'),
            ),
          ],
        ),
      ),
    );
  }
}
