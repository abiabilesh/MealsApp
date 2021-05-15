import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/category_detail_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/home_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

void main() {
  runApp(MealsApp());
}

class MealsApp extends StatefulWidget {
  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {
  List<Meal> dummyMealList = DUMMY_MEALS;
  List<Meal> favoriteMealList = [];

  Map<String, bool> filters = {
    '_glutenfree': false,
    '_vegetarian': false,
    '_vegan': false,
    '_lactosefree': false,
  };

  void _setFilters(Map<String, bool> newfilters) {
    setState(() {
      filters = newfilters;
      dummyMealList = DUMMY_MEALS.where((meal) {
        if (!meal.isGlutenFree && filters['_glutenfree'])
          return false;
        if (!meal.isLactoseFree && filters['_lactosefree'])
          return false;
        if (!meal.isVegetarian && filters['_vegetarian'])
          return false;
        if (!meal.isVegan && filters['_vegan'])
          return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorites(String mealId) {
    final existingIndex = favoriteMealList.indexWhere((meal) =>
    meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMealList.removeAt(existingIndex);
      });
    }
    else {
      setState(() {
        favoriteMealList.add(
            DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFav(String mealId){
    return favoriteMealList.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MealsApp',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData
            .dark()
            .textTheme
            .copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => HomeScreen(favoriteMealList),
        CategoryDetailScreen.routeName: (ctx) =>
            CategoryDetailScreen(dummyMealList),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorites, _isMealFav),
        FilterScreen.routeName: (ctx) => FilterScreen(filters, _setFilters),
      },
    );
  }
}
