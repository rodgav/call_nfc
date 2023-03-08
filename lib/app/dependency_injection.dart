import 'package:call_nfc/presentation/home/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.instance;

Future<void> initModule() async {
  if (!GetIt.I.isRegistered<HomeViewModel>()) {
    instance.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  }
}
