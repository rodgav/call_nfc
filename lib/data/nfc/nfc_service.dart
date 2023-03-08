import 'dart:async';
import 'package:flutter/services.dart';

class NFCService {
  static const _channel = MethodChannel('com.example.nfc/card');

  Future<String?> readCard() async {
    try {
      final result = await _channel.invokeMethod<String>('cardRead');
      return result;
    } on PlatformException catch (e) {
      throw 'Error reading card: ${e.message}';
    }
  }
}
