import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flame/game.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:brick_breaker/breaker_game.dart';
import 'package:get_it/get_it.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key, required this.game});

  final BrickBreakerGame game;

  @override
  Widget build(BuildContext context) {
    final gameStore = GetIt.instance.get<GameStore>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          'assets/logo.svg',
          width: 200,
        ),
        const SizedBox(height: 20),
        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          color: GameConstants.backGroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(
                builder: (context) {
                  return GestureDetector(
                    onTap: () => gameStore.gameState = GameState.pause,
                    child: Icon(
                      gameStore.paused ? Icons.play_arrow : Icons.pause,
                      color: GameConstants.whiteColor,
                    ),
                  );
                },
              ),
              Observer(
                builder: (context) {
                  return Text(
                    gameStore.score.toString(),
                    style: const TextStyle(
                      color: GameConstants.whiteColor,
                      fontSize: 26,
                    ),
                  );
                },
              ),
              Column(
                children: [
                  const Text(
                    'Best',
                    style: TextStyle(
                      color: GameConstants.whiteColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Observer(
                    builder: (context) {
                      return Text(
                        gameStore.highScore.toString(),
                        style: const TextStyle(
                          color: GameConstants.whiteColor,
                          fontSize: 22,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GameWidget(game: game),
        ),
        const SizedBox(height: 100)
      ],
    );
  }
}