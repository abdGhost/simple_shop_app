import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/provider/meal_provider.dart';

enum Fliters {
  gultenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FilterNotifer extends StateNotifier<Map<Fliters, bool>> {
  FilterNotifer()
      : super({
          Fliters.gultenFree: false,
          Fliters.lactoseFree: false,
          Fliters.vegeterian: false,
          Fliters.vegan: false,
        });

  void setFliter(Fliters fliter, bool isActive) {
    state = {
      ...state,
      fliter: isActive,
    };
  }

  void setFilters(Map<Fliters, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifer, Map<Fliters, bool>>(
    (ref) => FilterNotifer());

final filteredMealProvier = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilter = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilter[Fliters.gultenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilter[Fliters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilter[Fliters.vegeterian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilter[Fliters.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
