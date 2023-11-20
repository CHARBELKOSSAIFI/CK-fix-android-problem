import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:yasour_app/mainContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.player,
    required this.playAudioFromUrl,
    required this.color,
  }) : super(key: key);

  final Color color;
  final AudioPlayer player;
  final Future<void> Function(String url) playAudioFromUrl;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPlaying = false;
  bool isStartingPlayback = false; // New loading state for starting playback

  @override
  Widget build(BuildContext context) {
    return MainContainer(
        color: widget.color,
        playAudioFromUrl: widget.playAudioFromUrl,
        player: widget.player,
        child: Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 300,
                height: 300,
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 5),
                  ),
                  onPressed: () async {
                    // player.stop();
                    // if (isStartingPlayback) {

                    //   return; // Don't allow action while loading
                    //}
                    if (widget.player.state.toString() ==
                        'PlayerState.playing') {
                      await widget.player?.stop();
                    } else {
                      await widget.playAudioFromUrl!(
                          'https://audio.osina.cloud:1155/stream');
                    }
                    // debugPrint(widget.player?.state.toString());
                    setState(() {
                      isStartingPlayback = true;
                    });

                    // if (isPlaying) {
                    //   await player.stop();
                    // } else {
                    //   await playAudioFromUrl(
                    //       'https://audio.osina.cloud:1155/stream');
                    // }

                    setState(() {
                      isStartingPlayback = false;
                      isPlaying = !isPlaying;
                    });
                  },
                  child: isStartingPlayback
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(widget.color),
                        )
                      : Icon(
                          widget.player?.state.toString() ==
                                  'PlayerState.playing'
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: const Color.fromARGB(255, 161, 127, 167),
                          size: 35,
                        ),
                ),
              ),
            ],
          ),
        )));
  }
}
