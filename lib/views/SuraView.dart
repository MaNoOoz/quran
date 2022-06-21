import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import '../controller/HomeController.dart';
import '../models/Data1.dart';
import '../widgets/SeekBar.dart';

class SuraView extends StatelessWidget {
  late var playerFuture;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Surah sura = Get.arguments;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black,
        /* set Status bar color in Android devices. */
        statusBarIconBrightness: Brightness.dark,
        /* set Status bar icons color in Android devices.*/
        statusBarBrightness: Brightness.dark));
    /* set Status bar icon color in iOS. */
    //
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("${sura.englishName}"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.buildSliderDialog(
                        context: context,
                        title: "تعديل الخط",
                        divisions: 10,
                        min: 18.0,
                        max: 100.0,
                        value: controller.fontSize.value,
                        stream: controller.fontSize.stream,
                        onChanged: (newValue) {
                          controller.fontSize.value = newValue;
                        },
                        onConfirmTaped: () {
                          Get.back();
                        });
                  },
                  icon: Icon(Icons.font_download)),
            ],
          ),
          bottomSheet: buildSolidBottomSheet(sura),
          body: SizedBox(
            height: height - 300,
            child: buildListView2(sura),
          ),
        );
      },
    );
  }

  Widget buildListView2(Surah sura) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ScrollablePositionedList.builder(
          itemScrollController: controller.itemController,
          itemPositionsListener: controller.itemListener,
          itemCount: sura.ayahs.length,
          itemBuilder: (BuildContext context, int index) {
            controller.ayaList = sura.ayahs;
            final verse = sura.ayahs[index];

            /// remove bismillah
            final string2 = verse.text.trim();
            var editeted = "";
            if (sura.number > 1) {
              editeted = string2.replaceFirstMapped('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', (m) => '');
            } else {
              editeted = verse.text;
            }

            return buildContainer(editeted, controller, index);
          },
        ),
      );
    });
  }

  Widget buildContainer(String editeted, HomeController controller, int index) {
    return GestureDetector(
      onTap: () async {
        var ayaIndex = controller.currentPlayingAyaIndex;
        Logger().d(" aya  ${ayaIndex.value}:");
        controller.currentPlayingAyaIndex.value = index;
        controller.player.seek(Duration(seconds: 0), index: index);
        controller.player.play();

        Logger().d(" List  ${index}:");
        // await controller.playAya2(index);
      },
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 1,
              ),
              Container(
                // color: Colors.amber.shade600,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      child: Container(
                        // color: Colors.red,
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Obx(() {
                            return Text(
                              textAlign: TextAlign.right,
                              '$editeted',
                              style: TextStyle(
                                fontFamily: "Noor",
                                color: controller.currentPlayingAyaIndex.value == index ? Colors.green.withOpacity(0.8) : Colors.black,
                                fontSize: controller.fontSize.value,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              )
            ],
          ),
          const Divider(
            height: 10,
            thickness: 1,
            // color: Colors.black87,
          )
        ],
      ),
    );
  }

  Widget buildSolidBottomSheet(Surah sura) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Container(
          decoration: const BoxDecoration(
            // color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            gradient: LinearGradient(
              colors: GradientColors.cloud,
              begin: Alignment.topRight,
              end: Alignment.topRight,
            ),
            shape: BoxShape.rectangle,
          ),
          child: SolidBottomSheet(
              canUserSwipe: true,
              draggableBody: true,
              smoothness: Smoothness.high,
              autoSwiped: true,
              minHeight: 180,
              maxHeight: 180,
              headerBar: Center(
                child: Container(
                    height: 10,
                    child: Text(
                      // " القارئ : ${controller.selectedQareeName} ",
                      "",
                      style: TextStyle(fontFamily: "Noor", fontSize: 22),
                    )),
              ),
              body: FutureBuilder<List<AudioSource>>(
                  future: controller.initPlayer(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// title ========================================
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 10,
                                // padding: EdgeInsets.all(12),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  // color: Colors.redAccent,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 1, offset: Offset(0, 1), color: Colors.white),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "${sura.name}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            // color: Colors.white,
                                            fontSize: 30,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: "Noor"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " عدد الآيات : ${sura.ayahs.length}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            // color: Colors.white,
                                            fontSize: 18,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: "Noor"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          /// Progress ========================================
                          StreamBuilder<PositionData>(
                            stream: controller.positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return SeekBar(
                                duration: positionData?.duration ?? const Duration(milliseconds: 1),
                                position: positionData?.position ?? Duration.zero,
                                bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                                onChanged: controller.player.seek,
                              );
                            },
                          ),

                          /// Control ========================================
                          Expanded(
                            child: Builder(builder: (context) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  StreamBuilder(
                                      stream: controller.player.currentIndexStream,
                                      builder: (context, AsyncSnapshot<int?> snapshot) {
                                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                          controller.scrollToItem(controller.player.currentIndex!.toInt());
                                        });
                                        if (snapshot.hasData) {
                                          return GestureDetector(
                                              onTap: () async {
                                                await Future.delayed(Duration.zero, () async {
                                                  controller.buildSliderDialog(
                                                    context: context,
                                                    // label: "${snapshot.data?.toStringAsFixed(1)}",
                                                    title: "الإنتقال إلى آية رقم : ",
                                                    divisions: sura.ayahs.length + 1,
                                                    min: 0.0,
                                                    max: sura.ayahs.length - 1.toDouble(),
                                                    value: controller.player.currentIndex!.toDouble() + 1,
                                                    stream: controller.player.currentIndexStream.map((event) => event!.toDouble()),
                                                    onConfirmTaped: () {
                                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                                        controller.scrollToItem(controller.player.currentIndex!.toInt());
                                                      });
                                                      Get.back();
                                                    },
                                                    onChanged: (newValue) async {
                                                      try {
                                                        controller.player.pause();
                                                        controller.player.seek(Duration(seconds: 0), index: newValue.toInt());
                                                      } catch (e) {
                                                        print(e);
                                                      }
                                                    },
                                                  );
                                                });
                                              },
                                              child: Text((" الآية :${(snapshot.data)! + 1}")));
                                        } else {
                                          return Text("الآية");
                                        }
                                      }),

                                  /// ========================= volume
                                  IconButton(
                                    icon: const Icon(
                                      Icons.volume_up,
                                      // color: Colors.white,
                                      size: 24,
                                    ),
                                    onPressed: () async {
                                      controller.buildSliderDialog(
                                        context: context,
                                        title: "تعديل الصوت",
                                        divisions: 10,
                                        min: 0.0,
                                        max: 1.0,
                                        value: controller.player.volume,
                                        stream: controller.player.volumeStream,
                                        onChanged: controller.player.setVolume,
                                        onConfirmTaped: () {
                                          Get.back();
                                        },
                                      );

                                      // await controller.decraseVol();
                                      //  Logger().d(" decraseVol vol : ${controller
                                      //      .sliderValue}");
                                    },
                                  ),

                                  /// ========================= seekToPrevious
                                  IconButton(
                                    // backgroundColor: Colors.white,
                                    onPressed: () async {
                                      controller.player.seekToPrevious();
                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        controller.scrollToItem(controller.player.currentIndex!.toInt());
                                      });

                                      Logger().d("${controller.player.currentIndex}");
                                    },
                                    icon: const Icon(Icons.skip_previous, color: Colors.black87),
                                  ),

                                  /// ========================= play
                                  StreamBuilder<PlayerState>(
                                    stream: controller.player.playerStateStream,
                                    builder: (context, snapshot) {
                                      final playerState = snapshot.data;
                                      final processingState = playerState?.processingState;
                                      final playing = playerState?.playing;
                                      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
                                        return Container(
                                          // color: Colors.red,
                                          margin: const EdgeInsets.all(8.0),
                                          width: 30.0,
                                          height: 30.0,
                                          child: Center(child: const CircularProgressIndicator()),
                                        );
                                      } else if (playing != true) {
                                        return IconButton(
                                          icon: const Icon(Icons.play_arrow),
                                          // iconSize: 64.0,
                                          onPressed: controller.player.play,
                                        );
                                      } else if (processingState != ProcessingState.completed) {
                                        return IconButton(
                                          icon: const Icon(Icons.pause),
                                          // iconSize: 64.0,
                                          onPressed: controller.player.pause,
                                        );
                                      } else {
                                        return IconButton(
                                          icon: const Icon(Icons.replay),
                                          // iconSize: 64.0,
                                          onPressed: () => controller.player.seek(Duration.zero),
                                        );
                                      }
                                    },
                                  ),

                                  /// ========================= stop
                                  IconButton(
                                    onPressed: () async {
                                      print("${controller.player.processingState}");

                                      await controller.player.stop();
                                      await controller.player.seek(Duration.zero, index: 0);
                                    },
                                    icon: const Icon(Icons.stop, color: Colors.black87),
                                  ),

                                  /// ========================= seekToNext
                                  IconButton(
                                    onPressed: () async {
                                      await controller.player.seekToNext();
                                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        controller.scrollToItem(controller.player.currentIndex!.toInt());
                                      });
                                    },
                                    icon: const Icon(Icons.skip_next, color: Colors.black87),
                                  ),

                                  /// ========================= speed
                                  StreamBuilder<double>(
                                    stream: controller.player.speedStream,
                                    builder: (context, snapshot) => IconButton(
                                      icon: Text(
                                        "${snapshot.data?.toStringAsFixed(1)}x",
                                        // style: TextStyle(
                                        //     fontWeight: FontWeight.bold, fontSize: 20)
                                      ),
                                      onPressed: () {
                                        controller.buildSliderDialog(
                                          context: context,
                                          title: "تعديل السرعة",
                                          divisions: 10,
                                          min: 0.5,
                                          max: 1.5,
                                          value: controller.player.speed,
                                          stream: controller.player.speedStream,
                                          onChanged: controller.player.setSpeed,
                                          onConfirmTaped: () {
                                            Get.back();
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Icon(Icons.error_outline);
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ));
                    }
                  })),
        );
      },
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
