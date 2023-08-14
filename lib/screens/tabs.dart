import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
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

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int activePageIndex = 0;
  List<Meal> favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilter;

  void _selectPage(value) {
    setState(() {
      activePageIndex = value;
    });
  }

  void _showInfoMessage(String infoMessage) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(infoMessage),
    ));
  }

  void toggleFavouriteMeals(Meal meal) {
    if (favouriteMeals.contains(meal)) {
      setState(() {
        favouriteMeals.remove(meal);
      });
      _showInfoMessage("meal removed");
    } else {
      setState(() {
        favouriteMeals.add(meal);
      });
      _showInfoMessage("meal added to favs");
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      final result = await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) {
            return FiltersScreen(
              appliedFilters: _selectedFilters,
            );
          },
        ),
      );

      // ! FUTURE null value scneario handing
      setState(() {
        _selectedFilters = result ?? _selectedFilters;
      });
      // print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> availableMeals = dummyMeals.where((item) {
      if (_selectedFilters[Filter.gluttenFree]! && !item.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !item.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !item.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !item.isVegan) {
        return false;
      }

      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      toggleFavouriteMeals: toggleFavouriteMeals,
      availableMeal: availableMeals,
    );
    String activePageTitle = "Categories";

    if (activePageIndex == 1) {
      activePage = MealsScreen(
        meals: favouriteMeals,
        toggleFavouriteMeals: toggleFavouriteMeals,
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
