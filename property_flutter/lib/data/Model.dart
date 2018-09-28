class Property {
  String price;
  String location;
  String imageUrl;
  String summary;

  Property(this.price, this.location, this.imageUrl, this.summary);
}

class SearchResult {
  String location;
  int numResults;
  List<Property> page;

  SearchResult(this.location, this.numResults, this.page);
}