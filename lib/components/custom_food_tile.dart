import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food.dart';

class CustomFoodTile extends StatelessWidget{
  final Food food;
  final void Function()? onTap;

  const CustomFoodTile({
    super.key,
    required this.food,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
              // food details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name),
                    Text('R\$${food.price}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary
                    )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(food.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary
                    ),),
                  ],
                )
              ),

            const SizedBox(width: 15,),

            // food image
            ClipRRect( 
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
              food.imagePath,
              height: 100,),
            ),
          ],)
          ),
        ),

        Divider(
          color: Theme.of(context).colorScheme.tertiary,
          endIndent: 25,
          indent: 25,
        )
      ],
    );
     
  }


}