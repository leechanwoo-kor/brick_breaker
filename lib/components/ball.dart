import 'package:brick_breaker/breaker_game.dart';
import 'package:brick_breaker/components/board.dart';
import 'package:brick_breaker/components/brick.dart';
import 'package:brick_breaker/game_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent with CollisionCallbacks, HasGameRef<BrickBreakerGame> {
  Ball()
      : super(
          paint: Paint()..color = GameConstants.whiteColor,
          radius: GameConstants.ballRadius,
          children: [CircleHitbox()],
        );
  double xSign = 0;
  double ySign = 0;
  double aimAngle = 0;
  final nextPosition = Vector2.zero();
  final double _ballRadius = GameConstants.ballRadius;
  late final _triangleMidPoint = Vector2(size.x / 2, -2 * size.y);
  late final _triangleBasePoint = Vector2(size.x / 4, -_ballRadius / 2);
  late final List<Rect> _pointerBalls = List<Rect>.generate(
    16,
    (index) {
      return Rect.fromCircle(
        center:
            Offset(_triangleMidPoint.x, _triangleMidPoint.y - (index + 1) * 20),
        radius: 3,
      );
    },
  );

  Path get _aimPath {
    final path = Path()
      ..moveTo(_triangleMidPoint.x, _triangleMidPoint.y)
      ..lineTo(_triangleBasePoint.x, _triangleBasePoint.y)
      ..lineTo(3 * _triangleBasePoint.x, _triangleBasePoint.y);
    for (final balls in _pointerBalls) {
      path.addOval(balls);
    }
    return path..close();
  }

  final _aimPainter = Paint()
    ..color = Colors.white54
    ..style = PaintingStyle.fill;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(
      gameRef.board.size.x / 2,
      (gameRef.board.size.y - 2 * _ballRadius) - 2,
    );
  }

  //1
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (gameRef.gameStore.ballState == BallState.drag) {
      drawRotatedObject(
        canvas: canvas,
        center: Offset(size.x / 2, size.y / 2),
        angle: aimAngle,
        drawFunction: () => canvas.drawPath(_aimPath, _aimPainter),
      );
    }
  }

  @override
  void update(double dt) {
    //2
    if (position.y >= gameRef.board.size.y - size.y) {
      position.setFrom(
        Vector2(position.x, (gameRef.board.size.y - _ballRadius * 2) - 2),
      );
      gameRef.gameStore.ballState = BallState.completed;
    }
    if (gameRef.gameStore.ballState == BallState.release) {
      moveBall(dt);
    }
  }

  //3
  void moveBall(double dt) {
    position
      ..x += xSign * nextPosition.x
      ..y += ySign * nextPosition.y;
  }
  
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.gameStore.ballState = BallState.ideal;
    if (other is Board) {
      reflectFromBoard(intersectionPoints);
    } else if (other is BrickComponent) {
      reflectFromBrick(intersectionPoints, other);
    }
    gameRef.gameStore.ballState = BallState.release;
    super.onCollision(intersectionPoints, other);
  }

  void reflectFromBoard(Set<Vector2> ip) {
    final isTop = ip.first.y <= gameRef.board.position.y;
    final isLeft = ip.first.x <= gameRef.board.position.x &&
        ip.first.y <= gameRef.board.position.y + gameRef.board.size.y;
    final isRight =
        ip.first.x >= gameRef.board.position.x + gameRef.board.size.x &&
            ip.first.y <= gameRef.board.position.y + gameRef.board.size.y;
    if (isTop) {
      ySign *= -1;
    } else if (isLeft || isRight) {
      xSign *= -1;
    }
  }

  void reflectFromBrick(Set<Vector2> ip, PositionComponent other) {
    if (ip.length == 1) {
      sideReflection(ip.first, other);
    } else {
      final ipList = ip.toList();
      final xAvg = (ipList[0].x + ipList[1].x) / 2;
      final yAvg = (ipList[0].y + ipList[1].y) / 2;
      if (ipList[0].x == ipList[1].x || ipList[0].y == ipList[1].y) {
        sideReflection(Vector2(xAvg, yAvg), other);
      } else {
        cornerReflection(other, xAvg, yAvg);
      }
    }
  }

  void sideReflection(Vector2 ip, PositionComponent other) {
    final isTop = ip.y == other.position.y;
    final isBottom = ip.y == other.position.y + other.size.y;
    final isLeft = ip.x == other.position.x;
    final isRight = ip.x == other.position.x + other.size.x;
    if (isTop || isBottom) {
      ySign *= -1;
    } else if (isLeft || isRight) {
      xSign *= -1;
    }
  }

  void cornerReflection(
    PositionComponent other,
    double xAvg,
    double yAvg,
  ) {
    final margin = size.x / 2;
    final objX = other.position.x;
    final objY = other.position.y;
    final leftHalf = objX - margin <= xAvg && xAvg < objX + margin;
    final topHalf = objY - margin <= yAvg && yAvg < objY + margin;
    xSign = leftHalf ? -1 : 1;
    ySign = topHalf ? -1 : 1;
  }
}

class DraggableBall extends SpriteComponent {
  DraggableBall(): super(
    size: Vector2.all(50), // Set the size of the ball.
  );

  get nextPosition => null;

  set ySign(int ySign) {}

  set xSign(double xSign) {}

  set aimAngle(double aimAngle) {}
  
  // Load the ball's image. Replace 'ball.png' with the path to your image.
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ball.png');
  }

  // Implement the drag behavior.
  bool onDragUpdate(int pointerId, DragUpdateInfo info) {
    position.add(info.delta as Vector2);
    return false; // Return true if the event has been handled.
  }
}

void drawRotatedObject({
  required Canvas canvas,
  required Offset center,
  required double angle,
  required Function drawFunction,
}) {
  canvas.save();
  canvas.translate(center.dx, center.dy);
  canvas.rotate(angle);
  canvas.translate(-center.dx, -center.dy);
  drawFunction();
  canvas.restore();
}
