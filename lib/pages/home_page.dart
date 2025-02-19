import "package:flutter/material.dart";
import "package:flutter_application_1/components/current_location.dart";
import "package:flutter_application_1/components/custom_food_tile.dart";
import "package:flutter_application_1/components/custom_silver_app_bar.dart";
import "package:flutter_application_1/components/custom_description_box.dart";
import "package:flutter_application_1/components/custom_tab_bar.dart";
import "package:flutter_application_1/components/my_drawer.dart";
import "package:flutter_application_1/models/food.dart";
import "package:flutter_application_1/models/restaurant.dart";
import "package:flutter_application_1/pages/food_page.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late TextEditingController _textController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length:  FoodCategory.values.length, vsync: this);
    _textController = TextEditingController();
  }

  @override
  void dispose(){
    _tabController.dispose();
    _textController.dispose();
    super.dispose();

  }

   String getFoodNameCategory(FoodCategory category) {
  switch (category) {
    case FoodCategory.hamburgers:
      return "Hambúrgueres";
    case FoodCategory.acompanhamentos:
      return "Acompanhamentos";
    case FoodCategory.sobremesas:
      return "Sobremesas";
    case FoodCategory.bebidas:
      return "Bebidas";
    case FoodCategory.pizzas:
      return "Pizzas";
    default:
      return "Outros";
  }
}
  // sorting out and returning a list of food items that belong to a specific category
  List<Food> _filterMenuByCategory(FoodCategory category, List<Food> fullMenu){
    return fullMenu.where((food) => food.category == category).toList();
  }

  // return list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu){
    return FoodCategory.values.map((category){
      // get category menu
      List<Food> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index){
          // get individual food
          final food = categoryMenu[index];

          // return the food tile UI
          return CustomFoodTile(food: food, onTap: () => Navigator.push(
            context,
          MaterialPageRoute(builder: (context) => FoodPage(food: food) )));
      },);
    }).toList();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomSilverAppBar(
            title: CustomTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                Divider(indent: 25, 
                endIndent: 25, 
                color: Theme.of(context).colorScheme.secondary),
                // current location
                CurrentLocation(
                  textController: _textController,),

                // description box
                const CustomDescriptionBox(),

              ],
            ),
          ),
      ],
      body: Consumer<Restaurant>(
        builder: (context, restaurant, child) => TabBarView(
          controller: _tabController,
          children: getFoodInThisCategory(restaurant.menu)
      )
      ),
    )
    );
  }
}