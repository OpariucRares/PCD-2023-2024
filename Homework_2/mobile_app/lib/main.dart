import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_app/Helpers/config.dart';
import 'authentication/login_screen.dart';
import 'package:signalr_core/signalr_core.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  connection =
      HubConnectionBuilder().withUrl('https://10.0.2.2:7077/hub').build();

  await connection.start();

  log("Connection started");
  print("Connection started");

  connection.on(
      'ReceivedPosition',
      (message) {
        log("Received message: $message");
        var lat = message[0].split('*')[0];
        var lng = message[0].split('*')[1];
        walkerPosition = LatLng(double.parse(lat), double.parse(lng));
        log("Received position: $walkerPosition");
      } as MethodInvocationFunc);

  log("result: $connection");
  print("result: $connection");

  await connection.invoke("UpdatePosition", args: ["47.157665*27.58954"]);

  runApp(const MyAppLogin());
}
