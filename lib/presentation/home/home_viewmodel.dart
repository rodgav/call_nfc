import 'package:call_nfc/presentation/base/base_viewmodel.dart';
import 'package:flutter/services.dart';

import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

const _channelName = 'com.rsgmsolutions.call_nfc/card';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  BehaviorSubject<String> _stringStreCtrl = BehaviorSubject<String>();

  final _channel = const MethodChannel(_channelName);

  @override
  Sink<String> get inputReadNfc => _stringStreCtrl.sink;

  @override
  Stream<String> get outputReadNfc =>
      _stringStreCtrl.stream.map((event) => event);

  @override
  start() {
    if (_stringStreCtrl.isClosed) {
      _stringStreCtrl = BehaviorSubject<String>();
    }
    _channel.setMethodCallHandler(_handleCardRead);
    return super.start();
  }

  @override
  finish() {
    _stringStreCtrl.close();
    return super.finish();
  }

  callTo(String numberPhone) async {
    final uri = Uri.parse(numberPhone);
    if (await canLaunchUrl(uri)) {
      await canLaunchUrl(uri);
    } else {
      print('Error callTo');
    }
  }

  Future<void> _handleCardRead(MethodCall call) async {
    if (call.method == "onCardRead") {
      final String arguments = call.arguments as String;
      inputReadNfc.add(arguments);
      print('arguments $arguments');
    }
  }
}

abstract class HomeViewModelInput {
  Sink<String> get inputReadNfc;
}

abstract class HomeViewModelOutput {
  Stream<String> get outputReadNfc;
}
