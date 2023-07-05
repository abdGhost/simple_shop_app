import 'package:flutter/material.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/filters_screen.dart';
import 'package:shop_app/screens/meal_screen.dart';
import 'package:shop_app/widgets/main_drawer_widget.dart';

import '../models/meal.dart';

const kInitialFliter = {
  Fliters.gultenFree: false,
  Fliters.lactoseFree: false,
  Fliters.vegeterian: false,
  Fliters.vegan: false,
};

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
  Map<Fliters, bool> _selectedFilters = kInitialFliter;

  void _showFavoriteMessages(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavorites(Meal meal) {
    final isExisting = _favoriteMeal.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeal.remove(meal);
        _showFavoriteMessages('Meal is removed from the favorites');
      });
    } else {
      setState(() {
        _favoriteMeal.add(meal);
        _showFavoriteMessages('Meal is added to the favorites');
      });
    }
  }

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSelectedDrawer(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (ctx) => const FiltersScreen(),
      //   ),
      // );
      final result = await Navigator.of(context).push<Map<Fliters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFliter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avaiableFliters = dummyMeals.where((meal) {
      if (_selectedFilters[Fliters.gultenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Fliters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Fliters.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Fliters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggle: _toggleMealFavorites,
      availableMeals: avaiableFliters,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      setState(() {
        activePage = MealScreen(
          meals: _favoriteMeal,
          onToggle: _toggleMealFavorites,
        );
        activePageTitle = 'Favorites';
      });
    }
    return Scaffold(
      drawer: MainDrawerWidget(
        onSelectScreen: _onSelectedDrawer,
      ),
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
