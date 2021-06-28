import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final myImage = FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: 'https://picsum.photos/200?image=$index',
    );
    final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final contentTextStyle = TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [BoxShadow(blurRadius: 10)],
                  image: DecorationImage(
                    image: myImage.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Table(
                columnWidths: {
                  0: FractionColumnWidth(.4),
                  1: FractionColumnWidth(.6),
                },
                children: [
                  TableRow(children: [
                    Text('Name', style: titleTextStyle,),
                    Text('Product $index', style: contentTextStyle,),
                  ]),
                  TableRow(children: [
                    Text('Discount', style: titleTextStyle,),
                    Text('5%', style: contentTextStyle,),
                  ]),
                  TableRow(children: [
                    Text('Validity', style: titleTextStyle,),
                    Text('6 Sept 2021', style: contentTextStyle,),
                  ])
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
