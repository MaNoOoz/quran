// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:logger/logger.dart';
// import 'package:quran_app/models/Qaree.dart';
//
// import '../controller/PlayerController.dart';
// import '../notifiers/play_button_notifier.dart';
// import '../notifiers/repeat_button_notifier.dart';
//
// class QuranPlayerView extends StatefulWidget {
//   final Surah model;
//
//   const QuranPlayerView(this.model, {Key? key}) : super(key: key);
//
//   @override
//   State<QuranPlayerView> createState() => _QuranPlayerViewState();
// }
//
// class _QuranPlayerViewState extends State<QuranPlayerView> {

//   ///
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Column(children: [
//       Container(
//         height: 60,
//       ),
//       Container(
//         color: Colors.white.withOpacity(0.2),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: const [
//               // CurrentSongTitle(),
//               // Playlist(),
//               // AddRemoveSongButtons(),
//               // AudioProgressBar(),
//               AudioControlButtons(),
//             ],
//           ),
//         ),
//       ),
//     ]);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
// }
//
// class AudioControlButtons extends GetWidget<PlayerController> {
//   const AudioControlButtons({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           RepeatButton(),
//           PreviousSongButton(),
//           PlayButton(),
//           NextSongButton(),
//           ShuffleButton(),
//         ],
//       ),
//     );
//   }
// }
//
// class RepeatButton extends GetWidget<PlayerController> {
//   const RepeatButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<RepeatState>(
//       valueListenable: controller.repeatButtonNotifier,
//       builder: (context, value, child) {
//         Icon icon;
//         switch (value) {
//           case RepeatState.off:
//             icon = Icon(Icons.repeat, color: Colors.grey);
//             break;
//           case RepeatState.repeatSong:
//             icon = Icon(Icons.repeat_one);
//             break;
//           case RepeatState.repeatPlaylist:
//             icon = Icon(Icons.repeat);
//             break;
//         }
//         return IconButton(
//           icon: icon,
//           onPressed: controller.onRepeatButtonPressed,
//         );
//       },
//     );
//   }
// }
//
// class PreviousSongButton extends GetWidget<PlayerController> {
//   const PreviousSongButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: controller.isFirstSongNotifier,
//       builder: (_, isFirst, __) {
//         return IconButton(
//           icon: Icon(Icons.skip_previous),
//           onPressed: (isFirst) ? null : controller.onPreviousSongButtonPressed,
//         );
//       },
//     );
//   }
// }
//
// class PlayButton extends GetWidget<PlayerController> {
//   const PlayButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ButtonState>(
//       valueListenable: controller.playButtonNotifier,
//       builder: (_, value, __) {
//         switch (value) {
//           case ButtonState.loading:
//             return Container(
//               margin: EdgeInsets.all(8.0),
//               width: 32.0,
//               height: 32.0,
//               child: CircularProgressIndicator(),
//             );
//           case ButtonState.paused:
//             return IconButton(
//               icon: Icon(Icons.play_arrow),
//               iconSize: 32.0,
//               onPressed: controller.play,
//             );
//           case ButtonState.playing:
//             return IconButton(
//               icon: Icon(Icons.pause),
//               iconSize: 32.0,
//               onPressed: controller.pause,
//             );
//         }
//       },
//     );
//   }
// }
//
// class NextSongButton extends GetWidget<PlayerController> {
//   const NextSongButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: controller.isLastSongNotifier,
//       builder: (_, isLast, __) {
//         return IconButton(
//           icon: Icon(Icons.skip_next),
//           onPressed: (isLast) ? null : controller.onNextSongButtonPressed,
//         );
//       },
//     );
//   }
// }
//
// class ShuffleButton extends GetWidget<PlayerController> {
//   const ShuffleButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<bool>(
//       valueListenable: controller.isShuffleModeEnabledNotifier,
//       builder: (context, isEnabled, child) {
//         return IconButton(
//           icon: (isEnabled)
//               ? Icon(Icons.shuffle)
//               : Icon(Icons.shuffle, color: Colors.grey),
//           onPressed: controller.onShuffleButtonPressed,
//         );
//       },
//     );
//   }
// }
