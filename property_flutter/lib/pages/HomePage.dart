import 'package:flutter/material.dart';
import 'package:property_flutter/data/Model.dart';
import 'package:property_flutter/pages/ListingsPage.dart';
import 'package:property_flutter/data/DataProvider.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isSearching = false;
  bool problemWithSearch = false;
  List<SearchResult> recentSearches = [];
  String inputLocation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PropertyFlutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                "Use the form below to search for houses to buy. You can search by place-name, postcode," +
                    " or click 'My location', to search in your current location!"),
            TextField(
              decoration: InputDecoration(hintText: 'Location'),
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                inputLocation = value;
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: performSearch,
                child: Text('Go'),
              ),
            ),
            Container(height: 16.0),
            Expanded(child: _buildBottomWidget()),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomWidget() {
    if(isSearching) {
      return Center(child: CircularProgressIndicator());
    }

    if(problemWithSearch) {
      return Text('There was a problem with your search');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Recent searches:', style: Theme.of(context).textTheme.title),
        Container(height: 8.0),
        Expanded(
          child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: ListView(
              children: recentSearches.map<Widget>((search) {
                return ListTile(
                  title: Text(search.location),
                  trailing: Text('(${search.numResults})'),
                  onTap: () {
                    navigateToListingsPage(search);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void performSearch() async {
    setState(() {
      isSearching = true;
    });
    try {
      SearchResult result = await fetchProperties(inputLocation, 1);
      setState(() {
        isSearching = false;
        problemWithSearch = false;
        updateRecentSearches(result);
      });
      navigateToListingsPage(result);
    } catch(e) {
      setState(() {
        isSearching = false;
        problemWithSearch = true;
      });
    }
  }

  void updateRecentSearches(SearchResult result) {
    int MAX_RECENT_SEARCHES_LENGTH = 5;
    if(recentSearches.length == MAX_RECENT_SEARCHES_LENGTH) {
      recentSearches.removeLast();
    }
    recentSearches.insert(0, result);
  }

  void navigateToListingsPage(SearchResult searchResult) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ListingsPage(searchResult))
    );
  }
}
