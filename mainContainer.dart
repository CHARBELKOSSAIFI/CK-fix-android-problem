import 'package:audioplayers/audioplayers.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yasour_app/contactpage.dart';
import 'package:yasour_app/homepage.dart';

class MainContainer extends StatefulWidget {
  final Widget child;
  final AudioPlayer player;
  final Future<void> Function(String) playAudioFromUrl;
  final Color color;

  MainContainer(
      {required this.child,
      required this.player,
      required this.color,
      required this.playAudioFromUrl});

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 161, 127, 167),
        toolbarHeight: 0,
      ),
      body: widget.child,
      bottomNavigationBar: CurvedNavigationBar(
        color: widget.color,
        backgroundColor: const Color.fromARGB(255, 161, 127, 167),
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          switch (index) {
            case 0:
              // Handle the action for the first icon (index 0)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        color: widget.color,
                        player: widget.player,
                        playAudioFromUrl: widget.playAudioFromUrl)),
              );
              break;
            case 1:
              // Handle the action for the second icon (index 1)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        color: widget.color,
                        player: widget.player,
                        playAudioFromUrl: widget.playAudioFromUrl)),
              );
              break;
            case 2:
              // Handle the action for the third icon (index 2)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactPage(
                        color: widget.color,
                        player: widget.player,
                        playAudioFromUrl: widget.playAudioFromUrl)),
              );
              break;
            default:
            // Handle any other cases or provide a default action
          }
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.audio_file,
            color: Colors.white,
          ),
          Icon(
            Icons.call,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
