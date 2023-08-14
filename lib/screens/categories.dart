import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  final void Function(Meal meal) toggleFavouriteMeals;
  const CategoriesScreen({super.key, required this.toggleFavouriteMeals});

  void _selectCategory(BuildContext context, Category category) {
    List<Meal> filteredList = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MealsScreen(
          title: category.id,
          meals: filteredList,
          toggleFavouriteMeals: toggleFavouriteMeals,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final Category category in availableCategories)
          CategoryGridItem(
            category: category,
            onTap: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
