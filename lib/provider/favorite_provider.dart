import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavioriteMealsNotifer extends StateNotifier<List<Meal>> {
  FavioriteMealsNotifer() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favioriteMealsProvider =
    StateNotifierProvider<FavioriteMealsNotifer, List<Meal>>((ref) {
  return FavioriteMealsNotifer();
});
