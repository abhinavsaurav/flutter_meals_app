import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/favourite_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/provider/meal_provider.dart';
import 'package:meals_app/screens/Filters.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

import '../widgets/main_drawer.dart';

const kInitialFilter = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int activePageIndex = 0;
  // List<Meal> favouriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitialFilter;

  void _selectPage(value) {
    setState(() {
      activePageIndex = value;
    });
  }

  // void _showInfoMessage(String infoMessage) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(infoMessage),
  //   ));
  // }

  // void toggleFavouriteMeals(Meal meal) {
  //   if (favouriteMeals.contains(meal)) {
  //     setState(() {
  //       favouriteMeals.remove(meal);
  //     });
  //     _showInfoMessage("meal removed");
  //   } else {
  //     setState(() {
  //       favouriteMeals.add(meal);
  //     });
  //     _showInfoMessage("meal added to favs");
  //   }
  // }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      // final result =
      await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) {
            return FiltersScreen(
                // appliedFilters: _selectedFilters,
                );
          },
        ),
      );

      // // ! FUTURE null value scneario handing
      // setState(() {
      //   _selectedFilters = result ?? _selectedFilters;
      // });
      // print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // watching a provider dependent on other providers
    final List<Meal> availableMeals = ref.watch(filtereredMealsProvider);
    Widget activePage = CategoriesScreen(
      // toggleFavouriteMeals: toggleFavouriteMeals,
      availableMeal: availableMeals,
    );
    String activePageTitle = "Categories";

    if (activePageIndex == 1) {
      final favouriteMealFromRP = ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals: favouriteMealFromRP,
        // toggleFavouriteMeals: toggleFavouriteMeals,
      );
      activePageTitle = "Your Favourites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle), centerTitle: false),
      drawer: MainDrawer(setScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activePageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
