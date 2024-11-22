// To parse this JSON data, do
//
//     final userEvents = userEventsFromJson(jsonString);

import 'dart:convert';

UserEvents userEventsFromJson(String str) =>
    UserEvents.fromJson(json.decode(str));

String userEventsToJson(UserEvents data) => json.encode(data.toJson());

class UserEvents {
  UserEventsEmbedded? embedded;
  AttractionLinks? links;
  Page? page;

  UserEvents({
    this.embedded,
    this.links,
    this.page,
  });

  factory UserEvents.fromJson(Map<String, dynamic> json) => UserEvents(
        embedded: json["_embedded"] == null
            ? null
            : UserEventsEmbedded.fromJson(json["_embedded"]),
        links: json["_links"] == null
            ? null
            : AttractionLinks.fromJson(json["_links"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "_embedded": embedded?.toJson(),
        "_links": links?.toJson(),
        "page": page?.toJson(),
      };
}

class UserEventsEmbedded {
  List<_Event>? events;

  UserEventsEmbedded({
    this.events,
  });

  factory UserEventsEmbedded.fromJson(Map<String, dynamic> json) =>
      UserEventsEmbedded(
        events: json["events"] == null
            ? []
            : List<_Event>.from(json["events"]!.map((x) => _Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": events == null
            ? []
            : List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class _Event {
  String? name;
  EventType? type;
  String? id;
  bool? test;
  String? url;
  Locale? locale;
  List<Image>? images;
  Sales? sales;
  Dates? dates;
  List<Classification>? classifications;
  Promoter? promoter;
  List<Promoter>? promoters;
  String? info;
  String? pleaseNote;
  List<PriceRange>? priceRanges;
  Seatmap? seatmap;
  Accessibility? accessibility;
  TicketLimit? ticketLimit;
  AgeRestrictions? ageRestrictions;
  Ticketing? ticketing;
  EventLinks? links;
  EventEmbedded? embedded;
  List<Product>? products;
  List<Outlet>? outlets;
  DoorsTimes? doorsTimes;

  _Event({
    this.name,
    this.type,
    this.id,
    this.test,
    this.url,
    this.locale,
    this.images,
    this.sales,
    this.dates,
    this.classifications,
    this.promoter,
    this.promoters,
    this.info,
    this.pleaseNote,
    this.priceRanges,
    this.seatmap,
    this.accessibility,
    this.ticketLimit,
    this.ageRestrictions,
    this.ticketing,
    this.links,
    this.embedded,
    this.products,
    this.outlets,
    this.doorsTimes,
  });

  factory _Event.fromJson(Map<String, dynamic> json) => _Event(
        name: json["name"],
        type: eventTypeValues.map[json["type"]]!,
        id: json["id"],
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        sales: json["sales"] == null ? null : Sales.fromJson(json["sales"]),
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        classifications: json["classifications"] == null
            ? []
            : List<Classification>.from(json["classifications"]!
                .map((x) => Classification.fromJson(x))),
        promoter: json["promoter"] == null
            ? null
            : Promoter.fromJson(json["promoter"]),
        promoters: json["promoters"] == null
            ? []
            : List<Promoter>.from(
                json["promoters"]!.map((x) => Promoter.fromJson(x))),
        info: json["info"],
        pleaseNote: json["pleaseNote"],
        priceRanges: json["priceRanges"] == null
            ? []
            : List<PriceRange>.from(
                json["priceRanges"]!.map((x) => PriceRange.fromJson(x))),
        seatmap:
            json["seatmap"] == null ? null : Seatmap.fromJson(json["seatmap"]),
        accessibility: json["accessibility"] == null
            ? null
            : Accessibility.fromJson(json["accessibility"]),
        ticketLimit: json["ticketLimit"] == null
            ? null
            : TicketLimit.fromJson(json["ticketLimit"]),
        ageRestrictions: json["ageRestrictions"] == null
            ? null
            : AgeRestrictions.fromJson(json["ageRestrictions"]),
        ticketing: json["ticketing"] == null
            ? null
            : Ticketing.fromJson(json["ticketing"]),
        links:
            json["_links"] == null ? null : EventLinks.fromJson(json["_links"]),
        embedded: json["_embedded"] == null
            ? null
            : EventEmbedded.fromJson(json["_embedded"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        outlets: json["outlets"] == null
            ? []
            : List<Outlet>.from(
                json["outlets"]!.map((x) => Outlet.fromJson(x))),
        doorsTimes: json["doorsTimes"] == null
            ? null
            : DoorsTimes.fromJson(json["doorsTimes"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": eventTypeValues.reverse[type],
        "id": id,
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "sales": sales?.toJson(),
        "dates": dates?.toJson(),
        "classifications": classifications == null
            ? []
            : List<dynamic>.from(classifications!.map((x) => x.toJson())),
        "promoter": promoter?.toJson(),
        "promoters": promoters == null
            ? []
            : List<dynamic>.from(promoters!.map((x) => x.toJson())),
        "info": info,
        "pleaseNote": pleaseNote,
        "priceRanges": priceRanges == null
            ? []
            : List<dynamic>.from(priceRanges!.map((x) => x.toJson())),
        "seatmap": seatmap?.toJson(),
        "accessibility": accessibility?.toJson(),
        "ticketLimit": ticketLimit?.toJson(),
        "ageRestrictions": ageRestrictions?.toJson(),
        "ticketing": ticketing?.toJson(),
        "_links": links?.toJson(),
        "_embedded": embedded?.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "outlets": outlets == null
            ? []
            : List<dynamic>.from(outlets!.map((x) => x.toJson())),
        "doorsTimes": doorsTimes?.toJson(),
      };
}

class Accessibility {
  AccessibilityId? id;
  int? ticketLimit;
  String? info;
  String? url;
  String? urlText;

  Accessibility({
    this.id,
    this.ticketLimit,
    this.info,
    this.url,
    this.urlText,
  });

  factory Accessibility.fromJson(Map<String, dynamic> json) => Accessibility(
        id: accessibilityIdValues.map[json["id"]]!,
        ticketLimit: json["ticketLimit"],
        info: json["info"],
        url: json["url"],
        urlText: json["urlText"],
      );

  Map<String, dynamic> toJson() => {
        "id": accessibilityIdValues.reverse[id],
        "ticketLimit": ticketLimit,
        "info": info,
        "url": url,
        "urlText": urlText,
      };
}

enum AccessibilityId { ACCESSIBILITY }

final accessibilityIdValues =
    EnumValues({"accessibility": AccessibilityId.ACCESSIBILITY});

class AgeRestrictions {
  bool? legalAgeEnforced;
  AgeRestrictionsId? id;

  AgeRestrictions({
    this.legalAgeEnforced,
    this.id,
  });

  factory AgeRestrictions.fromJson(Map<String, dynamic> json) =>
      AgeRestrictions(
        legalAgeEnforced: json["legalAgeEnforced"],
        id: ageRestrictionsIdValues.map[json["id"]]!,
      );

  Map<String, dynamic> toJson() => {
        "legalAgeEnforced": legalAgeEnforced,
        "id": ageRestrictionsIdValues.reverse[id],
      };
}

enum AgeRestrictionsId { AGE_RESTRICTIONS }

final ageRestrictionsIdValues =
    EnumValues({"ageRestrictions": AgeRestrictionsId.AGE_RESTRICTIONS});

class Classification {
  bool? primary;
  Genre? segment;
  Genre? genre;
  Genre? subGenre;
  Genre? type;
  Genre? subType;
  bool? family;

  Classification({
    this.primary,
    this.segment,
    this.genre,
    this.subGenre,
    this.type,
    this.subType,
    this.family,
  });

  factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        primary: json["primary"],
        segment:
            json["segment"] == null ? null : Genre.fromJson(json["segment"]),
        genre: json["genre"] == null ? null : Genre.fromJson(json["genre"]),
        subGenre:
            json["subGenre"] == null ? null : Genre.fromJson(json["subGenre"]),
        type: json["type"] == null ? null : Genre.fromJson(json["type"]),
        subType:
            json["subType"] == null ? null : Genre.fromJson(json["subType"]),
        family: json["family"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "segment": segment?.toJson(),
        "genre": genre?.toJson(),
        "subGenre": subGenre?.toJson(),
        "type": type?.toJson(),
        "subType": subType?.toJson(),
        "family": family,
      };
}

class Genre {
  String? id;
  String? name;

  Genre({
    this.id,
    this.name,
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

class Dates {
  Start? start;
  String? timezone;
  Status? status;
  bool? spanMultipleDays;

  Dates({
    this.start,
    this.timezone,
    this.status,
    this.spanMultipleDays,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        start: json["start"] == null ? null : Start.fromJson(json["start"]),
        timezone: json["timezone"],
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        spanMultipleDays: json["spanMultipleDays"],
      );

  Map<String, dynamic> toJson() => {
        "start": start?.toJson(),
        "timezone": timezone,
        "status": status?.toJson(),
        "spanMultipleDays": spanMultipleDays,
      };
}

class Start {
  DateTime? localDate;
  String? localTime;
  DateTime? dateTime;
  bool? dateTbd;
  bool? dateTba;
  bool? timeTba;
  bool? noSpecificTime;

  Start({
    this.localDate,
    this.localTime,
    this.dateTime,
    this.dateTbd,
    this.dateTba,
    this.timeTba,
    this.noSpecificTime,
  });

  factory Start.fromJson(Map<String, dynamic> json) => Start(
        localDate: json["localDate"] == null
            ? null
            : DateTime.parse(json["localDate"]),
        localTime: json["localTime"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        dateTbd: json["dateTBD"],
        dateTba: json["dateTBA"],
        timeTba: json["timeTBA"],
        noSpecificTime: json["noSpecificTime"],
      );

  Map<String, dynamic> toJson() => {
        "localDate":
            "${localDate!.year.toString().padLeft(4, '0')}-${localDate!.month.toString().padLeft(2, '0')}-${localDate!.day.toString().padLeft(2, '0')}",
        "localTime": localTime,
        "dateTime": dateTime?.toIso8601String(),
        "dateTBD": dateTbd,
        "dateTBA": dateTba,
        "timeTBA": timeTba,
        "noSpecificTime": noSpecificTime,
      };
}

class Status {
  Code? code;

  Status({
    this.code,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: codeValues.map[json["code"]]!,
      );

  Map<String, dynamic> toJson() => {
        "code": codeValues.reverse[code],
      };
}

enum Code { ONSALE }

final codeValues = EnumValues({"onsale": Code.ONSALE});

class DoorsTimes {
  DateTime? localDate;
  String? localTime;
  DateTime? dateTime;
  String? id;

  DoorsTimes({
    this.localDate,
    this.localTime,
    this.dateTime,
    this.id,
  });

  factory DoorsTimes.fromJson(Map<String, dynamic> json) => DoorsTimes(
        localDate: json["localDate"] == null
            ? null
            : DateTime.parse(json["localDate"]),
        localTime: json["localTime"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "localDate":
            "${localDate!.year.toString().padLeft(4, '0')}-${localDate!.month.toString().padLeft(2, '0')}-${localDate!.day.toString().padLeft(2, '0')}",
        "localTime": localTime,
        "dateTime": dateTime?.toIso8601String(),
        "id": id,
      };
}

class EventEmbedded {
  List<Venue>? venues;
  List<Attraction>? attractions;

  EventEmbedded({
    this.venues,
    this.attractions,
  });

  factory EventEmbedded.fromJson(Map<String, dynamic> json) => EventEmbedded(
        venues: json["venues"] == null
            ? []
            : List<Venue>.from(json["venues"]!.map((x) => Venue.fromJson(x))),
        attractions: json["attractions"] == null
            ? []
            : List<Attraction>.from(
                json["attractions"]!.map((x) => Attraction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venues": venues == null
            ? []
            : List<dynamic>.from(venues!.map((x) => x.toJson())),
        "attractions": attractions == null
            ? []
            : List<dynamic>.from(attractions!.map((x) => x.toJson())),
      };
}

class Attraction {
  String? name;
  AttractionType? type;
  String? id;
  bool? test;
  String? url;
  Locale? locale;
  ExternalLinks? externalLinks;
  List<Image>? images;
  List<Classification>? classifications;
  Map<String, int>? upcomingEvents;
  AttractionLinks? links;
  List<String>? aliases;

  Attraction({
    this.name,
    this.type,
    this.id,
    this.test,
    this.url,
    this.locale,
    this.externalLinks,
    this.images,
    this.classifications,
    this.upcomingEvents,
    this.links,
    this.aliases,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        name: json["name"],
        type: attractionTypeValues.map[json["type"]]!,
        id: json["id"],
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        externalLinks: json["externalLinks"] == null
            ? null
            : ExternalLinks.fromJson(json["externalLinks"]),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        classifications: json["classifications"] == null
            ? []
            : List<Classification>.from(json["classifications"]!
                .map((x) => Classification.fromJson(x))),
        upcomingEvents: Map.from(json["upcomingEvents"]!)
            .map((k, v) => MapEntry<String, int>(k, v)),
        links: json["_links"] == null
            ? null
            : AttractionLinks.fromJson(json["_links"]),
        aliases: json["aliases"] == null
            ? []
            : List<String>.from(json["aliases"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": attractionTypeValues.reverse[type],
        "id": id,
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "externalLinks": externalLinks?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "classifications": classifications == null
            ? []
            : List<dynamic>.from(classifications!.map((x) => x.toJson())),
        "upcomingEvents": Map.from(upcomingEvents!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links?.toJson(),
        "aliases":
            aliases == null ? [] : List<dynamic>.from(aliases!.map((x) => x)),
      };
}

class ExternalLinks {
  List<Facebook>? youtube;
  List<Facebook>? twitter;
  List<Facebook>? itunes;
  List<Facebook>? lastfm;
  List<Facebook>? spotify;
  List<Facebook>? wiki;
  List<Facebook>? facebook;
  List<Musicbrainz>? musicbrainz;
  List<Facebook>? instagram;
  List<Facebook>? homepage;

  ExternalLinks({
    this.youtube,
    this.twitter,
    this.itunes,
    this.lastfm,
    this.spotify,
    this.wiki,
    this.facebook,
    this.musicbrainz,
    this.instagram,
    this.homepage,
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
        lastfm: json["lastfm"] == null
            ? []
            : List<Facebook>.from(
                json["lastfm"]!.map((x) => Facebook.fromJson(x))),
        spotify: json["spotify"] == null
            ? []
            : List<Facebook>.from(
                json["spotify"]!.map((x) => Facebook.fromJson(x))),
        wiki: json["wiki"] == null
            ? []
            : List<Facebook>.from(
                json["wiki"]!.map((x) => Facebook.fromJson(x))),
        facebook: json["facebook"] == null
            ? []
            : List<Facebook>.from(
                json["facebook"]!.map((x) => Facebook.fromJson(x))),
        musicbrainz: json["musicbrainz"] == null
            ? []
            : List<Musicbrainz>.from(
                json["musicbrainz"]!.map((x) => Musicbrainz.fromJson(x))),
        instagram: json["instagram"] == null
            ? []
            : List<Facebook>.from(
                json["instagram"]!.map((x) => Facebook.fromJson(x))),
        homepage: json["homepage"] == null
            ? []
            : List<Facebook>.from(
                json["homepage"]!.map((x) => Facebook.fromJson(x))),
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
        "lastfm": lastfm == null
            ? []
            : List<dynamic>.from(lastfm!.map((x) => x.toJson())),
        "spotify": spotify == null
            ? []
            : List<dynamic>.from(spotify!.map((x) => x.toJson())),
        "wiki": wiki == null
            ? []
            : List<dynamic>.from(wiki!.map((x) => x.toJson())),
        "facebook": facebook == null
            ? []
            : List<dynamic>.from(facebook!.map((x) => x.toJson())),
        "musicbrainz": musicbrainz == null
            ? []
            : List<dynamic>.from(musicbrainz!.map((x) => x.toJson())),
        "instagram": instagram == null
            ? []
            : List<dynamic>.from(instagram!.map((x) => x.toJson())),
        "homepage": homepage == null
            ? []
            : List<dynamic>.from(homepage!.map((x) => x.toJson())),
      };
}

class Facebook {
  String? url;

  Facebook({
    this.url,
  });

  factory Facebook.fromJson(Map<String, dynamic> json) => Facebook(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Musicbrainz {
  String? id;
  String? url;

  Musicbrainz({
    this.id,
    this.url,
  });

  factory Musicbrainz.fromJson(Map<String, dynamic> json) => Musicbrainz(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class Image {
  Ratio? ratio;
  String? url;
  int? width;
  int? height;
  bool? fallback;
  Attribution? attribution;

  Image({
    this.ratio,
    this.url,
    this.width,
    this.height,
    this.fallback,
    this.attribution,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        ratio: ratioValues.map[json["ratio"]]!,
        url: json["url"],
        width: json["width"],
        height: json["height"],
        fallback: json["fallback"],
        attribution: attributionValues.map[json["attribution"]]!,
      );

  Map<String, dynamic> toJson() => {
        "ratio": ratioValues.reverse[ratio],
        "url": url,
        "width": width,
        "height": height,
        "fallback": fallback,
        "attribution": attributionValues.reverse[attribution],
      };
}

enum Attribution { CDD_APPROVAL_GEOFF_CARNS }

final attributionValues = EnumValues(
    {"cdd approval Geoff Carns": Attribution.CDD_APPROVAL_GEOFF_CARNS});

enum Ratio { THE_169, THE_32, THE_43 }

final ratioValues = EnumValues(
    {"16_9": Ratio.THE_169, "3_2": Ratio.THE_32, "4_3": Ratio.THE_43});

class AttractionLinks {
  Self? self;

  AttractionLinks({
    this.self,
  });

  factory AttractionLinks.fromJson(Map<String, dynamic> json) =>
      AttractionLinks(
        self: json["self"] == null ? null : Self.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self?.toJson(),
      };
}

class Self {
  String? href;

  Self({
    this.href,
  });

  factory Self.fromJson(Map<String, dynamic> json) => Self(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

enum Locale { EN_DE, EN_US }

final localeValues = EnumValues({"en-de": Locale.EN_DE, "en-us": Locale.EN_US});

enum AttractionType { ATTRACTION }

final attractionTypeValues =
    EnumValues({"attraction": AttractionType.ATTRACTION});

class Venue {
  String? name;
  VenueType? type;
  String? id;
  bool? test;
  String? url;
  Locale? locale;
  List<Image>? images;
  String? postalCode;
  String? timezone;
  City? city;
  Country? country;
  Address? address;
  Location? location;
  List<Genre>? markets;
  List<Dma>? dmas;
  BoxOfficeInfo? boxOfficeInfo;
  String? parkingDetail;
  String? accessibleSeatingDetail;
  GeneralInfo? generalInfo;
  Map<String, int>? upcomingEvents;
  Ada? ada;
  AttractionLinks? links;
  Social? social;
  CityState? state;
  List<String>? aliases;

  Venue({
    this.name,
    this.type,
    this.id,
    this.test,
    this.url,
    this.locale,
    this.images,
    this.postalCode,
    this.timezone,
    this.city,
    this.country,
    this.address,
    this.location,
    this.markets,
    this.dmas,
    this.boxOfficeInfo,
    this.parkingDetail,
    this.accessibleSeatingDetail,
    this.generalInfo,
    this.upcomingEvents,
    this.ada,
    this.links,
    this.social,
    this.state,
    this.aliases,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        type: venueTypeValues.map[json["type"]]!,
        id: json["id"],
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        postalCode: json["postalCode"],
        timezone: json["timezone"],
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        markets: json["markets"] == null
            ? []
            : List<Genre>.from(json["markets"]!.map((x) => Genre.fromJson(x))),
        dmas: json["dmas"] == null
            ? []
            : List<Dma>.from(json["dmas"]!.map((x) => Dma.fromJson(x))),
        boxOfficeInfo: json["boxOfficeInfo"] == null
            ? null
            : BoxOfficeInfo.fromJson(json["boxOfficeInfo"]),
        parkingDetail: json["parkingDetail"],
        accessibleSeatingDetail: json["accessibleSeatingDetail"],
        generalInfo: json["generalInfo"] == null
            ? null
            : GeneralInfo.fromJson(json["generalInfo"]),
        upcomingEvents: Map.from(json["upcomingEvents"]!)
            .map((k, v) => MapEntry<String, int>(k, v)),
        ada: json["ada"] == null ? null : Ada.fromJson(json["ada"]),
        links: json["_links"] == null
            ? null
            : AttractionLinks.fromJson(json["_links"]),
        social: json["social"] == null ? null : Social.fromJson(json["social"]),
        state: json["state"] == null ? null : CityState.fromJson(json["state"]),
        aliases: json["aliases"] == null
            ? []
            : List<String>.from(json["aliases"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": venueTypeValues.reverse[type],
        "id": id,
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "postalCode": postalCode,
        "timezone": timezone,
        "city": city?.toJson(),
        "country": country?.toJson(),
        "address": address?.toJson(),
        "location": location?.toJson(),
        "markets": markets == null
            ? []
            : List<dynamic>.from(markets!.map((x) => x.toJson())),
        "dmas": dmas == null
            ? []
            : List<dynamic>.from(dmas!.map((x) => x.toJson())),
        "boxOfficeInfo": boxOfficeInfo?.toJson(),
        "parkingDetail": parkingDetail,
        "accessibleSeatingDetail": accessibleSeatingDetail,
        "generalInfo": generalInfo?.toJson(),
        "upcomingEvents": Map.from(upcomingEvents!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "ada": ada?.toJson(),
        "_links": links?.toJson(),
        "social": social?.toJson(),
        "state": state?.toJson(),
        "aliases":
            aliases == null ? [] : List<dynamic>.from(aliases!.map((x) => x)),
      };
}

class Ada {
  String? adaPhones;
  String? adaCustomCopy;
  String? adaHours;

  Ada({
    this.adaPhones,
    this.adaCustomCopy,
    this.adaHours,
  });

  factory Ada.fromJson(Map<String, dynamic> json) => Ada(
        adaPhones: json["adaPhones"],
        adaCustomCopy: json["adaCustomCopy"],
        adaHours: json["adaHours"],
      );

  Map<String, dynamic> toJson() => {
        "adaPhones": adaPhones,
        "adaCustomCopy": adaCustomCopy,
        "adaHours": adaHours,
      };
}

class Address {
  String? line1;
  String? line2;

  Address({
    this.line1,
    this.line2,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
        line2: json["line2"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
      };
}

class BoxOfficeInfo {
  String? phoneNumberDetail;
  String? openHoursDetail;
  String? willCallDetail;
  String? acceptedPaymentDetail;

  BoxOfficeInfo({
    this.phoneNumberDetail,
    this.openHoursDetail,
    this.willCallDetail,
    this.acceptedPaymentDetail,
  });

  factory BoxOfficeInfo.fromJson(Map<String, dynamic> json) => BoxOfficeInfo(
        phoneNumberDetail: json["phoneNumberDetail"],
        openHoursDetail: json["openHoursDetail"],
        willCallDetail: json["willCallDetail"],
        acceptedPaymentDetail: json["acceptedPaymentDetail"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumberDetail": phoneNumberDetail,
        "openHoursDetail": openHoursDetail,
        "willCallDetail": willCallDetail,
        "acceptedPaymentDetail": acceptedPaymentDetail,
      };
}

class City {
  String? name;

  City({
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Country {
  String? name;
  String? countryCode;

  Country({
    this.name,
    this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "countryCode": countryCode,
      };
}

class Dma {
  int? id;

  Dma({
    this.id,
  });

  factory Dma.fromJson(Map<String, dynamic> json) => Dma(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class GeneralInfo {
  String? generalRule;
  String? childRule;

  GeneralInfo({
    this.generalRule,
    this.childRule,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) => GeneralInfo(
        generalRule: json["generalRule"],
        childRule: json["childRule"],
      );

  Map<String, dynamic> toJson() => {
        "generalRule": generalRule,
        "childRule": childRule,
      };
}

class Location {
  String? longitude;
  String? latitude;

  Location({
    this.longitude,
    this.latitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}

class Social {
  Twitter? twitter;

  Social({
    this.twitter,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        twitter:
            json["twitter"] == null ? null : Twitter.fromJson(json["twitter"]),
      );

  Map<String, dynamic> toJson() => {
        "twitter": twitter?.toJson(),
      };
}

class Twitter {
  String? handle;

  Twitter({
    this.handle,
  });

  factory Twitter.fromJson(Map<String, dynamic> json) => Twitter(
        handle: json["handle"],
      );

  Map<String, dynamic> toJson() => {
        "handle": handle,
      };
}

class CityState {
  String? name;
  String? stateCode;

  CityState({
    this.name,
    this.stateCode,
  });

  factory CityState.fromJson(Map<String, dynamic> json) => CityState(
        name: json["name"],
        stateCode: json["stateCode"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "stateCode": stateCode,
      };
}

enum VenueType { VENUE }

final venueTypeValues = EnumValues({"venue": VenueType.VENUE});

class EventLinks {
  Self? self;
  List<Self>? attractions;
  List<Self>? venues;

  EventLinks({
    this.self,
    this.attractions,
    this.venues,
  });

  factory EventLinks.fromJson(Map<String, dynamic> json) => EventLinks(
        self: json["self"] == null ? null : Self.fromJson(json["self"]),
        attractions: json["attractions"] == null
            ? []
            : List<Self>.from(
                json["attractions"]!.map((x) => Self.fromJson(x))),
        venues: json["venues"] == null
            ? []
            : List<Self>.from(json["venues"]!.map((x) => Self.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self?.toJson(),
        "attractions": attractions == null
            ? []
            : List<dynamic>.from(attractions!.map((x) => x.toJson())),
        "venues": venues == null
            ? []
            : List<dynamic>.from(venues!.map((x) => x.toJson())),
      };
}

class Outlet {
  String? url;
  String? type;

  Outlet({
    this.url,
    this.type,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) => Outlet(
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "type": type,
      };
}

class PriceRange {
  PriceRangeType? type;
  Currency? currency;
  double? min;
  double? max;

  PriceRange({
    this.type,
    this.currency,
    this.min,
    this.max,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) => PriceRange(
        type: priceRangeTypeValues.map[json["type"]]!,
        currency: currencyValues.map[json["currency"]]!,
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": priceRangeTypeValues.reverse[type],
        "currency": currencyValues.reverse[currency],
        "min": min,
        "max": max,
      };
}

enum Currency { CAD, EUR, GBP, USD }

final currencyValues = EnumValues({
  "CAD": Currency.CAD,
  "EUR": Currency.EUR,
  "GBP": Currency.GBP,
  "USD": Currency.USD
});

enum PriceRangeType { STANDARD, STANDARD_INCLUDING_FEES }

final priceRangeTypeValues = EnumValues({
  "standard": PriceRangeType.STANDARD,
  "standard including fees": PriceRangeType.STANDARD_INCLUDING_FEES
});

class Product {
  String? name;
  String? id;
  String? url;
  String? type;
  List<Classification>? classifications;

  Product({
    this.name,
    this.id,
    this.url,
    this.type,
    this.classifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        id: json["id"],
        url: json["url"],
        type: json["type"],
        classifications: json["classifications"] == null
            ? []
            : List<Classification>.from(json["classifications"]!
                .map((x) => Classification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "url": url,
        "type": type,
        "classifications": classifications == null
            ? []
            : List<dynamic>.from(classifications!.map((x) => x.toJson())),
      };
}

class Promoter {
  String? id;
  String? name;
  String? description;

  Promoter({
    this.id,
    this.name,
    this.description,
  });

  factory Promoter.fromJson(Map<String, dynamic> json) => Promoter(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class Sales {
  Public? public;
  List<Presale>? presales;

  Sales({
    this.public,
    this.presales,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        public: json["public"] == null ? null : Public.fromJson(json["public"]),
        presales: json["presales"] == null
            ? []
            : List<Presale>.from(
                json["presales"]!.map((x) => Presale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "public": public?.toJson(),
        "presales": presales == null
            ? []
            : List<dynamic>.from(presales!.map((x) => x.toJson())),
      };
}

class Presale {
  DateTime? startDateTime;
  DateTime? endDateTime;
  String? name;

  Presale({
    this.startDateTime,
    this.endDateTime,
    this.name,
  });

  factory Presale.fromJson(Map<String, dynamic> json) => Presale(
        startDateTime: json["startDateTime"] == null
            ? null
            : DateTime.parse(json["startDateTime"]),
        endDateTime: json["endDateTime"] == null
            ? null
            : DateTime.parse(json["endDateTime"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "startDateTime": startDateTime?.toIso8601String(),
        "endDateTime": endDateTime?.toIso8601String(),
        "name": name,
      };
}

class Public {
  DateTime? startDateTime;
  bool? startTbd;
  bool? startTba;
  DateTime? endDateTime;

  Public({
    this.startDateTime,
    this.startTbd,
    this.startTba,
    this.endDateTime,
  });

  factory Public.fromJson(Map<String, dynamic> json) => Public(
        startDateTime: json["startDateTime"] == null
            ? null
            : DateTime.parse(json["startDateTime"]),
        startTbd: json["startTBD"],
        startTba: json["startTBA"],
        endDateTime: json["endDateTime"] == null
            ? null
            : DateTime.parse(json["endDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "startDateTime": startDateTime?.toIso8601String(),
        "startTBD": startTbd,
        "startTBA": startTba,
        "endDateTime": endDateTime?.toIso8601String(),
      };
}

class Seatmap {
  String? staticUrl;
  SeatmapId? id;

  Seatmap({
    this.staticUrl,
    this.id,
  });

  factory Seatmap.fromJson(Map<String, dynamic> json) => Seatmap(
        staticUrl: json["staticUrl"],
        id: seatmapIdValues.map[json["id"]]!,
      );

  Map<String, dynamic> toJson() => {
        "staticUrl": staticUrl,
        "id": seatmapIdValues.reverse[id],
      };
}

enum SeatmapId { SEATMAP }

final seatmapIdValues = EnumValues({"seatmap": SeatmapId.SEATMAP});

class TicketLimit {
  String? info;
  TicketLimitId? id;

  TicketLimit({
    this.info,
    this.id,
  });

  factory TicketLimit.fromJson(Map<String, dynamic> json) => TicketLimit(
        info: json["info"],
        id: ticketLimitIdValues.map[json["id"]]!,
      );

  Map<String, dynamic> toJson() => {
        "info": info,
        "id": ticketLimitIdValues.reverse[id],
      };
}

enum TicketLimitId { TICKET_LIMIT }

final ticketLimitIdValues =
    EnumValues({"ticketLimit": TicketLimitId.TICKET_LIMIT});

class Ticketing {
  SafeTix? safeTix;
  AllInclusivePricing? allInclusivePricing;
  TicketingId? id;

  Ticketing({
    this.safeTix,
    this.allInclusivePricing,
    this.id,
  });

  factory Ticketing.fromJson(Map<String, dynamic> json) => Ticketing(
        safeTix:
            json["safeTix"] == null ? null : SafeTix.fromJson(json["safeTix"]),
        allInclusivePricing: json["allInclusivePricing"] == null
            ? null
            : AllInclusivePricing.fromJson(json["allInclusivePricing"]),
        id: ticketingIdValues.map[json["id"]]!,
      );

  Map<String, dynamic> toJson() => {
        "safeTix": safeTix?.toJson(),
        "allInclusivePricing": allInclusivePricing?.toJson(),
        "id": ticketingIdValues.reverse[id],
      };
}

class AllInclusivePricing {
  bool? enabled;

  AllInclusivePricing({
    this.enabled,
  });

  factory AllInclusivePricing.fromJson(Map<String, dynamic> json) =>
      AllInclusivePricing(
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}

enum TicketingId { TICKETING }

final ticketingIdValues = EnumValues({"ticketing": TicketingId.TICKETING});

class SafeTix {
  bool? enabled;
  bool? inAppOnlyEnabled;

  SafeTix({
    this.enabled,
    this.inAppOnlyEnabled,
  });

  factory SafeTix.fromJson(Map<String, dynamic> json) => SafeTix(
        enabled: json["enabled"],
        inAppOnlyEnabled: json["inAppOnlyEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "inAppOnlyEnabled": inAppOnlyEnabled,
      };
}

enum EventType { EVENT }

final eventTypeValues = EnumValues({"event": EventType.EVENT});

class Page {
  int? size;
  int? totalElements;
  int? totalPages;
  int? number;

  Page({
    this.size,
    this.totalElements,
    this.totalPages,
    this.number,
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
