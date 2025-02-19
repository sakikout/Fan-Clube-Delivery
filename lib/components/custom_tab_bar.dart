import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food.dart';

class CustomTabBar extends StatelessWidget{
  final TabController tabController;

  const CustomTabBar({
    super.key,
    required this.tabController
    });

    List<Tab> _buildCategoryTabs(){
      return FoodCategory.values.map((category) {
        return Tab(
          text: category.toString().split('.').last,
        );
      }).toList();
    }

  @override
  Widget build(BuildContext context){
    return TabBar(
        controller: tabController,
        tabs: _buildCategoryTabs(),
      );
  }
}