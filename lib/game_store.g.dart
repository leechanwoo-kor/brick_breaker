// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameStore on _GameStore, Store {
  late final _$scoreAtom = Atom(name: '_GameStore.score', context: context);

  @override
  int get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  late final _$bricksLeftAtom =
      Atom(name: '_GameStore.bricksLeft', context: context);

  @override
  int get bricksLeft {
    _$bricksLeftAtom.reportRead();
    return super.bricksLeft;
  }

  @override
  set bricksLeft(int value) {
    _$bricksLeftAtom.reportWrite(value, super.bricksLeft, () {
      super.bricksLeft = value;
    });
  }

  late final _$gameStateAtom =
      Atom(name: '_GameStore.gameState', context: context);

  @override
  GameState get gameState {
    _$gameStateAtom.reportRead();
    return super.gameState;
  }

  @override
  set gameState(GameState value) {
    _$gameStateAtom.reportWrite(value, super.gameState, () {
      super.gameState = value;
    });
  }

  late final _$ballStateAtom =
      Atom(name: '_GameStore.ballState', context: context);

  @override
  BallState get ballState {
    _$ballStateAtom.reportRead();
    return super.ballState;
  }

  @override
  set ballState(BallState value) {
    _$ballStateAtom.reportWrite(value, super.ballState, () {
      super.ballState = value;
    });
  }

  late final _$doGameRestartAtom =
      Atom(name: '_GameStore.doGameRestart', context: context);

  @override
  bool get doGameRestart {
    _$doGameRestartAtom.reportRead();
    return super.doGameRestart;
  }

  @override
  set doGameRestart(bool value) {
    _$doGameRestartAtom.reportWrite(value, super.doGameRestart, () {
      super.doGameRestart = value;
    });
  }

  late final _$_GameStoreActionController =
      ActionController(name: '_GameStore', context: context);

  @override
  void resetScore() {
    final _$actionInfo =
        _$_GameStoreActionController.startAction(name: '_GameStore.resetScore');
    try {
      return super.resetScore();
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementScore() {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.incrementScore');
    try {
      return super.incrementScore();
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementBricks() {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.decrementBricks');
    try {
      return super.decrementBricks();
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGameState(GameState newState) {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.setGameState');
    try {
      return super.setGameState(newState);
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBallState(BallState newState) {
    final _$actionInfo = _$_GameStoreActionController.startAction(
        name: '_GameStore.setBallState');
    try {
      return super.setBallState(newState);
    } finally {
      _$_GameStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
score: ${score},
bricksLeft: ${bricksLeft},
gameState: ${gameState},
ballState: ${ballState},
doGameRestart: ${doGameRestart}
    ''';
  }
}
