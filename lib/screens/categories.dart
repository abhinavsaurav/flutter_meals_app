import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/Filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> availableMeal;
  const CategoriesScreen({super.key, required this.availableMeal});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      // the bounds control b/w what values the  flutter will animate
      lowerBound: 0,
      upperBound: 1,
    );

    // ! We can start and stop the animation like below
    // ! and it provides us with various options
    _animationController.forward();
  }

  @override
  void dispose() {
    // this makes sure that the animation is removed from the
    // device memory when the animation controller is removed
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    List<Meal> filteredList = widget.availableMeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MealsScreen(
          title: category.id,
          meals: filteredList,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      // _animationController is a listenable object
      animation: _animationController,
      child: GridView(
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
      ),
      // ! the return value is the one which will be animated based on the specified value
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(
          top: 100 - _animationController.value * 100,
        ),
        // ! child is the child supplied above in child which we are receving here
        child: child,
      ),
    );
  }
}
