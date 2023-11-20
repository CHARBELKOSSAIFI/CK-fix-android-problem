import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yasour_app/mainContainer.dart';

enum SocialMedia { facebook, whatsapp }

class ContactPage extends StatefulWidget {
  const ContactPage({
    Key? key,
    required this.player,
    required this.playAudioFromUrl,
    required this.color,
  }) : super(key: key);

  final Color color;
  final AudioPlayer player;
  final Future<void> Function(String url) playAudioFromUrl;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  _launchurl() async {
    var url =
        Uri.parse("https://www.facebook.com/charbel.kessaifi?mibextid=ZbWKwL");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "could not launch the url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
        color: widget.color,
        player: widget.player,
        playAudioFromUrl: widget.playAudioFromUrl,
        child: Container(
          width: 400,
          height: 450,
          color: Colors.white.withOpacity(0.4),
          padding: const EdgeInsets.all(30), // Increased padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 32, // Larger font size
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),

              const SizedBox(height: 30), // Increased space
              Row(
                children: [
                  Icon(Icons.phone, color: widget.color),
                  const SizedBox(width: 15), // Increased space
                  Text(
                    'Phone: +961 07 350 750',
                    style: TextStyle(fontSize: 20), // Larger font size
                  ),
                ],
              ),
              SizedBox(height: 15), // Increased space
              Row(
                children: [
                  Icon(Icons.message, color: widget.color),
                  SizedBox(width: 15), // Increased space
                  Text(
                    'WhatsApp: +961 70 350 750',
                    style: TextStyle(fontSize: 20), // Larger font size
                  ),
                ],
              ),
              SizedBox(height: 30), // Increased space
              ElevatedButton(
                onPressed: _launchurl,

                // Add your Facebook button functionality here

                style: ElevatedButton.styleFrom(
                  primary: widget.color,
                  padding: EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Facebook',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  // Larger font size
                ),
              ),
            ],
          ),
        ));
  }
}
