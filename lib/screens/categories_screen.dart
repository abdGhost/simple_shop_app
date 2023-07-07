import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/screens/meal_screen.dart';
import 'package:shop_app/widgets/category_grid_item_widget.dart';
import 'package:shop_app/models/category_model.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    // required this.onToggle,
    required this.availableMeals,
  });

  // void Function(Meal meal) onToggle;
  final List<Meal> availableMeals;

  void _selectedCategory(BuildContext context, CategoryModel category) {
    final filterMeal = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => MealScreen(
              meals: filterMeal,
              title: category.title,
              // onToggle: onToggle,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItemWidget(
            category: category,
            onSelectCategory: () {
              _selectedCategory(context, category);
            },
          )
      ],
    );
  }
}
