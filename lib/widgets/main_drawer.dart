import 'package:flutter/material.dart';
import 'package:meals_app/screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget buildListTile(IconData icon, String title, Function _onClickListTile) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: _onClickListTile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              //height: 120,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text(
                'Cooking Up!!',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile(Icons.restaurant, 'Meals', () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
            buildListTile(Icons.settings, 'Filters', (){
              Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
