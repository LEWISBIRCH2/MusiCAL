// To parse this JSON data, do
//
//     final artistsTicketmaster = artistsTicketmasterFromJson(jsonString);

import 'dart:convert';

ArtistsTicketmaster artistsTicketmasterFromJson(String str) =>
    ArtistsTicketmaster.fromJson(json.decode(str));

String artistsTicketmasterToJson(ArtistsTicketmaster data) =>
    json.encode(data.toJson());

class ArtistsTicketmaster {
  Embedded embedded;
  ArtistsTicketmasterLinks links;
  Page page;

  ArtistsTicketmaster({
    required this.embedded,
    required this.links,
    required this.page,
  });

  factory ArtistsTicketmaster.fromJson(Map<String, dynamic> json) =>
      ArtistsTicketmaster(
        embedded: Embedded.fromJson(json["_embedded"]),
        links: ArtistsTicketmasterLinks.fromJson(json["_links"]),
        page: Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "_embedded": embedded.toJson(),
        "_links": links.toJson(),
        "page": page.toJson(),
      };
}

class Embedded {
  List<Attraction> attractions;

  Embedded({
    required this.attractions,
  });

  factory Embedded.fromJson(Map<String, dynamic> json) => Embedded(
        attractions: List<Attraction>.from(
            json["attractions"].map((x) => Attraction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attractions": List<dynamic>.from(attractions.map((x) => x.toJson())),
      };
}

class Attraction {
  String name;
  Type type;
  String id;
  bool test;
  String url;
  Locale locale;
  ExternalLinks? externalLinks;
  List<Image> images;
  List<Classification> classifications;
  Map<String, int> upcomingEvents;
  AttractionLinks links;

  Attraction({
    required this.name,
    required this.type,
    required this.id,
    required this.test,
    required this.url,
    required this.locale,
    this.externalLinks,
    required this.images,
    required this.classifications,
    required this.upcomingEvents,
    required this.links,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        name: json["name"],
        type: typeValues.map[json["type"]]!,
        id: json["id"],
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        externalLinks: json["externalLinks"] == null
            ? null
            : ExternalLinks.fromJson(json["externalLinks"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        classifications: List<Classification>.from(
            json["classifications"].map((x) => Classification.fromJson(x))),
        upcomingEvents: Map.from(json["upcomingEvents"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        links: AttractionLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": typeValues.reverse[type],
        "id": id,
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "externalLinks": externalLinks?.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "classifications":
            List<dynamic>.from(classifications.map((x) => x.toJson())),
        "upcomingEvents": Map.from(upcomingEvents)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links.toJson(),
      };
}

class Classification {
  bool primary;
  Genre segment;
  Genre genre;
  Genre subGenre;
  Genre type;
  Genre subType;
  bool family;

  Classification({
    required this.primary,
    required this.segment,
    required this.genre,
    required this.subGenre,
    required this.type,
    required this.subType,
    required this.family,
  });

  factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        primary: json["primary"],
        segment: Genre.fromJson(json["segment"]),
        genre: Genre.fromJson(json["genre"]),
        subGenre: Genre.fromJson(json["subGenre"]),
        type: Genre.fromJson(json["type"]),
        subType: Genre.fromJson(json["subType"]),
        family: json["family"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "segment": segment.toJson(),
        "genre": genre.toJson(),
        "subGenre": subGenre.toJson(),
        "type": type.toJson(),
        "subType": subType.toJson(),
        "family": family,
      };
}

class Genre {
  String id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ExternalLinks {
  List<Facebook>? youtube;
  List<Facebook>? twitter;
  List<Facebook>? itunes;
  List<Facebook>? facebook;
  List<Facebook>? spotify;
  List<Facebook>? instagram;
  List<Facebook>? homepage;
  List<Facebook>? lastfm;
  List<Facebook>? wiki;
  List<Musicbrainz>? musicbrainz;

  ExternalLinks({
    this.youtube,
    this.twitter,
    this.itunes,
    this.facebook,
    this.spotify,
    this.instagram,
    this.homepage,
    this.lastfm,
    this.wiki,
    this.musicbrainz,
  });

  factory ExternalLinks.fromJson(Map<String, dynamic> json) => ExternalLinks(
        youtube: json["youtube"] == null
            ? []
            : List<Facebook>.from(
                json["youtube"]!.map((x) => Facebook.fromJson(x))),
        twitter: json["twitter"] == null
            ? []
            : List<Facebook>.from(
                json["twitter"]!.map((x) => Facebook.fromJson(x))),
        itunes: json["itunes"] == null
            ? []
            : List<Facebook>.from(
                json["itunes"]!.map((x) => Facebook.fromJson(x))),
        facebook: json["facebook"] == null
            ? []
            : List<Facebook>.from(
                json["facebook"]!.map((x) => Facebook.fromJson(x))),
        spotify: json["spotify"] == null
            ? []
            : List<Facebook>.from(
                json["spotify"]!.map((x) => Facebook.fromJson(x))),
        instagram: json["instagram"] == null
            ? []
            : List<Facebook>.from(
                json["instagram"]!.map((x) => Facebook.fromJson(x))),
        homepage: json["homepage"] == null
            ? []
            : List<Facebook>.from(
                json["homepage"]!.map((x) => Facebook.fromJson(x))),
        lastfm: json["lastfm"] == null
            ? []
            : List<Facebook>.from(
                json["lastfm"]!.map((x) => Facebook.fromJson(x))),
        wiki: json["wiki"] == null
            ? []
            : List<Facebook>.from(
                json["wiki"]!.map((x) => Facebook.fromJson(x))),
        musicbrainz: json["musicbrainz"] == null
            ? []
            : List<Musicbrainz>.from(
                json["musicbrainz"]!.map((x) => Musicbrainz.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "youtube": youtube == null
            ? []
            : List<dynamic>.from(youtube!.map((x) => x.toJson())),
        "twitter": twitter == null
            ? []
            : List<dynamic>.from(twitter!.map((x) => x.toJson())),
        "itunes": itunes == null
            ? []
            : List<dynamic>.from(itunes!.map((x) => x.toJson())),
        "facebook": facebook == null
            ? []
            : List<dynamic>.from(facebook!.map((x) => x.toJson())),
        "spotify": spotify == null
            ? []
            : List<dynamic>.from(spotify!.map((x) => x.toJson())),
        "instagram": instagram == null
            ? []
            : List<dynamic>.from(instagram!.map((x) => x.toJson())),
        "homepage": homepage == null
            ? []
            : List<dynamic>.from(homepage!.map((x) => x.toJson())),
        "lastfm": lastfm == null
            ? []
            : List<dynamic>.from(lastfm!.map((x) => x.toJson())),
        "wiki": wiki == null
            ? []
            : List<dynamic>.from(wiki!.map((x) => x.toJson())),
        "musicbrainz": musicbrainz == null
            ? []
            : List<dynamic>.from(musicbrainz!.map((x) => x.toJson())),
      };
}

class Facebook {
  String url;

  Facebook({
    required this.url,
  });

  factory Facebook.fromJson(Map<String, dynamic> json) => Facebook(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Musicbrainz {
  String id;

  Musicbrainz({
    required this.id,
  });

  factory Musicbrainz.fromJson(Map<String, dynamic> json) => Musicbrainz(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Image {
  Ratio ratio;
  String url;
  int width;
  int height;
  bool fallback;

  Image({
    required this.ratio,
    required this.url,
    required this.width,
    required this.height,
    required this.fallback,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        ratio: ratioValues.map[json["ratio"]]!,
        url: json["url"],
        width: json["width"],
        height: json["height"],
        fallback: json["fallback"],
      );

  Map<String, dynamic> toJson() => {
        "ratio": ratioValues.reverse[ratio],
        "url": url,
        "width": width,
        "height": height,
        "fallback": fallback,
      };
}

enum Ratio { THE_169, THE_32, THE_43 }

final ratioValues = EnumValues(
    {"16_9": Ratio.THE_169, "3_2": Ratio.THE_32, "4_3": Ratio.THE_43});

class AttractionLinks {
  First self;

  AttractionLinks({
    required this.self,
  });

  factory AttractionLinks.fromJson(Map<String, dynamic> json) =>
      AttractionLinks(
        self: First.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
      };
}

class First {
  String href;

  First({
    required this.href,
  });

  factory First.fromJson(Map<String, dynamic> json) => First(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

enum Locale { EN_US }

final localeValues = EnumValues({"en-us": Locale.EN_US});

enum Type { ATTRACTION }

final typeValues = EnumValues({"attraction": Type.ATTRACTION});

class ArtistsTicketmasterLinks {
  First first;
  First self;
  First next;
  First last;

  ArtistsTicketmasterLinks({
    required this.first,
    required this.self,
    required this.next,
    required this.last,
  });

  factory ArtistsTicketmasterLinks.fromJson(Map<String, dynamic> json) =>
      ArtistsTicketmasterLinks(
        first: First.fromJson(json["first"]),
        self: First.fromJson(json["self"]),
        next: First.fromJson(json["next"]),
        last: First.fromJson(json["last"]),
      );

  Map<String, dynamic> toJson() => {
        "first": first.toJson(),
        "self": self.toJson(),
        "next": next.toJson(),
        "last": last.toJson(),
      };
}

class Page {
  int size;
  int totalElements;
  int totalPages;
  int number;

  Page({
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.number,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        size: json["size"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "number": number,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
