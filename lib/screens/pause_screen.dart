import 'package:flutter/material.dart';

class PauseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Game Paused', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                // Here you need to setup logic to resume the game
              },
              child: Text('Resume Game'),
            ),
          ],
        ),
      ),
    );
  }
}
