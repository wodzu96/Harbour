import 'package:flutter/material.dart';
import 'package:harbour/models/PKDData.dart';
import 'package:harbour/res/Assets.dart';

class BusinessCategoriesService {
  static final List<PKDData> users = [PKDData(
  name: "Fryzjer",
  icon: Image.asset(Assets.hair),
  description: "Fryzjer lubi obcinać ludzi")];

  static List<PKDData> getSuggestions(String query) =>
      List.of(users).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}
