import 'package:flutter/material.dart';
import 'package:native_perf/screens/detailsScreen.dart';

class MyListView extends StatelessWidget {
  final items = List<String>.generate(10000, (i) => "Deal $i");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List View'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(index: index),
              ),
            ),
            key: Key('${items[index]}'),
            title: Text('${items[index]}'),
            leading: Icon(Icons.restaurant),
            subtitle: Text('Available at location'),
          );
        },
      ),
    );
  }
}
