import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signalr_core/signalr_core.dart';

String serverUrl = 'https://localhost:7077/api/v1';
String googleMapApiKey = 'AIzaSyAi4_xNCIhmQTmUL4LEJGM4B7TW44T2Ylc';
String googleDirectionApiKey = 'AIzaSyAi4_xNCIhmQTmUL4LEJGM4B7TW44T2Ylc';

late HubConnection connection;

late LatLng walkerPosition;