import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

import 'meal_details.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) toggleFavouriteMeals;

  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.toggleFavouriteMeals});

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealDetailsScreen(
            meal: meal,
            toggleFavouriteMeals: toggleFavouriteMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Uh oh.. nothing here!",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "Try selecting a different category",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealItem(
            meal: meals[index],
            onMealSelected: selectMeal,
          );
        },
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
