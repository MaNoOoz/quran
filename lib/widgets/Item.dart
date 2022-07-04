import 'package:flutter/material.dart';

import '../models/Data1.dart';

class MyItem extends StatelessWidget {
  final Surah sura;
  final void Function() onTap;

  MyItem({required this.sura, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListTile(
        onTap: onTap,
        title: Text(
          "${sura.name}",
          maxLines: 2,
          style: const TextStyle(
              // color: Colors.black,

              fontSize: 18,
              fontFamily: "Arial Rounded MT Bold"),
        ),
        leading: CircleAvatar(
          // backgroundColor: Colors.green,
          child: Text(
            "${sura.number}",
            style: const TextStyle(
                // color: Colors.white,
                ),
          ),
        ),
        subtitle: Text(
          "${sura.ayahs.length} آيه ",
          maxLines: 2,
        ),
        trailing: Text(
          "${sura.englishName}",
          maxLines: 2,
        ),
      ),
    );
  }
}
