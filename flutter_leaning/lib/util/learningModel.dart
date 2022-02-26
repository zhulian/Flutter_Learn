// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

/// A proxy of the catalog of items the user can buy.
///
/// In a real app, this might be backed by a backend and cached on device.
/// In this sample app, the catalog is procedurally generated and infinite.
///
/// For simplicity, the catalog is expected to be immutable (no products are
/// expected to be added, removed or changed during the execution of the app).
class LearningModel {
  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  Item getById(int id) => Item(
      id, "itemNames[id % itemNames.length]", new Container(), "", "", "", "");

  /// Get item by its position in the catalog.
  Item generateItem(int id, String name, Widget thumbnail, String title,
      String description, String share, String keyword) {
    return new Item(id, name, thumbnail, title, description, share, keyword);
    // In this simplified case, an item's position in the catalog
    // is also its id.
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Widget thumbnail;
  final String title;
  final String description;
  final String share;
  final String keyword;

  Item(this.id, this.name, this.thumbnail, this.title, this.description,
      this.share, this.keyword);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
