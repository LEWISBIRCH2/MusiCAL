class Festival {
  String? name;
  String? location;
  List<String>? artists;
  String? date;
  String? url;
  bool? TBA;

  Festival(
      {this.name, this.location, this.artists, this.date, this.url, this.TBA});

  factory Festival.fromJson(Map<String, dynamic> json) => Festival(
        name: json["name"],
        location: json["location"],
        date: json["date"],
        url: json["url"],
        TBA: json["TBA"],
        artists: json["artists"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "date": date,
        "url": url,
        "TBA": TBA,
        "artists": artists,
      };
}
