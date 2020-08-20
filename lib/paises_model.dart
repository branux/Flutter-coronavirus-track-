// To parse this JSON data, do
//
//     final paises = paisesFromJson(jsonString);

import 'dart:convert';

List<Paises> paisesFromJson(String str) => List<Paises>.from(json.decode(str).map((x) => Paises.fromJson(x)));

String paisesToJson(List<Paises> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Paises {
  Paises({
    this.country,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.totalTests,
    this.testsPerOneMillion,
  });

  String country;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int totalTests;
  int testsPerOneMillion;

  factory Paises.fromJson(Map<String, dynamic> json) => Paises(
    country: json["country"],
    cases: json["cases"],
    todayCases: json["todayCases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"] == null ? null : json["recovered"],
    active: json["active"] == null ? null : json["active"],
    critical: json["critical"],
    casesPerOneMillion: json["casesPerOneMillion"],
    deathsPerOneMillion: json["deathsPerOneMillion"],
    totalTests: json["totalTests"],
    testsPerOneMillion: json["testsPerOneMillion"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "cases": cases,
    "todayCases": todayCases,
    "deaths": deaths,
    "todayDeaths": todayDeaths,
    "recovered": recovered == null ? null : recovered,
    "active": active == null ? null : active,
    "critical": critical,
    "casesPerOneMillion": casesPerOneMillion,
    "deathsPerOneMillion": deathsPerOneMillion,
    "totalTests": totalTests,
    "testsPerOneMillion": testsPerOneMillion,
  };
}
