import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../entities/pet.dart';
import 'config.dart';

Future<int> putPet(Pet pet, String userId) async {
  log('--- Put Pet Begin ---');
  var url = '$serverUrl/users/$userId/pet/${pet.id}?api-version=1';
  var request = http.Request('PUT', Uri.parse(url));

  log('Url: $url');

  request.body = json.encode(pet.toJSON());
  request.headers.addAll(
      <String, String>{'Content-Type': 'application/json; charset=UTF-8'});

  var response = await request.send();

  log('Ok');
  log(await response.stream.bytesToString());
  log(response.statusCode.toString());
  log('--- Post Appointment End ---');

  return response.statusCode;
}

Future<void> putPosition(String userId, double lat, double lng) async {
  var url = '$serverUrl/positions?api-version=1';
  var request = http.Request('PUT', Uri.parse(url));

  request.body =
      json.encode({'userId': userId, 'latitude': lat, 'longitude': lng});
  request.headers.addAll(
      <String, String>{'Content-Type': 'application/json; charset=UTF-8'});

  var response = await request.send();

  log('Response: ${response.statusCode}');
  print('Response: ${response.statusCode}');

  var latLong = '$lat*$lng';

  print('UpdatePosition: $latLong');
  print('Connection: $connection');

  await connection.invoke('UpdatePosition', args: [latLong]);

  log('Ok. Position $lat, $lng updated for user $userId');

  if (response.statusCode != 200) {
    log('Error');
    log(await response.stream.bytesToString());
    log(response.statusCode.toString());
    return;
  }
}

Future<int> assignAppointment(String appointmentId, String walkerId) async {
  log('--- Assign Appointment Begin ---');
  var url = '$serverUrl/appointments/assign?'
      'AppointmentId=$appointmentId&'
      'UserId=$walkerId&'
      'api-version=1';
  var request = http.Request('PUT', Uri.parse(url));

  log('Url: $url');

  var response = await request.send();

  log(await response.stream.bytesToString());
  log(response.statusCode.toString());
  log('--- Assign Appointment End ---');

  return response.statusCode;
}

Future<int> inProgress(String appointmentId, String walkerId) async {
  log('--- In Progress Appointment Begin ---');
  var url = '$serverUrl/appointments/inProgres?'
      'AppointmentId=$appointmentId&'
      'UserId=$walkerId&'
      'api-version=1';
  var request = http.Request('PUT', Uri.parse(url));

  log('Url: $url');

  var response = await request.send();

  log(await response.stream.bytesToString());
  log(response.statusCode.toString());
  log('--- Assign Appointment End ---');

  return response.statusCode;
}

Future<int> complete(String appointmentId, String walkerId) async {
  log('--- Assign Appointment Begin ---');
  var url = '$serverUrl/appointments/complete?'
      'AppointmentId=$appointmentId&'
      'UserId=$walkerId&'
      'api-version=1';
  var request = http.Request('PUT', Uri.parse(url));

  log('Url: $url');

  var response = await request.send();

  log(await response.stream.bytesToString());
  log(response.statusCode.toString());
  log('--- Assign Appointment End ---');

  return response.statusCode;
}
