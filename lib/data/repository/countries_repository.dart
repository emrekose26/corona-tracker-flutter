import 'dart:convert';

import 'package:coronatracker/constants/constants.dart';
import 'package:coronatracker/data/model/countries/countries_model.dart';
import 'package:http/http.dart' as http;

abstract class CountriesRepository {
  Future<CountriesResponse> getCasesByCountry();
}

class CountriesRepositoryImpl extends CountriesRepository {
  @override
  Future<CountriesResponse> getCasesByCountry() async {
    var response = await http.get(Constants.API_URL + Constants.ENDPOINT_COUNTRIES);
    if(response.statusCode == 200) {
      CountriesResponse countriesResponse = CountriesResponse.fromJson(json.decode(response.body));
      return countriesResponse;
    } else {
      throw Exception();
    }
  }
}