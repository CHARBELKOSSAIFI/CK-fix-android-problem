import 'package:just_audio_background/just_audio_background.dart';
import 'package:yasour_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'api/firebase_api.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> saveFCMToken(String token) async {
  final url =
      Uri.parse('https://yasour.osistream.com/api/guest-notification-tokens/');

  // tag:
  // var widget;
  // MediaItem(
  //   id: '${widget.songModel.id}',
  //   album: "${widget.songModel.album}",
  //   title: widget.songModel.displayNameWOExt,
  //   artUri: Uri.parse(
  //       'https://yasour.osistream.com/api/guest-notification-tokens/'),
  // );

  final response = await http.post(
    url,
    body: {'token': token},
  );

  if (response.statusCode == 201) {
    print('FCM token saved successfully.');
  } else {
    print('Failed to save FCM token: ${response.statusCode}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Request notification permissions
  await Permission.notification.request();
  await FirebaseApi().initNotifications();
  // Initialize Firebase messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Obtain the FCM token
  String? token = await _firebaseMessaging.getToken();

  // Send the token to your Django backend
  if (token != null) {
    await saveFCMToken(token);
  }
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.chanel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color customColor = Color(0xFF6B1E5E);
  final player = AudioPlayer();
  Future<void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(
        color: customColor,
        player: player,
        playAudioFromUrl: playAudioFromUrl,
      ),
    );
  }
}
