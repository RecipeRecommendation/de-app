import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';

//hello
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: YoutubeScreen(
      url: 'https://www.youtube.com/watch?v=GQyWIur03aw&t=6s',
    ),
  ));
}

class YoutubeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const YoutubeScreen({this.url});
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
        isLive: false,
        loop: true,
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.grey.shade800,
                              size: 40.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 50.0,
                          ),
                          child: Center(
                            child: Text(
                              'Recipe Video!',
                              style: TextStyle(
                                  fontSize: 35.0,
                                  fontFamily: 'WorkSans',
                                  color: Colors.blueGrey.shade800),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: player,
                  )
                ],
              ),
            )
        );
      },
    );
  }
}
