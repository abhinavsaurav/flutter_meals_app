import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meal_provider.dart';

enum Filter {
  gluttenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// notifier class uses state-notifier
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.gluttenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter type, bool value) {
    state = {
      ...state,
      type: value,
    };
  }

  void setFilters(Map<Filter, bool> newFilter) {
    state = newFilter;
  }
}

// provider uses state-notifier-provider
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

// we are using Provider because we don't want to make a class or anything like that
// only we are making use of the other providers and using them.
final filtereredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);

  return meals.where((item) {
    if (selectedFilters[Filter.gluttenFree]! && !item.isGlutenFree) {
      return false;
    }
    if (selectedFilters[Filter.lactoseFree]! && !item.isLactoseFree) {
      return false;
    }
    if (selectedFilters[Filter.vegetarian]! && !item.isVegetarian) {
      return false;
    }
    if (selectedFilters[Filter.vegan]! && !item.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
