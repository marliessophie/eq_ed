import 'package:chewie/chewie.dart';
import 'package:eq_ed/components/design_components/reusable_card.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/game_flow/answer_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  const VideoItem(
      {Key? key,
      required this.videoPlayerController,
      required this.looping,
      required this.autoplay})
      : super(key: key);
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key, required this.questionId}) : super(key: key);
  final String questionId;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  Future<VideoPlayerController> _getVideo(
      BuildContext context, String video) async {
    late VideoPlayerController videoController;
    await FirebaseStorageService.loadVideo(context, video).then((value) {
      videoController = VideoPlayerController.network(value.toString());
    });
    return videoController;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        automaticallyImplyLeading: false,
        title: Text('EQ\'ed | Question'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _getVideo(context, widget.questionId + '.mp4'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      child: VideoItem(
                        videoPlayerController:
                            (snapshot.data as VideoPlayerController),
                        looping: false,
                        autoplay: false,
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Expanded(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: 300.0,
            child: ReusableCard(
              colour: kPrimaryColor,
              cardChild: Center(
                  child: Text(
                'Choose your Answer.',
                style: kLabelTextStyle.copyWith(
                  color: Colors.white,
                ),
              )),
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnswerScreen(
                      currentQuestionId: widget.questionId,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class FirebaseStorageService extends ChangeNotifier {
  FirebaseStorageService();
  static Future<dynamic> loadVideo(BuildContext context, String video) async {
    return await FirebaseStorage.instance.ref(video).getDownloadURL();
  }
}
