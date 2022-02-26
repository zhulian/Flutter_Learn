import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Tag>> fetchTags() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/c498ac6a-5be7-4ac3-b407-b703af3e2247'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var tagObjsJson = jsonDecode(response.body)['tags'] as List;
    List<Tag> tagObjs =
        tagObjsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();
    tagObjs.add(new Tag("All", "black"));
    tagObjs.sort((a, b) => a.name.length.compareTo(b.name.length));

    return tagObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load tag');
  }
}

class Tag {
  String name;
  String color;

  Tag(this.name, this.color);

  factory Tag.fromJson(dynamic json) {
    return Tag(json['name'] as String, json['color'] as String);
  }
}

Future<List<Content>> fetchContent() async {
  final response = await http.get(Uri.parse(
      'https://run.mocky.io/v3/742454fc-089b-47df-b7c1-4c1ce4091586'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var contentObjsJson = jsonDecode(response.body)['learn_content'] as List;
    List<Content> contentObjs =
        contentObjsJson.map((tagJson) => Content.fromJson(tagJson)).toList();
    return contentObjs;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load content');
  }
}

class Content {
  String? created_at;
  String? type;
  String? title;
  String? description;
  String? thumbnail_url;
  String? content_url;
  List<Tag>? tags;

  Content(this.created_at, this.type, this.title, this.description,
      this.thumbnail_url, this.content_url, this.tags);

  Content.fromJson(Map<String, dynamic> json) {
    created_at = json['created_at'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    thumbnail_url = json['thumbnail_url'];
    content_url = json['content_url'];
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(new Tag.fromJson(v));
      });
    }
  }
  // factory Content.fromJson(dynamic json) {
  //   //var tags = List<Tag>.from(json['tags']);
  //   return Content(
  //       json['created_at'] as String,
  //       json['type'] as String,
  //       json['title'] as String,
  //       json['description'] as String,
  //       json['thumbnail_url'] as String,
  //       json['content_url'] as String,
  //       json['tag'] as List<Tag>)

  // }
}

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  late Future<List<Tag>> futureTags;
  late Future<List<Content>> futureContents;
  @override
  void initState() {
    super.initState();
    futureTags = fetchTags();
    futureContents = fetchContent();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<List<Tag>>(
            future: futureTags,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data![0].name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
