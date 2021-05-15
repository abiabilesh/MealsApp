import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  final List<Meal> favoritesList;

  const HomeScreen(this.favoritesList);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedBottomButtonIndex = 0;
  List <Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title' : 'Categories'
      },
      {
        'page' : FavoritesScreen(widget.favoritesList),
        'title' : 'Favorites',
      }
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _onClickBottomButton(int index){
    setState(() {
      _selectedBottomButtonIndex = index;
      print('_selectedBottomButtonIndex is $_selectedBottomButtonIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MealsApp'),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedBottomButtonIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
              backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
        currentIndex: _selectedBottomButtonIndex,
        onTap: _onClickBottomButton,
      ),
    );
  }
}
