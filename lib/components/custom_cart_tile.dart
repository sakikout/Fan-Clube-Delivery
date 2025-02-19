import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/quantity_selector.dart';
import 'package:flutter_application_1/models/cart_item.dart';
import 'package:flutter_application_1/models/restaurant.dart';
import 'package:provider/provider.dart';

class CustomCartTile extends StatelessWidget{
    final CartItem cartItem;

  const CustomCartTile({
    super.key,
    required this.cartItem
    });

  @override
  Widget build(BuildContext context){
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column (
                children: [
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            // food image
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(cartItem.food.imagePath,
                                        height: 100,
                                        width: 100,),
                            ),

                            const SizedBox(width: 10,),

                            // name and price

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                // food name
                                Text(cartItem.food.name),

                                // food price
                                 Text('R\$${cartItem.food.price}',
                                 style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary
                                 ),
                                ),
                              
                              const SizedBox(height: 10),

                               // increment or decrement quantity
                            QuantitySelector(
                                food: cartItem.food, 
                                quantity: cartItem.quantity, 
                                onDecrement: (){
                                    restaurant.removeFromCart(cartItem);
                                }, 
                                onIncrement: (){
                                    restaurant.addToCart(cartItem.food, cartItem.selectedAddons);
                                })


                            ],),

        
                           
                        ],
                    ),
                    ),

                    // addons

                    SizedBox(
                        height: cartItem.selectedAddons.isEmpty ? 0 : 60,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10,),
                            children: cartItem.selectedAddons.map(
                                (addon) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                    label: Row(
                                        children: [
                                            // addon name
                                            Text(addon.name),

                                            //addon price
                                            Text('(R\$${addon.price.toString()})'),
                                            
                                        ],
                                    ),

                                    shape: StadiumBorder(
                                        side: BorderSide(
                                            color: Theme.of(context).colorScheme.primary
                                        )
                                    ), 
                                    onSelected: (value){

                                    },
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.inversePrimary,
                                        fontSize: 12,
                                    ),
                                ),),
                            ).toList(),
                        )
                        )

            ],)
        ),
    );
  }
}