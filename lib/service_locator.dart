import 'package:get_it/get_it.dart';
import 'package:brick_breaker/game_store.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<GameStore>(GameStore());
}