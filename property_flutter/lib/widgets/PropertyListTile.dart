import 'package:flutter/material.dart';
import 'package:property_flutter/data/Model.dart';

class PropertyListTile extends StatelessWidget {
  final Property property;
  final GestureTapCallback onTap;

  PropertyListTile({this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        property.imageUrl,
        height: 50.0,
      ),
      title: Text(property.price),
      subtitle: Text(property.location),
      onTap: onTap,
    );
  }
}