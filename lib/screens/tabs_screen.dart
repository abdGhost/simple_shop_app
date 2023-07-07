import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_app/provider/favorite_provider.dart';
import 'package:shop_app/screens/categories_screen.dart';
import 'package:shop_app/screens/filters_screen.dart';
import 'package:shop_app/screens/meal_screen.dart';
import 'package:shop_app/widgets/main_drawer_widget.dart';

import '../provider/fliter_provider.dart';

const kInitialFliter = {
  Fliters.gultenFree: false,
  Fliters.lactoseFree: false,
  Fliters.vegeterian: false,
  Fliters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSelectedDrawer(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Fliters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final meals = ref.watch(mealProvider);
    // final activeFilter = ref.watch(filterProvider);
    final avaiableFliters = ref.watch(filteredMealProvier);

    Widget activePage = CategoriesScreen(
      // onToggle: _toggleMealFavorites,
      availableMeals: avaiableFliters,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeal = ref.watch(favioriteMealsProvider);
      setState(() {
        activePage = MealScreen(
          meals: favoriteMeal,
          // onToggle: _toggleMealFavorites,
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
