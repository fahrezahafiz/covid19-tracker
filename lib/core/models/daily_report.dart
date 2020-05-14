class DailyReport {
  String country;
  String countryCode;
  String lat;
  String lon;
  int cases;
  String status;
  DateTime date;

  DailyReport({
    this.country,
    this.countryCode,
    this.lat,
    this.lon,
    this.cases,
    this.status,
    this.date,
  });

  factory DailyReport.fromJson(Map<String, dynamic> json) => DailyReport(
        country: json["Country"],
        countryCode: json["CountryCode"],
        lat: json["Lat"],
        lon: json["Lon"],
        cases: json["Cases"],
        status: json["Status"],
        date: DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "CountryCode": countryCode,
        "Lat": lat,
        "Lon": lon,
        "Cases": cases,
        "Status": status,
        "Date": date.toIso8601String(),
      };
}
