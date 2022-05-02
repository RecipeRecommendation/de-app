import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

//hello
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: YoutubeScreen(
      title: 'abc',
      url: 'https://www.youtube.com/watch?v=GQyWIur03aw&t=6s',
    ),
  ));
}

class YoutubeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const YoutubeScreen({required this.title, this.url});
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final url;

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late YoutubePlayerController? _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        isLive: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller!),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: ListView(
            children: [
              player,
            ],
          ),
        );
      },
    );
  }
}
