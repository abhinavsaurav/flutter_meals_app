import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final void Function(BuildContext, Meal) onMealSelected;
  const MealItem({super.key, required this.meal, required this.onMealSelected});

  String get complexityText {
    // we can use toString() method here to directly convert it to string
    // but we should use the name property of the enum which returns the string value
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    // we can use toString() method here to directly convert it to string
    // but we should use the name property of the enum which returns the string value
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onMealSelected(context, meal);
        },
        child: Stack(children: [
          Hero(
            tag: meal.id,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black54,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MealItemTrait(
                          icon: Icons.schedule, label: '${meal.duration} min'),
                      const SizedBox(
                        width: 12,
                      ),
                      MealItemTrait(icon: Icons.work, label: complexityText),
                      const SizedBox(
                        width: 12,
                      ),
                      MealItemTrait(
                          icon: Icons.attach_money, label: affordabilityText),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
