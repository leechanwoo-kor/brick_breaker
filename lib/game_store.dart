import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'game_store.g.dart';

enum GameState { launch, play, pause, gameOver }

enum BallState { ideal, drag, release, move, completed }

class GameStore = _GameStore with _$GameStore;

abstract class _GameStore with Store {
  @observable
  int score = 0;

  @observable
  int highScore = 0;

  @observable
  bool paused = false;

  @observable
  int bricksLeft = 0;

  @observable
  int noBricksLayer = 0;

  @observable
  GameState gameState = GameState.launch;
  
  @observable
  BallState ballState = BallState.ideal;

  @observable
  bool doGameRestart = true;

  @action
  void resetScore() {
    score = 0;
  }

  @action
  void updateScore(int noBricksInRow) {
    score = noBricksInRow;
  }

  @action
  void incrementScore() {
    score++;
  }

  @action
  void decrementBricks() {
    bricksLeft--;
  }
  
  @action
  void setGameState(GameState newState) {
    gameState = newState;
  }
  
  @action
  void setBallState(BallState newState) {
    ballState = newState;
  }
}

class GameConstants {
  static Color panelColor = Color.fromARGB(255, 50, 50, 66);
 
  static const ballRadius = 5.0;
  static const ballSpeed = 5.0;

  static const brickPadding = 1.0;
      
  static const noBricksInRow = 5;
  static const maxValueOfBrick = 10;


  static const brickFontSize = 1.0;
  
  static const Color whiteColor = Colors.white;
  static const Color brickColor = Colors.lightBlue;
  static const Color backGroundColor = Color.fromARGB(255, 90, 76, 76);
}
