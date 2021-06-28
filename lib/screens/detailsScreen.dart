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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: myImage,
                margin: EdgeInsets.all(5.0),
                elevation: 3,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Table(
                  columnWidths: {
                    0: FractionColumnWidth(.2),
                    1: FractionColumnWidth(.3),
                  },
                  children: [
                    TableRow(children: [
                      Text('Name'),
                      Text('Product $index'),
                    ]),
                    TableRow(children: [
                      Text('Discount'),
                      Text('5%'),
                    ]),
                    TableRow(children: [
                      Text('Validity'),
                      Text('6 Sept 2021'),
                    ])
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
