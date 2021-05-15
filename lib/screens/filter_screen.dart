import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter_screen';
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  FilterScreen(this.currentFilters, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenfree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.bodyText1,),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
    _glutenfree = widget.currentFilters['_glutenfree'];
    _vegetarian = widget.currentFilters['_vegetarian'];
    _vegan = widget.currentFilters['_vegan'];
    _lactoseFree = widget.currentFilters['_lactosefree'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: () {
          Map<String, bool> filters = {
            '_glutenfree': _glutenfree,
            '_vegetarian': _vegetarian,
            '_vegan': _vegan,
            '_lactosefree': _lactoseFree,
          };
          widget.saveFilters(filters);
        })],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust you meal  selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchListTile(
                  'Gluten-free', 'Only include gluten-free meals', _glutenfree,
                  (newValue) {
                setState(() {
                  _glutenfree = newValue;
                });
              }),
              _buildSwitchListTile(
                'Lactose-free',
                'Only include lactose-free meals.',
                _lactoseFree,
                (newValue) {
                  setState(
                    () {
                      _lactoseFree = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile(
                'Vegetarian',
                'Only include vegetarian meals.',
                _vegetarian,
                (newValue) {
                  setState(
                    () {
                      _vegetarian = newValue;
                    },
                  );
                },
              ),
              _buildSwitchListTile('Vegan', 'Only include vegan meals.', _vegan,
                  (newValue) {
                setState(
                  () {
                    _vegan = newValue;
                  },
                );
              }),
            ],
          ))
        ],
      ),
    );
  }
}
