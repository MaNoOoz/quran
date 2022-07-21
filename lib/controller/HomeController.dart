import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as RR;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../data/LocalStorage.dart';
import '../models/Data1.dart';
import '../models/Qaree.dart';
import '../services/SurasDataProvider.dart';
import '../views/SuraView.dart';

class HomeController extends GetxController {
  /// DATA ========================
  LocalStorage storage = LocalStorage();
  final homeService = SurasDataProvider();
  var suraList2 = <Surah>[].obs;
  var qareeList = <Qaree>[].obs;
  List<Ayah> _ayaList = <Ayah>[];
  List<Ayah> get ayaList => _ayaList;
  set ayaList(List<Ayah> value) {
    _ayaList = value;
  }

  /// Player ========================
  Duration defaultDuration = const Duration(milliseconds: 1);
  bool isLoopingCurrentItem = false;
  var currentPlayingAyaIndex = 0.obs;
  RxBool isLoading = true.obs;
  final player = AudioPlayer();

  RxDouble fontSize = 45.00.obs;
  var selectedQareeId = "ar.alafasy";
  var selectedQareeName = "مشاري العفاسي";

  /// SCROLL
  ItemScrollController itemController = ItemScrollController();

  // var itemListener = ItemPositionsListener.create();
  int buttonIndex = 0;

  Future scrollToItem(int itemIndex) async {
    itemController.scrollTo(
      index: itemIndex,
      duration: const Duration(seconds: 1),
      alignment: 0,
    );
  }

  // listenToIndex() {
  //   itemListener.itemPositions.addListener(() {
  //     final indices = itemListener.itemPositions.value.map((e) => e.index).toList();
  //     print(indices);
  //   });
  // }

  @override
  void onInit() async {
    super.onInit();
    // Logger().d("onInit Called:");

    await getAllQaree();
    await getAllDATA();
  }

  // ================================================================
  Stream<PositionData> get positionDataStream {
    return RR.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        player.positionStream, player.bufferedPositionStream, player.durationStream,
        (position, bufferedPosition, duration) {
      return PositionData(position, bufferedPosition, duration ?? Duration.zero);
    });
  }

  // ================================================================
  Future<List<AudioSource>> initPlayer() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player.playbackEventStream.listen((event) {
      currentPlayingAyaIndex.value = player.currentIndex!;
      // print('playbackEventStream: $event');
      // print('currentPlayingAyaIndex: $currentPlayingAyaIndex');
    }, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    List<AudioSource> audioFromAyah = [];

    // Logger().d(" _initPlayer  called:");

    audioFromAyah.clear();

    for (var element in ayaList) {
      var audio = AudioSource.uri(
        Uri.parse(
          element.audioSecondary[0].toString(),
        ),
      );

      audioFromAyah.add(audio);
    }
    // Logger().d(" audio list ${ayaList.length}:");

    try {
      defaultDuration = (await player.setAudioSource(
        ConcatenatingAudioSource(
          // Start loading next item just before reaching it.
          useLazyPreparation: true, // default
          // Customise the shuffle algorithm.
          shuffleOrder: DefaultShuffleOrder(), // default
          // Specify the items in the playlist.
          children: [...audioFromAyah],
        ),
        // Playback will be prepared to start from track1.mp3
        initialIndex: 0, // default
        // Playback will be prepared to start from position zero.
        initialPosition: Duration.zero, // default
      ))!;
    } catch (e) {
      print("Error loading audio source: $e");
    }
    // Logger().d("   AUDIOS : ${audioFromAyah.length}:");
    return audioFromAyah;
  }

  Future<List<AudioSource>> initPlayerForSura() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    player.playbackEventStream.listen((event) {
      currentPlayingAyaIndex.value = player.currentIndex!;
      // print('playbackEventStream: $event');
      // print('currentPlayingAyaIndex: $currentPlayingAyaIndex');
    }, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    List<AudioSource> audioFromAyah = [];

    // Logger().d(" _initPlayer  called:");

    audioFromAyah.clear();

    for (var element in suraList2.value) {
      for (Ayah ayah in element.ayahs) {
        var audio = AudioSource.uri(Uri.parse(ayah.audioSecondary[0].toString()));
        audioFromAyah.add(audio);
      }
    }
    // Logger().d(" audio list ${ayaList.length}:");

    try {
      defaultDuration = (await player.setAudioSource(
        ConcatenatingAudioSource(
          // Start loading next item just before reaching it.
          useLazyPreparation: true, // default
          // Customise the shuffle algorithm.
          shuffleOrder: DefaultShuffleOrder(), // default
          // Specify the items in the playlist.
          children: [...audioFromAyah],
        ),
        // Playback will be prepared to start from track1.mp3
        initialIndex: 0, // default
        // Playback will be prepared to start from position zero.
        initialPosition: Duration.zero, // default
      ))!;
    } catch (e) {
      print("Error loading audio source: $e");
    }
    // Logger().d("   AUDIOS : ${audioFromAyah.length}:");
    return audioFromAyah;
  }

  // ================================================================
  Future<List<Surah>> getAllDATA() async {
    // Logger().d(" getAllDATA :");
    suraList2.clear();
    try {
      isLoading(true);
      var list = await homeService.getData(selectedQareeId);
      suraList2.assignAll(list);

      // Logger().e("   list : ${suraList2.length}:");
      return suraList2;
    } finally {
      isLoading(false);
    }
  }

  // ================================================================
  void changeQaree(index, _selections) {
    for (buttonIndex = 0; buttonIndex < _selections.length; buttonIndex++) {
      if (buttonIndex == index) {
        _selections[buttonIndex] = !_selections[buttonIndex];
      } else {
        _selections[buttonIndex] = false;
      }
    }
    update();
  }

  Future<List<Qaree>> getAllQaree() async {
    qareeList.clear();
    try {
      isLoading(true);
      var qarees = await homeService.getAllQaree();
      qareeList.assignAll(qarees);
      // Logger().d("   qarees : ${qareeList.length}:");
      return qareeList;
    } finally {
      isLoading(false);
    }
  }

// ================================================================

  @override
  void onClose() async {
    super.onClose();
    await player.stop();
    await player.dispose();
  }

// ================================================================

  @override
  void dispose() async {
    super.dispose();
    if (player.playing) {
      await player.stop();
      await player.dispose();
    }
  }

// ================================================================

  void buildSliderDialog({
    String label = '',
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
    VoidCallback? onConfirmTaped,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => Container(
            height: 150.0,
            child: Column(
              children: [
                Expanded(
                    child: Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                        style: const TextStyle(fontFamily: 'Noor', fontWeight: FontWeight.bold, fontSize: 24.0))),
                Expanded(
                  flex: 2,
                  child: Slider(
                    divisions: divisions,
                    min: min,
                    max: max,
                    label: "${snapshot.data?.toStringAsFixed(1)}",
                    value: snapshot.data ?? value,
                    onChanged: onChanged,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(onPressed: onConfirmTaped, child: const Text("حفظ")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
// ================================================================

// ================================================================

}
