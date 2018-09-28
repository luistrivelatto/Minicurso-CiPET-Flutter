import 'package:flutter/material.dart';
import 'package:property_flutter/data/Model.dart';

class PropertyDetailsPage extends StatelessWidget {
  final Property property;

  PropertyDetailsPage(this.property);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Property Details')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            Text(property.price, style: Theme.of(context).textTheme.display1),
            Text(property.location, style: Theme.of(context).textTheme.title),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              width: double.infinity,
              child: Image.network(property.imageUrl, fit: BoxFit.cover),
            ),
            Text(property.summary),
          ],
        ),
      ),
    );
  }
}
