import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayer extends StatefulWidget {
  TrailerPlayer({this.videoId});

  final String videoId;
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<TrailerPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    print('here');
    print(widget.videoId);
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
        controlsVisibleAtStart: false,
        hideControls: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 50.0),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
//            progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
          playedColor: Colors.amber,
          handleColor: Colors.amberAccent,
        ),
        onReady: () {
          print('Player is ready.');
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/*
YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: false,
//            progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                print('Player is ready.');
              },
            );
          }),
 */
