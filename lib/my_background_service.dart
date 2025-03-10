import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class MyBackgroundService {
  static const jobKey = 'start_job';
  static const textKey = 'textKey';

  static MyBackgroundService? _service;

  MyBackgroundService._();

  static MyBackgroundService getInstance() {
    _service ??= MyBackgroundService._();

    return _service!;
  }

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: false,
        notificationChannelId: 'my_background',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [AndroidForegroundType.dataSync],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  Future<bool> onIosBackground(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on(jobKey).listen((event) async {
        await service.setAsBackgroundService();
        final argTest = event?[MyBackgroundService.textKey];

        print('$argTest');
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }
}
