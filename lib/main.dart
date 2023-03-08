import 'package:call_nfc/app/app.dart';
import 'package:call_nfc/app/dependency_injection.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initModule();
  runApp(const Application());
}
