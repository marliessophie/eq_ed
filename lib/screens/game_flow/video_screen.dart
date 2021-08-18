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

// import 'package:chewie/chewie.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class TestVideo extends StatefulWidget {
//   const TestVideo({Key? key}) : super(key: key);
//
//   @override
//   _TestVideoState createState() => _TestVideoState();
// }
//
// class _TestVideoState extends State<TestVideo> {
//   String url = 'test';
//   late VideoPlayerController _videoPlayerController =
//       VideoPlayerController.asset(
//           'images/X3000.MOV');
//   // late Future<void> _initializeVideoPlayerFuture;
//   late ChewieController _chewieController;
//   final bool looping = true;
//   final bool autoplay = true;
//
//   @override
//   void initState() {
//     getVideo();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: _videoPlayerController.value.aspectRatio,
//       autoInitialize: true,
//       autoPlay: autoplay,
//       looping: looping,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//     super.initState();
//   }
//
//   void getVideo() async {
//     final ref = FirebaseStorage.instance.ref().child('X3000.MOV');
//     var myUrl = await ref.getDownloadURL();
//     setState(() {
//       url = myUrl;
//       _videoPlayerController = VideoPlayerController.network(url);
//       _videoPlayerController
//         ..addListener(() => setState(() {}))
//         ..setLooping(true)
//         ..initialize().then((_) => _videoPlayerController.play());
//     });
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Padding(
//     //   padding: const EdgeInsets.all(8.0),
//     //   child: Chewie(
//     //     controller: _chewieController,
//     //   ),
//     // );
//     return VideoPlayerWidget(controller: _videoPlayerController);
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: const Text('Butterfly Video'),
//     //   ),
//     //   // Use a FutureBuilder to display a loading spinner while waiting for the
//     //   // VideoPlayerController to finish initializing.
//     //   body: FutureBuilder(
//     //     future: _initializeVideoPlayerFuture,
//     //     builder: (context, snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.done) {
//     //         // If the VideoPlayerController has finished initialization, use
//     //         // the data it provides to limit the aspect ratio of the video.
//     //         return AspectRatio(
//     //           aspectRatio: _videoPlayerController.value.aspectRatio,
//     //           // Use the VideoPlayer widget to display the video.
//     //           child: VideoPlayer(_videoPlayerController),
//     //         );
//     //       } else {
//     //         // If the VideoPlayerController is still initializing, show a
//     //         // loading spinner.
//     //         return const Center(
//     //           child: CircularProgressIndicator(),
//     //         );
//     //       }
//     //     },
//     //   ),
//     //   floatingActionButton: FloatingActionButton(
//     //     onPressed: () {
//     //       // Wrap the play or pause in a call to `setState`. This ensures the
//     //       // correct icon is shown.
//     //       setState(() {
//     //         // If the video is playing, pause it.
//     //         if (_videoPlayerController.value.isPlaying) {
//     //           _videoPlayerController.pause();
//     //         } else {
//     //           // If the video is paused, play it.
//     //           _videoPlayerController.play();
//     //         }
//     //       });
//     //     },
//     //     // Display the correct icon depending on the state of the player.
//     //     child: Icon(
//     //       _videoPlayerController.value.isPlaying
//     //           ? Icons.pause
//     //           : Icons.play_arrow,
//     //     ),
//     //   ),
//     // );
//   }
// }
//
// class VideoPlayerWidget extends StatelessWidget {
//   final VideoPlayerController controller;
//   const VideoPlayerWidget({Key? key, required this.controller})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (controller.value != null) {
//       //  && controller.value.initialized
//       return Container(alignment: Alignment.topCenter, child: buildVideo());
//     } else {
//       return Container(
//         height: 200,
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }
//   }
//
//   Widget buildVideo() => Stack(
//         children: <Widget>[
//           buildVideoPlayer(),
//           Positioned.fill(child: BasicOverlayWidget(controller: controller)),
//         ],
//       );
//
//   Widget buildVideoPlayer() => AspectRatio(
//         aspectRatio: controller.value.aspectRatio,
//         child: VideoPlayer(controller),
//       );
// }
//
// class BasicOverlayWidget extends StatelessWidget {
//   final VideoPlayerController controller;
//
//   const BasicOverlayWidget({
//     Key? key,
//     required this.controller,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () =>
//             controller.value.isPlaying ? controller.pause() : controller.play(),
//         child: Stack(
//           children: <Widget>[
//             buildPlay(),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: buildIndicator(),
//             ),
//           ],
//         ),
//       );
//
//   Widget buildIndicator() => VideoProgressIndicator(
//         controller,
//         allowScrubbing: true,
//       );
//
//   Widget buildPlay() => controller.value.isPlaying
//       ? Container()
//       : Container(
//           alignment: Alignment.center,
//           color: Colors.black26,
//           child: Icon(Icons.play_arrow, color: Colors.white, size: 80),
//         );
//}