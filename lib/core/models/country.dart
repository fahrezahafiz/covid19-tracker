class Country {
  String country;
  String slug;
  String iso2;

  Country({
    this.country,
    this.slug,
    this.iso2,
  });

  String get flagImageUrl =>
      'https://www.countryflags.io/${iso2.toLowerCase()}/flat/64.png';

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        country: json["Country"],
        slug: json["Slug"],
        iso2: json["ISO2"],
      );

  Map<String, dynamic> toJson() => {
        "Country": country,
        "Slug": slug,
        "ISO2": iso2,
      };
}
