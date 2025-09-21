import 'package:flutter/material.dart';

import '../domain/category.dart';

const categories = {
  CategoryType.vegetables: Category(title: 'Vegetables', color: Colors.green),
  CategoryType.fruit: Category(title: 'Fruit', color: Colors.redAccent),
  CategoryType.meat: Category(title: 'Meat', color: Colors.deepOrange),
  CategoryType.dairy: Category(title: 'Dairy', color: Colors.blueAccent),
  CategoryType.carbs: Category(title: 'Carbs', color: Colors.orangeAccent),
  CategoryType.sweets: Category(title: 'Sweets', color: Colors.pinkAccent),
  CategoryType.spices: Category(title: 'Spices', color: Colors.deepPurple),
  CategoryType.convenience: Category(
    title: 'Convenience',
    color: Colors.indigo,
  ),
  CategoryType.hygiene: Category(title: 'Hygiene', color: Colors.teal),
  CategoryType.other: Category(title: 'Other', color: Colors.grey),
};
