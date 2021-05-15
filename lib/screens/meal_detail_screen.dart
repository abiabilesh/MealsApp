import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meals.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail_screen';
  final Function toggleFavorites;
  final Function isMealFav;

  MealDetailScreen(this.toggleFavorites,this.isMealFav);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final _selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${_selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                _selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Ingredients',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            BuildContainer(
              childWidget: ListView.builder(
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(_selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: _selectedMeal.ingredients.length,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Steps',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            BuildContainer(
              childWidget: ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${(index+1)}'),
                      ),
                      title: Text(_selectedMeal.steps[index], style: Theme.of(context).textTheme.bodyText1,),
                    ),
                    Divider()
                  ],
                ),
                itemCount: _selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFav(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorites(mealId),
      ),
    );
  }
}

class BuildContainer extends StatelessWidget {
  const BuildContainer({
    @required Widget childWidget,
  }) : _child = childWidget;

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _child,
    );
  }
}
