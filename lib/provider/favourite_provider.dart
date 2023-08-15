import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

// we should use notifier to tell which kind of data will be managed by notifier
class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  // The super part contains the initial data and is used for
  FavouriteMealsNotifier() : super([]);

  // now to work with the data we create methods to do the changes to the data
  // we will receive a meal to this favourtie meal just like we got previously

  bool toggleFavouriteMeals(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      state = state.where((item) => item.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
