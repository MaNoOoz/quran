import 'dart:math';

import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2.0,
            trackShape: const RoundedRectSliderTrackShape(),
            activeTrackColor: Colors.green.shade800,
            inactiveTrackColor: Colors.green.shade100,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 10.0,
              pressedElevation: 8.0,
            ),
            thumbColor: Colors.green,
            overlayColor: Colors.green.withOpacity(0.2),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
            tickMarkShape: const RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.green,
            inactiveTickMarkColor: Colors.white,
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.black,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _positionText,
                  style: const TextStyle(),
                ),
                const Text(
                  "",
                  style: TextStyle(),
                ),
                Expanded(
                  child: Slider(
                    min: 0.0,
                    max: widget.duration.inMilliseconds.toDouble(),
                    value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                        widget.duration.inMilliseconds.toDouble()),
                    onChanged: (value) {
                      setState(() {
                        _dragValue = value;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(Duration(milliseconds: value.round()));
                      }
                      _dragValue = null;
                    },
                  ),
                ),
                Text(
                  _durationText,
                  style: const TextStyle(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String get _durationText => "${widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}"
      ":${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  String get _positionText => "${widget.position.inMinutes.remainder(60).toString().padLeft(2, '0')}"
      ":${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}
