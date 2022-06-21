import 'package:flutter/material.dart';

import '../models/Data1.dart';

class MyItem extends StatelessWidget {
  final Surah sura;
  final void Function() onTap;

  MyItem({required this.sura, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        "${sura.name}",
        maxLines: 2,
      ),
      leading: CircleAvatar(
        // backgroundColor: Constants.AppMainColorDark,
        child: Text("${sura.number}"),
      ),
      subtitle: Text(
        "${sura.ayahs.length} آيه ",
        maxLines: 2,
      ),
      trailing: Text(
        "${sura.englishName}",
        maxLines: 2,
      ),
    );
  }
}
