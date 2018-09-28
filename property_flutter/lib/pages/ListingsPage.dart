import 'package:flutter/material.dart';
import 'package:property_flutter/data/DataProvider.dart';
import 'package:property_flutter/data/Model.dart';
import 'package:property_flutter/pages/PropertyDetailsPage.dart';
import 'package:property_flutter/widgets/PropertyListTile.dart';

class ListingsPage extends StatefulWidget {
  final SearchResult searchResult;

  ListingsPage(this.searchResult);

  @override
  State createState() => ListingsPageState();
}

class ListingsPageState extends State<ListingsPage> {
  List<Property> properties;
  int currentPage = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (properties == null) {
      properties = List.from(widget.searchResult.page);
    }

    ListView listView = ListView.builder(
        itemCount: properties.length + 1,
        itemBuilder: (context, index) {
          if (index == properties.length) {
            return buildLoadMoreButton();
          }
          Property property = properties[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: PropertyListTile(
                property: property,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PropertyDetailsPage(property))
                  );
                },
              ),
            ),
          );
        });

    List<Widget> stackChildren;

    if (isLoading) {
      stackChildren = [
        listView,
        ModalBarrier(color: Colors.black.withOpacity(0.5), dismissible: false),
        Center(child: CircularProgressIndicator()),
      ];
    } else {
      stackChildren = [
        listView,
      ];
    }

    return Scaffold(
      appBar:
          AppBar(title: Text('${properties.length} of ${widget.searchResult.numResults} matches')),
      body: Stack(children: stackChildren),
    );
  }

  Widget buildLoadMoreButton() {
    if (properties.length == widget.searchResult.numResults) {
      return Container();
    }

    if (isLoading) {
      return RaisedButton(
        onPressed: null,
        child: Text('Loading...'),
      );
    }

    return RaisedButton(
      onPressed: loadMore,
      child: Text('Load more'),
    );
  }

  void loadMore() async {
    setState(() {
      isLoading = true;
    });

    SearchResult searchResult = await fetchProperties(widget.searchResult.location, ++currentPage);

    setState(() {
      properties.addAll(searchResult.page);
      isLoading = false;
    });
  }
}
