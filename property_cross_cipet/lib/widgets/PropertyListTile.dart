import 'package:flutter/material.dart';
import 'package:property_cross_cipet/data/Property.dart';

class PropertyListTile extends StatelessWidget {
  final Property property;

  PropertyListTile(this.property);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: ListTile(
          leading: Image.network(
            property.imageUrl,
            height: 50.0,
            width: 80.0,
          ),
          title: Text(property.price),
          subtitle: Text(property.location),
        ),
      ),
    );
  }
}