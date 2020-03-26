class CountriesResponse {
  final List<Country> countryList;
  CountriesResponse({this.countryList});

  factory CountriesResponse.fromJson(List<dynamic> parsedJson) {
    List<Country> countryList = new List<Country>();
    countryList = parsedJson.map((i) => Country.fromJson(i)).toList();

    return new CountriesResponse(
      countryList: countryList
    );
  }
}
class Country {
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;

  Country(
      {this.country,
        this.countryInfo,
        this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.active,
        this.critical,
        this.casesPerOneMillion,
        this.deathsPerOneMillion});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    country: json["country"],
    countryInfo: CountryInfo.fromJson(json["countryInfo"]),
    cases: json["cases"],
    todayCases: json["todayCases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"],
    active: json["active"],
    critical: json["critical"],
    casesPerOneMillion: json["casesPerOneMillion"] == null ? null : json["casesPerOneMillion"].toDouble(),
    deathsPerOneMillion: json["deathsPerOneMillion"] == null ? null : json["deathsPerOneMillion"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "countryInfo": countryInfo.toJson(),
    "cases": cases,
    "todayCases": todayCases,
    "deaths": deaths,
    "todayDeaths": todayDeaths,
    "recovered": recovered,
    "active": active,
    "critical": critical,
    "casesPerOneMillion": casesPerOneMillion == null ? null : casesPerOneMillion,
    "deathsPerOneMillion": deathsPerOneMillion == null ? null : deathsPerOneMillion,
  };
}

class CountryInfo {

  String flag;
  CountryInfo({this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flag'] = this.flag;
    return data;
  }
}