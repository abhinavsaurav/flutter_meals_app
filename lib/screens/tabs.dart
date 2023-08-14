import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      toggleFavouriteMeals: toggleFavouriteMeals,
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
