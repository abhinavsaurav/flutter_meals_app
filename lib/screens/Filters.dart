import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters_provider.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);

    ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Your filters")),
      body: Column(children: [
        SwitchListTile(
          value: activeFilters[Filter.gluttenFree]!,
          onChanged: (value) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.gluttenFree, value);
          },
          title: Text(
            'Gluten free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include glutten free meal',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.lactoseFree]!,
          onChanged: (value) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, value);
          },
          title: Text(
            'Lactose free',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include Lactose free meal',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.vegetarian]!,
          onChanged: (value) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegetarian, value);
          },
          title: Text(
            'Vegetarian',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include vegetarian meal',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: activeFilters[Filter.vegan]!,
          onChanged: (value) {
            ref.read(filtersProvider.notifier).setFilter(Filter.vegan, value);
          },
          title: Text(
            'Vegan',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(
            'Only include Vegan meal',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: const EdgeInsets.only(left: 34, right: 22),
        ),
      ]),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app/provider/filters_provider.dart';
// import 'package:meals_app/screens/meals.dart';
// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

// // enum Filter {
// //   gluttenFree,
// //   lactoseFree,
// //   vegetarian,
// //   vegan,
// // }

// class FiltersScreen extends ConsumerStatefulWidget {
//   // Map<Filter, bool> appliedFilters;
//   FiltersScreen({
//     super.key,
//     // required this.appliedFilters,
//   });

//   @override
//   ConsumerState<FiltersScreen> createState() {
//     return _FiltersScreenState();
//   }
// }

// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//   bool _gluttenFreeState = false;
//   bool _lactoseFreeState = false;
//   bool _vegetarianState = false;
//   bool _veganState = false;

//   @override
//   void initState() {
//     super.initState();
//     final activeFilters = ref.read(filtersProvider);
//     // _gluttenFreeState = widget.appliedFilters[Filter.gluttenFree]!;
//     // _lactoseFreeState = widget.appliedFilters[Filter.lactoseFree]!;
//     // _vegetarianState = widget.appliedFilters[Filter.vegetarian]!;
//     // _veganState = widget.appliedFilters[Filter.vegan]!;

//     // the above is alternative approach w/o the state-management package
//     _gluttenFreeState = activeFilters[Filter.gluttenFree]!;
//     _lactoseFreeState = activeFilters[Filter.lactoseFree]!;
//     _vegetarianState = activeFilters[Filter.vegetarian]!;
//     _veganState = activeFilters[Filter.vegan]!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Your filters")),
//       // ! Alternative pattern for navigating between screen
//       // ! by replacing them using pushReplacement
//       // drawer: MainDrawer(
//       //   setScreen: (String identifier) {
//       //     Navigator.of(context).pop();
//       //     if (identifier == 'meals') {
//       //       Navigator.of(context).pushReplacement(MaterialPageRoute(
//       //         builder: (context) => const TabsScreen(),
//       //       ));
//       //     }
//       //   },
//       // ),
//       body: WillPopScope(
//         onWillPop: () async {
//           // Navigator.of(context).pop({
//           //   Filter.gluttenFree: _gluttenFreeState,
//           //   Filter.lactoseFree: _lactoseFreeState,
//           //   Filter.vegetarian: _vegetarianState,
//           //   Filter.vegan: _veganState,
//           // });
//           // return false;
//           ref.read(filtersProvider.notifier).setFilters({
//             Filter.gluttenFree: _gluttenFreeState,
//             Filter.lactoseFree: _lactoseFreeState,
//             Filter.vegetarian: _vegetarianState,
//             Filter.vegan: _veganState,
//           });

//           // since we are not popping now manually so we turn it to true
//           return true;
//         },
//         child: Column(children: [
//           SwitchListTile(
//             value: _gluttenFreeState,
//             onChanged: (value) {
//               setState(() {
//                 _gluttenFreeState = value;
//               });
//             },
//             title: Text(
//               'Gluten free',
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             subtitle: Text(
//               'Only include glutten free meal',
//               style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left: 34, right: 22),
//           ),
//           SwitchListTile(
//             value: _lactoseFreeState,
//             onChanged: (value) {
//               setState(() {
//                 _lactoseFreeState = value;
//               });
//             },
//             title: Text(
//               'Lactose free',
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             subtitle: Text(
//               'Only include Lactose free meal',
//               style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left: 34, right: 22),
//           ),
//           SwitchListTile(
//             value: _vegetarianState,
//             onChanged: (value) {
//               setState(() {
//                 _vegetarianState = value;
//               });
//             },
//             title: Text(
//               'Vegetarian',
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             subtitle: Text(
//               'Only include vegetarian meal',
//               style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left: 34, right: 22),
//           ),
//           SwitchListTile(
//             value: _veganState,
//             onChanged: (value) {
//               setState(() {
//                 _veganState = value;
//               });
//             },
//             title: Text(
//               'Vegan',
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             subtitle: Text(
//               'Only include Vegan meal',
//               style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                     color: Theme.of(context).colorScheme.onBackground,
//                   ),
//             ),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left: 34, right: 22),
//           ),
//         ]),
//       ),
//     );
//   }
// }
