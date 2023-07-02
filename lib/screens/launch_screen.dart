import 'package:flutter/material.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:get_it/get_it.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Add this
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Welcome to the Game',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ElevatedButton(
                onPressed: () {
                  GetIt.instance.get<GameStore>().gameState = GameState.play;
                },
                child: Text('Start Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
