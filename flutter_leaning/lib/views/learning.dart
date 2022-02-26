import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_leaning/util/data.dart';
import 'package:intl/intl.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:flutter_leaning/util/bookmarkModel.dart';
import 'package:flutter_leaning/util/learningModel.dart';
import 'package:flutter_leaning/views/bookmark.dart';

class Learning extends StatefulWidget {
  const Learning({Key? key}) : super(key: key);

  @override
  _LearningsState createState() => _LearningsState();
}

class _LearningsState extends State<Learning> {
  @override
  Widget build(BuildContext context) {
    //fectch data

    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Learn",
            textAlign: TextAlign.center,
          ),
        ),

        // TextField(

        //   textAlign: TextAlign.center,
        //   decoration: InputDecoration.collapsed(
        //     hintText: 'Learn',
        //   ),
        // ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark_outline,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Bookmark()),
              );
            },
          ),
        ],
      ),
      //body:
      // ListView(children: [
      //   KeywordWidget(),
      //   // MyStatelessWidget(),
      // ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: KeywordWidget(),
      ),
    );
  }
}

class CustomListItem extends StatefulWidget {
  const CustomListItem(
      {Key? key,
      required this.thumbnail,
      required this.title,
      required this.name,
      required this.description,
      required this.share,
      required this.keyword,
      required this.keywordcolor,
      required this.index})
      : super(key: key);

  final Widget thumbnail;
  final String title;
  final String name;
  final String description;
  final String share;
  final String keyword;
  final String keywordcolor;
  final int index;

  @override
  State<CustomListItem> createState() => _CustomListItemState();
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
                  alignment: Alignment.topRight,
                  icon: toggle
                      ? const Icon(
                          Icons.bookmark,
                          size: 16.0,
                        )
                      : const Icon(
                          Icons.bookmark_outline,
                          size: 16.0,
                        ),
                  onPressed: () {
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
                      var bookmark = bookmarkModel.remove(item);
                      setState(() {
                        // Here we changing the icon.
                        toggle = !toggle;
                      });
                    } else {
                      var bookmark = bookmarkModel.add(item);
                      setState(() {
                        // Here we changing the icon.
                        toggle = !toggle;
                      });
                    }
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
                      style: const TextStyle(fontSize: 10),
                    ),
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      primary: getColor(widget.keywordcolor),
                      backgroundColor: getBackgroundColor(widget.keywordcolor),
                      side: BorderSide(
                          color: getBorderColor(widget.keywordcolor)),
                      padding: const EdgeInsets.all(2),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.thumb_down_outlined,
                      size: 16.0,
                    ),
                    Icon(
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
      padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Icon(
                Icons.article,
                color: Colors.grey,
                size: 10.0,
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

class KeywordWidget extends StatefulWidget {
//  const KeywordWidget({Key? key}) : super(key: key);
  const KeywordWidget({
    Key? key,
  }) : super(key: key);

  @override
  _KeywordWidgetState createState() => _KeywordWidgetState();
}

class _KeywordWidgetState extends State<KeywordWidget> {
  late Future<List<Tag>> _dataRequiredForBuild;
  @override
  void initState() {
    super.initState();
    _dataRequiredForBuild = fetchTags();
  }

  final locator = GetIt.instance;

  final bookmarkModel = GetIt.instance<BookmarkModel>();

  final learningModel = GetIt.instance<LearningModel>();
  final GlobalKey<_MyStatelessWidgetState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headlineSmall!,
      textAlign: TextAlign.center,
      child: FutureBuilder<List<Tag>>(
          future:
              _dataRequiredForBuild, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<List<Tag>> snapshot) {
            List<Widget> tagchildren;

            if (snapshot.hasData) {
              tagchildren = snapshot.data!.map((data) {
                return Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: OutlinedButton(
                      child: Text(
                        data.name,
                        style: TextStyle(fontSize: 10),
                      ),
                      onPressed: () {
                        //filter
                        bookmarkModel.setTagBuffer(data.name);
                        _key.currentState!.methodInChild();
                      },
                      style: OutlinedButton.styleFrom(
                        primary: getColor(data.color),
                        backgroundColor: getBackgroundColor(data.color),
                        side: BorderSide(color: getBorderColor(data.color)),
                        padding: EdgeInsets.all(2),
                      ),
                    ),
                  ),
                ]);
              }).toList();
              //           Card(
              //       elevation: 10, //shadow elevation for card
              //       margin: EdgeInsets.all(8),
              //       child: Container(
              //           color: Colors.orange[100],
              //           child: Column(
              //               mainAxisAlignment: MainAxisAlignment
              //                   .center, //main axix alignemnt to center
              //               children: <Widget>[
              //                 Text(people.name, style: TextStyle(fontSize: 20)),
              //                 Text(people.color, style: TextStyle(fontSize: 13)),
              //               ])));
              // }).toList();
              // );

              // children = <Widget>[
              //   const Icon(
              //     Icons.check_circle_outline,
              //     color: Colors.green,
              //     size: 60,
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.only(top: 16),
              //     child: Text('Result: ${snapshot.data![0].name}'),
              //   )
              // ];
            } else if (snapshot.hasError) {
              tagchildren = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              tagchildren = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting ...'),
                )
              ];
            }
            return
                //padding: EdgeInsets.all(10),
                Column(
              children: [
                Wrap(runSpacing: 5.0, spacing: 5.0, children: tagchildren),
                MyStatelessWidget(
                  key: _key,
                )
              ],
            );
          }),
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
              //fitler

              if (!bookmarkModel.TagBuffer.contains(
                      snapshot.data![index].tags![0].name) &&
                  bookmarkModel.TagBuffer != "All") return new Container();
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
                        keywordcolor: snapshot.data![index].tags![0].color,
                        thumbnail: ClipRRect(
                          borderRadius: const BorderRadius.all(
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

  methodInChild() => setState(() {});
  openBrowserTab(String urladdress) async {
    await FlutterWebBrowser.openWebPage(url: urladdress);
  }
}

Color getColor(String txtColor) {
  Color color = Colors.black;
  switch (txtColor) {
    case "red":
      color = Colors.red;
      break;
    case "yellow":
      color = Colors.orange;
      break;
    case "blue":
      color = Colors.blue;
      break;
    case "green":
      color = Colors.green;
      break;
    case "black":
      color = Colors.black;
      break;
    default:
      color = Colors.black;
      break;
  }
  return color;
}

Color getBackgroundColor(String txtColor) {
  Color color = Colors.black;
  switch (txtColor) {
    case "red":
      color = Color.fromRGBO(255 - 100, 0, 0, 0.2);
      break;
    case "yellow":
      color = Color.fromRGBO(255 - 50, 255 - 50, 0, 0.2);
      break;
    case "blue":
      color = Color.fromRGBO(0, 0, 255 - 100, 0.2);
      break;
    case "green":
      color = Color.fromRGBO(0, 255 - 100, 0, 0.2);
      break;
    case "black":
      color = Color.fromRGBO(255 - 100, 255 - 100, 255 - 100, 0.2);
      break;
    default:
      color = Colors.black;
      break;
  }
  return color;
}

Color getBorderColor(String txtColor) {
  Color color = Colors.black;
  switch (txtColor) {
    case "red":
      color = Color.fromRGBO(255 - 100, 0, 0, 0.5);
      break;
    case "yellow":
      color = Colors.yellow;
      color = Color.fromRGBO(255 - 100, 255 - 100, 0, 0.5);
      break;
    case "blue":
      color = Colors.blue;
      color = Color.fromRGBO(0, 0, 255 - 100, 0.5);
      break;
    case "green":
      color = Color.fromRGBO(0, 255 - 100, 0, 0.5);
      break;
    case "black":
      color = Colors.black;
      break;
    default:
      color = Colors.black;
      break;
  }
  return color;
}
