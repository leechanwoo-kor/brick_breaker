import 'package:brick_breaker/breaker_game.dart';
import 'package:brick_breaker/game_board.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:brick_breaker/screens/gameover_screen.dart';
import 'package:brick_breaker/screens/launch_screen.dart';
import 'package:brick_breaker/screens/pause_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class GameApp extends StatelessWidget {
  const GameApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var game = BrickBreakerGame();
    final gameStore = GetIt.instance.get<GameStore>();
    return MaterialApp(
      home: Observer(
        builder: (context) {
          switch (gameStore.gameState) {
            case GameState.launch:
              return LaunchScreen();
            case GameState.play:
              if (gameStore.doGameRestart) {
                game = BrickBreakerGame();
                gameStore
                  ..doGameRestart = false
                  ..resetScore();
              }
              return GameBoard(game: game);
            case GameState.pause:
              return PauseScreen();
            case GameState.gameOver:
              return GameOverScreen();
            default:
              return LaunchScreen();
          }
        },
      ),
    );
  }
}
