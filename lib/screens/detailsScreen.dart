import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({required this.index});
  final int index;
  final myImage = Image.network(
    'https://picsum.photos/200',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            myImage,
            Text('Quick Math: You have chosen ${index.toString()}. '
                '2 + ${index.toString()} is ${(index + 2).toString()}'
                ' - 1 that\'s ${(index + 2 - 1).toString()}'),
          ],
        ),
      ),
    );
  }
}
