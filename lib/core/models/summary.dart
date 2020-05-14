abstract class Summary {
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  Summary(
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
  );

  Map<String, dynamic> toJson();
}

class GlobalSummary extends Summary {
  GlobalSummary({
    newConfirmed,
    totalConfirmed,
    newDeaths,
    totalDeaths,
    newRecovered,
    totalRecovered,
  }) : super(
          newConfirmed,
          totalConfirmed,
          newDeaths,
          totalDeaths,
          newRecovered,
          totalRecovered,
        );

  factory GlobalSummary.fromJson(Map<String, dynamic> json) => GlobalSummary(
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "NewConfirmed": newConfirmed,
        "TotalConfirmed": totalConfirmed,
        "NewDeaths": newDeaths,
        "TotalDeaths": totalDeaths,
        "NewRecovered": newRecovered,
        "TotalRecovered": totalRecovered,
      };
}

class CountrySummary extends Summary {
  String country;
  String countryCode;
  String slug;
  DateTime date;

  CountrySummary({
    this.country,
    this.countryCode,
    this.slug,
    newConfirmed,
    totalConfirmed,
    newDeaths,
    totalDeaths,
    newRecovered,
    totalRecovered,
    this.date,
  }) : super(
          newConfirmed,
          totalConfirmed,
          newDeaths,
          totalDeaths,
          newRecovered,
          totalRecovered,
        );

  String flagImageUrl({int size = 32}) =>
      'https://www.countryflags.io/${countryCode.toLowerCase()}/flat/$size.png';

  factory CountrySummary.fromJson(Map<String, dynamic> json) => CountrySummary(
        country: json["Country"],
        countryCode: json["CountryCode"],
        slug: json["Slug"],
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"],
        date: DateTime.parse(json["Date"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "Country": country,
        "CountryCode": countryCode,
        "Slug": slug,
        "NewConfirmed": newConfirmed,
        "TotalConfirmed": totalConfirmed,
        "NewDeaths": newDeaths,
        "TotalDeaths": totalDeaths,
        "NewRecovered": newRecovered,
        "TotalRecovered": totalRecovered,
        "Date": date.toIso8601String(),
      };
}
