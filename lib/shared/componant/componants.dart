import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/modules/cubit/newscubit.dart';
import '../../modules/webViewSearch/webViewSearch.dart';

Widget buildItemNsws(
  context,
  item,
) {
  bool addit = true;
  var i;
  for (i in NewsCubit.get(context).archiveNews) {
    if (item['title'] == i['title']) {
      addit = false;
    }
  }
  return item != null
      ? InkWell(
          onTap: () {
            navigatTo(
              context,
              WebViewSearch(
                url: item['url'],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          image: DecorationImage(
                              image: NetworkImage("${item['urlToImage']}"),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 1.0, left: 1, right: 4.0),
                                child: Text(
                                  "${item['title']}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: .5,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item['publishedAt']}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        addit
                                            ? NewsCubit.get(context)
                                                .addDataFB(item)
                                            : NewsCubit.get(context)
                                                .delete(item);
                                      },
                                      icon: addit
                                          ? Icon(
                                              Icons.archive_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : Icon(
                                              Icons.delete_outline_outlined,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      : CircularProgressIndicator();
}

Widget coditionalList({context, required List<dynamic> list, state}) =>
    ConditionalBuilder(
        condition: list.isNotEmpty,
        builder: (BuildContext context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, int i) =>
                    buildItemNsws(context, list[i]),
                itemCount: list.length,
              ),
            ),
        fallback: (BuildContext context) =>
            Center(child: CircularProgressIndicator()));

Future navigatTo(context, widget) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}
