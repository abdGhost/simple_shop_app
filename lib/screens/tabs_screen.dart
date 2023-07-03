import 'package:flutter/material.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/meal_screen.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeal = [];

  void _toggleMealFavorites(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      _favoriteMeal.remove(meal);
    } else {
      _favoriteMeal.add(meal);
    }
  }

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggle: _toggleMealFavorites,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      setState(() {
        activePage = MealScreen(
          meals: [],
          onToggle: _toggleMealFavorites,
        );
        activePageTitle = 'Favorites';
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
        ),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: selectedPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.set_meal,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
