import 'package:flutter/material.dart';
import 'package:harbour/models/PKDData.dart';
import 'package:harbour/res/Assets.dart';

class BusinessCategoriesService {
  static final List<PKDData> users = [
    PKDData(
        name: "Hairdressing",
        iconPath: Assets.hair,
        description: "Hairdressing and other cosmetic procedures"),
    PKDData(
        name: "Clothing stores",
        iconPath: Assets.clothes,
        description: "Retail sale of clothing in specialized stores"),
    PKDData(
  name: "Restaurants",
  iconPath: Assets.restaurants,
  description: "Restaurants")];

  static List<PKDData> getSuggestions(String query) =>
      List.of(users).where((user) {
        final userLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return userLower.contains(queryLower);
      }).toList();
}
