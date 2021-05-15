import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  static const routeName = '/favorites_screen';

  const FavoritesScreen(this.favoriteMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  void _refreshFavScreen(){
    setState(() {
      //empty
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: Text("No Favorite Meal is chosen!!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: widget.favoriteMeals[index].id,
              title: widget.favoriteMeals[index].title,
              affordability: widget.favoriteMeals[index].affordability,
              complexity: widget.favoriteMeals[index].complexity,
              imageUrl: widget.favoriteMeals[index].imageUrl,
              duration: widget.favoriteMeals[index].duration,
              refreshFavScreen: _refreshFavScreen);
        },
        itemCount: widget.favoriteMeals.length,
      );
    }
  }
}
