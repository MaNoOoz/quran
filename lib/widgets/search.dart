import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/HomeController.dart';
import '../models/Data1.dart';
import '../views/SuraView.dart';
import 'Item.dart';

class SearchSura extends SearchDelegate {
  SearchSura()
      : super(
            searchFieldLabel: "بحث",
            // searchFieldStyle: Constants.fontStyle,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.search);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(
            Icons.clear,
            // color: Colors.black45,
          ),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      return GetBuilder<HomeController>(builder: (c) {
        List<Surah> filterdList = c.suraList2.where((element) {
          var searchResult =
              element.name.toLowerCase().contains(query) || element.englishName.toLowerCase().contains(query);

          return searchResult;
        }).toList();

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: filterdList.length,
          itemBuilder: (BuildContext context, int index) {
            Surah sura = filterdList[index];
            print(filterdList.length.toString());

            return MyItem(
                sura: sura,
                onTap: () async {
                  await Get.to(() => SuraView(), arguments: sura);
                });
          },
        );
      });
      // return Container();
    } else {
      return Center(
        child: TextButton(
            onPressed: () {
              print("TextButton.icon");
            },
            child: const Text(
              "أدخل كلمة للبحث",
              // style: Constants.fontStyle,
            )),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        // height: 232,
        //   color: Colors.red,
//       child: GetBuilder<HomeController>(builder: (c) {
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//
//               Container(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   itemCount: c.adsListFilter.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     Surah adModel = c.adsListFilter[index];
//
//                     return Item(adModel, onTap: () async {
//                       Get.to(() => SuraView(adModel));
//                     });
// },
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
        );
  }
}
