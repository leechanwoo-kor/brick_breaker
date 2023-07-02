import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Game Over', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                // Here you need to setup logic to restart the game
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
