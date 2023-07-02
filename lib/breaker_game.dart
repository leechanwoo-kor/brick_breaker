import 'package:brick_breaker/components/board.dart';
import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/components/brick.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:math';

class BrickBreakerGame extends FlameGame with HasCollisionDetection, HasDraggablesBridge {

  final padding = 10.0;
  var noBricksLayer = 5;
  final Random random = Random();

  @override
  Color backgroundColor() => GameConstants.panelColor;
  final gameStore = GetIt.instance.get<GameStore>();
  final ball = DraggableBall();
  final board = Board();

  @override
  Future<void> onLoad() async {
    ball.priority = 1;
    gameStore
      ..score = noBricksLayer
      ..ballState = BallState.ideal;
    await loadInitialBrickLayer();
    await add(board);
    await add(ball);
  }

  @override
  Future<void> update(double dt) async {
    if (gameStore.ballState == BallState.completed) {
      final brickComponents = children.whereType<BrickComponent>().toList();
      for (final brick in brickComponents) {
        final nextYPosition = brick.position.y + brickSize + padding;
        if (board.size.y - ball.size.y <= nextYPosition + brick.size.y) {
          pauseEngine();
          gameStore.gameState = GameState.gameOver;
          return;
        }
        brick.position.y = nextYPosition;
      }
      final bricksLayer = getBrickLayer();
      for (var i = 0; i < GameConstants.noBricksInRow; i++) {
        await add(
          bricksLayer[i]
            ..position = Vector2(
              i == 0
                  ? padding
                  : bricksLayer[i - 1].position.x +
                      bricksLayer[i - 1].size.x +
                      padding,
              (brickSize + padding),
            ),
        );
      }
      noBricksLayer++;
      gameStore
        ..updateScore(noBricksLayer)
        ..ballState = BallState.ideal;
    }
    super.update(dt);
  }

  double get brickSize {
    const totalPadding = (GameConstants.noBricksInRow + 1) * GameConstants.brickPadding;
    final screenMinSize = size.x < size.y ? size.x : size.y;
    return (screenMinSize - totalPadding) / GameConstants.noBricksInRow;
  }

  List<BrickComponent> getBrickLayer() {
    return List<BrickComponent>.generate(
      GameConstants.noBricksInRow,
      (index) => BrickComponent(
        counter: randomIntegerInRange(-3, GameConstants.maxValueOfBrick), 
        size: brickSize,
      ),
    );
  }
  
  Future<void> loadInitialBrickLayer() async {
    for (var row = 0; row < noBricksLayer; row++) {
      final bricksLayer = getBrickLayer();
      for (var i = 0; i < GameConstants.noBricksInRow; i++) {
        final xPosition = i == 0
            ? padding
            : bricksLayer[i - 1].position.x +
                bricksLayer[i - 1].size.x +
                padding;
        final yPosition = (row + 1) * (brickSize + padding);
        await add(bricksLayer[i]..position = Vector2(xPosition, yPosition));
      }
    }
  }

  int randomIntegerInRange(int min, int max) { // Add this method to generate a random integer in a range
    return min + random.nextInt(max - min + 1);
  }
}