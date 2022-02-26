// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter_leaning/util/learningModel.dart';

class BookmarkModel extends ChangeNotifier {
  late LearningModel _learning;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];
  final List<Item> _items = [];
  final List<String> _itemTags = [];
  String _tagBuffer = "All";

  /// The current catalog. Used to construct items from numeric ids.
  LearningModel get learningModel => _learning;

  set learning(LearningModel learningModel) {
    _learning = learningModel;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items {
    return _items;
  }

  List<int> get itemIds {
    return _itemIds;
  }

  List<String> get ItemTags {
    return _itemTags;
  }

  String get TagBuffer {
    return _tagBuffer;
  }

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _items.add(item);
    _itemIds.add(item.id);
    _itemTags.add(item.keyword);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    _items.remove(item);
    _itemTags.remove(item.keyword);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }

  void setTagBuffer(String tag) {
    _tagBuffer = tag;
  }
}
