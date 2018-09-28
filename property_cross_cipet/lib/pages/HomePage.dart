import 'package:flutter/material.dart';
import 'package:property_cross_cipet/pages/ListingsPage.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String inputLocation = '';
  List<String> recentSearches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PropertyFlutter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Use the form below to search for houses to buy. You can search by place-name, postcode, or click 'My location', to search in your current location!"),
            TextField(
              decoration: InputDecoration(hintText: 'Location'),
              onChanged: onInputLocationChanged,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    recentSearches.insert(0, inputLocation);
                  });

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ListingsPage())
                  );

                  // TODO: procurar imoveis
                },
                child: Text('Go'),
              ),
            ),
            Container(height: 20.0),
            Text("Recent Searches:", style: Theme.of(context).textTheme.title),
            Container(height: 8.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: ListView.builder(
                  itemCount: recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recentSearches[index]),
                      trailing: Text('(123)'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onInputLocationChanged(String value) {
    inputLocation = value;
  }
}
