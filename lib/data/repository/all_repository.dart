import 'dart:convert';

import 'package:coronatracker/constants/constants.dart';
import 'package:coronatracker/data/model/all/all_cases_model.dart';
import 'package:http/http.dart' as http;

abstract class AllRepository {
  Future<AllCasesResponse> getAllCases();
}

class AllRepositoryImpl extends AllRepository {
  @override
  Future<AllCasesResponse> getAllCases() async {
    var response = await http.get(Constants.API_URL + Constants.ENDPOINT_ALL);
    if (response.statusCode == 200) {
      AllCasesResponse allCasesResponse = AllCasesResponse.fromJson(json.decode(response.body));
      return allCasesResponse;
    } else {
      throw Exception();
    }
  }
}
