import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/constants/firebase_data.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.path,
      required this.author})
      : super(key: key);
  final String imageUrl;
  final String path;
  final String name;
  final String author;

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

enum AudioState {
  playing,
  loading,
  paused,
  stoped,
  error,
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  AudioPlayer player = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  AudioState state = AudioState.loading;
  Duration duration = Duration();
  Duration position = Duration();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      String url = await FirebaseData.getUrl(widget.path);
      int x = await player.play(url);
      if (x == 1) {
        state = AudioState.playing;
      } else {
        state = AudioState.error;
      }
      setState(() {});

      player.onDurationChanged.listen((d) {
        duration = d;
        setState(() {});
      });

      player.onAudioPositionChanged.listen((p) {
        position = p;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    Future.delayed(Duration.zero, () async {
      await player.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: TransparentAppBar("Play Audio", Colors.white),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.primary,
            AppColors.secondary,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Center(
            child: Container(
              width: size.width * 0.9,
              height: 350,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: size.width * 0.7,
                        height: 50,
                        child: Marquee(
                          text: widget.name,
                          scrollAxis: Axis.horizontal,
                          blankSpace: 20.0,
                          velocity: 50.0,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      )),
                  Container(
                      child: Text(widget.author,
                          style: TextStyle(color: AppColors.blue))),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            alignment: Alignment.center,
                            height: 190 * 0.8,
                            width: 130 * 0.8,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: widget.imageUrl == ""
                                ? Image.asset(AppImages.img_default,
                                    fit: BoxFit.cover)
                                : Image.network(widget.imageUrl,
                                    fit: BoxFit.cover)),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(_printDuration(position)),
                                  Container(
                                      child: state == AudioState.paused
                                          ? TextButton(
                                              onPressed: _resume,
                                              child: const Icon(
                                                  Icons.play_arrow_outlined,
                                                  size: 30),
                                            )
                                          : state == AudioState.playing
                                              ? TextButton(
                                                  onPressed: _pause,
                                                  child: const Icon(
                                                      Icons.pause_sharp,
                                                      size: 30),
                                                )
                                              : const CircularProgressIndicator()),
                                  Text(_printDuration(duration)),
                                ],
                              ),
                              Container(
                                child: Slider(
                                  value: position.inMicroseconds * 1.0,
                                  max: duration.inMicroseconds * 1.0,
                                  onChanged: (double value) async {
                                    await player.seek(
                                        Duration(microseconds: value.round()));
                                    setState(() {});
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  String twoDigits(int n) => n >= 10 ? "$n" : "0$n";
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  _resume() async {
    await player.resume();
    state = AudioState.playing;
    setState(() {});
  }

  _pause() async {
    await player.pause();
    state = AudioState.paused;
    setState(() {});
  }
}
