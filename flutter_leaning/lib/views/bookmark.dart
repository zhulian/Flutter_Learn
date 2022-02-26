import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_leaning/util/data.dart';
import 'package:flutter_leaning/util/learningModel.dart';

import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter_leaning/util/bookmarkModel.dart';
import 'package:flutter_leaning/views/learning.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Bookmark'),
      ),
      body: MyStatelessWidget(),
      // Center(
      //   child:
      //   ElevatedButton(
      //     onPressed: () {
      //       // Navigate back to first route when tapped.
      //     },
      //     child: const Text('Go back!'),
      //   ),
      // ),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  final locator = GetIt.instance;

  final bookmarkModel = GetIt.instance<BookmarkModel>();

  final learningModel = GetIt.instance<LearningModel>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Content>>(
      builder: (BuildContext context, AsyncSnapshot<List<Content>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              //fiter
              if (!bookmarkModel.itemIds.contains(index))
                return new Container();
              return GestureDetector(
                  //You need to make my child interactive
                  onTap: () =>
                      openBrowserTab(snapshot.data![index].content_url!),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      child: CustomListItem(
                        index: index,
                        name: snapshot.data![index].title!,
                        description: snapshot.data![index].description!,
                        share: "Shared by OnLoop",
                        keyword: snapshot.data![index].tags![0].name,
                        thumbnail: ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), //add border radius here
                          child: Image.network(
                            snapshot.data![index].thumbnail_url!,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ), //add image location here
                        ),
                        title: snapshot.data![index].type![0].toUpperCase() +
                            snapshot.data![index].type!.substring(1) +
                            ' . ' +
                            DateFormat.yMMMd().format(DateTime.parse(snapshot
                                .data![index].created_at!
                                .split("T")[0])),
                      ),
                    ),
                  ));
            },
          );
        } else if (snapshot.hasError) {
          //todo: error handling
          return Container();
        }
        return Container();
      },
      future: fetchContent(),
    );
  }

  openBrowserTab(String urladdress) async {
    await FlutterWebBrowser.openWebPage(url: urladdress);
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    Key? key,
    required this.title,
    required this.name,
    required this.description,
  }) : super(key: key);

  final String title;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Icon(
                Icons.article,
                color: Colors.grey,
                size: 12.0,
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            name,
            style: const TextStyle(fontSize: 12.0),
            overflow: TextOverflow.ellipsis,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            description,
            style: const TextStyle(fontSize: 10.0),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CustomListItemState extends State<CustomListItem> {
  // const _AddButton({required this.item, Key? key}) : super(key: key);
  final locator = GetIt.instance;

  final bookmarkModel = GetIt.instance<BookmarkModel>();

  final learningModel = GetIt.instance<LearningModel>();
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: widget.thumbnail,
                ),
                Expanded(
                  flex: 3,
                  child: _VideoDescription(
                    title: widget.title,
                    name: widget.name,
                    description: widget.description,
                  ),
                ),
                IconButton(
                  icon: toggle
                      ? Icon(
                          Icons.bookmark_outline,
                          size: 16.0,
                        )
                      : Icon(
                          Icons.bookmark,
                          size: 16.0,
                        ),
                  onPressed: () {
                    //  var item = friendModel.getByPosition(index);
                    var item = learningModel.generateItem(
                        widget.index,
                        widget.name,
                        widget.thumbnail,
                        widget.title,
                        widget.description,
                        widget.share,
                        widget.keyword);
                    var isInCart = bookmarkModel.items.contains(item);
                    if (isInCart) {
                      //todo: to be implemented
                      // var cart = cartModel.remove(item);
                      setState(() {
                        // Here we changing the icon.
                        // toggle = !toggle;
                      });
                    } else {}
                  },
                ),
              ],
            ),
            Text(
              widget.share,
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 16,
                  child: OutlinedButton(
                    child: Text(
                      widget.keyword,
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      backgroundColor: Color.fromARGB(255, 233, 202, 192),
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.all(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.thumb_down_outlined,
                      size: 16.0,
                    ),
                    const Icon(
                      Icons.thumb_up_outlined,
                      size: 16.0,
                    ),
                  ],
                ),
              ],
            )
          ]),
    );
  }
}

class CustomListItem extends StatefulWidget {
  CustomListItem(
      {Key? key,
      required this.thumbnail,
      required this.title,
      required this.name,
      required this.description,
      required this.share,
      required this.keyword,
      //   this.item,
      required this.index})
      : super(key: key);

  final Widget thumbnail;
  final String title;
  final String name;
  final String description;
  final String share;
  final String keyword;
  //final Item? item;
  final int index;

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}
