import 'package:brick_breaker/game_app.dart';
import 'package:flutter/material.dart';
import 'package:brick_breaker/service_locator.dart';
import 'package:flame/flame.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();  // get_it setup

  // Prepare your flame utils.
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();

  runApp(const GameApp());
}