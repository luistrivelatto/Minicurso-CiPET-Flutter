import 'dart:async';
import 'dart:convert';

import 'package:property_flutter/data/Model.dart';
import 'package:http/http.dart' as http;

Future<SearchResult> fetchProperties(String location, int page) async {
  String requestUrl = 'http://api.nestoria.co.uk/api?country=uk&pretty=1&action=search_listings&encoding=json&listing_type=buy&page=${page}&place_name=${location}';
  http.Response response = await http.get(requestUrl);

  if(response.statusCode != 200) {
    print('Request retornou ${response.statusCode}');
    return Future.error(null);
  }

  Map<String, dynamic> responseJson = json.decode(response.body);
  int apiStatusCode = int.parse(responseJson['response']['application_response_code']);
  const apiOkCodes = [100, 101, 110];

  if(!apiOkCodes.contains(apiStatusCode)) {
    print('API retornou ${apiStatusCode}');
    return Future.error(null);
  }

  int numResults = responseJson['response']['total_results'];
  List<Property> properties = [];

  for(Map propertyJson in responseJson['response']['listings']) {
    String price = propertyJson['price_formatted'];
    String location = propertyJson['title'];
    String imageUrl = propertyJson['img_url'];
    String summary = propertyJson['summary'];

    properties.add(new Property(price, location, imageUrl, summary));
  }


  return new SearchResult(location, numResults, properties);
}
