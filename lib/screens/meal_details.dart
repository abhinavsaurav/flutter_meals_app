import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/favourite_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  final Meal meal;
  // final void Function(Meal meal) toggleFavouriteMeals;
  const MealDetailsScreen({
    super.key,
    required this.meal,
    // required this.toggleFavouriteMeals,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Meal> favoutiteMeals = ref.watch(favouriteMealsProvider);
    final bool isFavourite = favoutiteMeals.contains(meal);

    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                // toggleFavouriteMeals(meal);

                // we should set a value for reading instead of watching because it will be problematic in
                // this type also we should call the notifier method to get access to the inside method
                bool isAdded = ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleFavouriteMeals(meal);

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(isAdded ? "Meal added" : "Meal removed"),
                ));
              },
              icon: Icon(isFavourite ? Icons.star : Icons.star_border),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
