import 'package:flutter/material.dart';
import 'package:property_cross_cipet/data/Property.dart';
import 'package:property_cross_cipet/widgets/PropertyListTile.dart';

class ListingsPage extends StatefulWidget {
  @override
  State createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {
  List<Property> properties = [
    Property(
        '\$1,000,000',
        'Unioeste - Cascavel',
        'http://s2.glbimg.com/gaeGBSd6L5sUezvt01HuNH97Lx8=/300x225/s.glbimg.com/jo/g1/f/original/2014/04/04/unioeste.jpg',
        'Universidade aconchegante'),
    Property(
        '\$50,000',
        'Unioeste - Toledo',
        'https://cdn.massanews.com/uploads/noticias/lg-2a069343-3d9d-472b-997d-470244cf0b16.jpg',
        'Universidade menor'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listings')),
      body: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (context, index) {
          Property property = properties[index];
          return PropertyListTile(property);
        },
      ),
    );
  }
}
