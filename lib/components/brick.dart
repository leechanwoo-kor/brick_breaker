import 'package:brick_breaker/components/ball.dart';
import 'package:brick_breaker/breaker_game.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BrickComponent extends RectangleComponent with CollisionCallbacks, HasGameRef<BrickBreakerGame> {
  BrickComponent({
    required this.counter,
    required double size,
  }) : super(
          size: Vector2.all(size),
          paint: Paint()
            ..style = PaintingStyle.fill
            ..color = GameConstants.brickColor,
        );

  int counter;
  bool hasCollided = false;
  late final TextComponent textComponent;

  @override
  Future<void> onLoad() async {

    //1
    if (counter <= 0) {
      removeFromParent();
      return;
    }
    
    //2
    textComponent = TextComponent(
      text: '$counter',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: GameConstants.whiteColor,
          fontSize: GameConstants.brickFontSize,
        ),
      ),
    )..center = size / 2;

    await add(textComponent);
    
    //3
    await add(RectangleHitbox());
  }

  //4
  @override
  void update(double dt) {
    if (hasCollided) {
      textComponent.text = '$counter';
    }
  }

  //5
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball && !hasCollided) {
        hasCollided = true;
        if (--counter == 0) {
          removeFromParent();
          return;
        }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (hasCollided) {
      hasCollided = false;
    }
    super.onCollisionEnd(other);
  }
}