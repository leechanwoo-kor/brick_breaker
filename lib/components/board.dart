import 'package:brick_breaker/breaker_game.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Board extends RectangleComponent with DragCallbacks, HasGameRef<BrickBreakerGame> {
  double _lineSlope = 0;
  final _dragStartPosition = Vector2.zero();
  final _dragRelativePosition = Vector2.zero();
  final _dividerPainter = Paint()
    ..color = GameConstants.whiteColor.withOpacity(0.3)
    ..style = PaintingStyle.fill;
  late final _dividerPath = Path()
    ..addRect(Rect.fromLTWH(0, -2, size.x, 2))
    ..addRect(Rect.fromLTWH(0, size.y, size.x, 2));
  late final centerPosition = position + (size / 2);

  @override
  Future<void> onLoad() async {
    size = Vector2(
      gameRef.size.x,
      gameRef.size.y,
    );
    
    //1
    await add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(_dividerPath, _dividerPainter);
    super.render(canvas);
  }

  //2
  @override
  bool onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (gameRef.gameStore.ballState == BallState.ideal) {
      _dragStartPosition.setFrom(event.localPosition);
    }
    return true;
  }

  //3
  @override
  bool onDragUpdate(DragUpdateEvent event) {
    if (gameRef.gameStore.ballState == BallState.ideal ||
        gameRef.gameStore.ballState == BallState.drag) {
      _dragRelativePosition
          .setFrom(event.localPosition - _dragStartPosition);
      final absolutePosition = (event.localPosition - _dragStartPosition)
        ..absolute();
      final isValid = absolutePosition.x > 15 || absolutePosition.y > 15;
      if (!_dragRelativePosition.y.isNegative && isValid) {
        gameRef.gameStore.ballState = BallState.drag;
        _lineSlope = _dragRelativePosition.y / _dragRelativePosition.x;
        final sign = _dragRelativePosition.x.sign == 0
            ? 1
            : _dragRelativePosition.x.sign;
        gameRef.ball.aimAngle =
            math.atan(_lineSlope) - sign * 90 * degrees2Radians;
      } else {
        gameRef.gameStore.ballState = BallState.ideal;
      }
    }
    return true;
  }

  //5
  @override
  bool onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    if (gameRef.gameStore.ballState == BallState.drag &&
        !_dragRelativePosition.y.isNegative) {
      gameRef.ball.xSign = _dragRelativePosition.x.sign * -1;
      gameRef.ball.ySign = -1;
      var newPointX = 0.0;
      var newPointY = 0.0;
      if (_lineSlope > -1 && _lineSlope < 1) {
        newPointX =
            centerPosition.x - _lineSlope.sign * GameConstants.ballSpeed;
        newPointY =
            centerPosition.y + (_lineSlope * (newPointX - centerPosition.x));
      } else {
        newPointY = centerPosition.y - GameConstants.ballSpeed;
        newPointX =
            (newPointY - centerPosition.y) / _lineSlope + centerPosition.x;
      }
      gameRef.ball.nextPosition.setFrom(
        Vector2(
          _lineSlope.sign * (centerPosition.x - newPointX),
          centerPosition.y - newPointY,
        ),
      );
      if (gameRef.gameStore.ballState != BallState.release) {
        gameRef.ball.aimAngle = 0;
        gameRef.gameStore.ballState = BallState.release;
      }
    }
    return false;
  }

  @override
  bool onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    onDragCancel(event as DragCancelEvent);
    return false;
  }
}