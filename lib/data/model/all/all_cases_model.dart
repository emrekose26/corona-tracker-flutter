class AllCasesResponse {
  int cases;
  int deaths;
  int recovered;
  int updated;

  AllCasesResponse({this.cases, this.deaths, this.recovered, this.updated});

  AllCasesResponse.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    recovered = json['recovered'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['recovered'] = this.recovered;
    data['updated'] = this.updated;
    return data;
  }
}