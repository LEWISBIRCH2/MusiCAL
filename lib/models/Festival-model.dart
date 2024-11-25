import 'dart:convert';

Festival festivalFromJson(String str) => Festival.fromJson(json.decode(str));
String festivalToJson(Festival data) => json.encode(data.toJson());

class Festival {
  String? name;
  String? location;
  List<String>? artists;
  String? date;
  String? url;
  int festRec = 0;

  Festival({this.name, this.location, this.artists, this.date, this.url});

  factory Festival.fromJson(Map<String, dynamic> json) => Festival(
        name: json["name"],
        location: json["location"],
        date: json["date"],
        url: json["url"],
        artists: List<String>.from(json["artists"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "date": date,
        "url": url,
        "artists": List<dynamic>.from(artists!.map((x) => x))
      };
}
