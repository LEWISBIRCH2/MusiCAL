// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  EventsEmbedded embedded;
  EventsLinks links;
  Page page;

  Events({
    required this.embedded,
    required this.links,
    required this.page,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        embedded: EventsEmbedded.fromJson(json["_embedded"]),
        links: EventsLinks.fromJson(json["_links"]),
        page: Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "_embedded": embedded.toJson(),
        "_links": links.toJson(),
        "page": page.toJson(),
      };
}

class EventsEmbedded {
  List<Event> events;

  EventsEmbedded({
    required this.events,
  });

  factory EventsEmbedded.fromJson(Map<String, dynamic> json) => EventsEmbedded(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  EventName name;
  EventType type;
  String id;
  bool test;
  String url;
  Locale locale;
  List<Image> images;
  Sales sales;
  Dates dates;
  List<Classification>? classifications;
  Promoter? promoter;
  List<Promoter>? promoters;
  String? pleaseNote;
  List<PriceRange>? priceRanges;
  Seatmap? seatmap;
  Accessibility? accessibility;
  TicketLimit? ticketLimit;
  AgeRestrictions? ageRestrictions;
  Ticketing? ticketing;
  EventLinks links;
  EventEmbedded? embedded;
  DoorsTimes? doorsTimes;
  List<Product>? products;
  Info? info;
  String? description;
  Place? place;

  Event({
    required this.name,
    required this.type,
    required this.id,
    required this.test,
    required this.url,
    required this.locale,
    required this.images,
    required this.sales,
    required this.dates,
    this.classifications,
    this.promoter,
    this.promoters,
    this.pleaseNote,
    this.priceRanges,
    this.seatmap,
    this.accessibility,
    this.ticketLimit,
    this.ageRestrictions,
    this.ticketing,
    required this.links,
    this.embedded,
    this.doorsTimes,
    this.products,
    this.info,
    this.description,
    this.place,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        name: eventNameValues.map[json["name"]]!,
        type: eventTypeValues.map[json["type"]]!,
        id: json["id"],
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        sales: Sales.fromJson(json["sales"]),
        dates: Dates.fromJson(json["dates"]),
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
        links: EventLinks.fromJson(json["_links"]),
        embedded: json["_embedded"] == null
            ? null
            : EventEmbedded.fromJson(json["_embedded"]),
        doorsTimes: json["doorsTimes"] == null
            ? null
            : DoorsTimes.fromJson(json["doorsTimes"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        info: infoValues.map[json["info"]]!,
        description: json["description"],
        place: json["place"] == null ? null : Place.fromJson(json["place"]),
      );

  Map<String, dynamic> toJson() => {
        "name": eventNameValues.reverse[name],
        "type": eventTypeValues.reverse[type],
        "id": id,
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "sales": sales.toJson(),
        "dates": dates.toJson(),
        "classifications": classifications == null
            ? []
            : List<dynamic>.from(classifications!.map((x) => x.toJson())),
        "promoter": promoter?.toJson(),
        "promoters": promoters == null
            ? []
            : List<dynamic>.from(promoters!.map((x) => x.toJson())),
        "pleaseNote": pleaseNote,
        "priceRanges": priceRanges == null
            ? []
            : List<dynamic>.from(priceRanges!.map((x) => x.toJson())),
        "seatmap": seatmap?.toJson(),
        "accessibility": accessibility?.toJson(),
        "ticketLimit": ticketLimit?.toJson(),
        "ageRestrictions": ageRestrictions?.toJson(),
        "ticketing": ticketing?.toJson(),
        "_links": links.toJson(),
        "_embedded": embedded?.toJson(),
        "doorsTimes": doorsTimes?.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "info": infoValues.reverse[info],
        "description": description,
        "place": place?.toJson(),
      };
}

class Accessibility {
  int? ticketLimit;
  AccessibilityId id;
  String? info;
  String? url;
  String? urlText;

  Accessibility({
    this.ticketLimit,
    required this.id,
    this.info,
    this.url,
    this.urlText,
  });

  factory Accessibility.fromJson(Map<String, dynamic> json) => Accessibility(
        ticketLimit: json["ticketLimit"],
        id: accessibilityIdValues.map[json["id"]]!,
        info: json["info"],
        url: json["url"],
        urlText: json["urlText"],
      );

  Map<String, dynamic> toJson() => {
        "ticketLimit": ticketLimit,
        "id": accessibilityIdValues.reverse[id],
        "info": info,
        "url": url,
        "urlText": urlText,
      };
}

enum AccessibilityId { ACCESSIBILITY }

final accessibilityIdValues =
    EnumValues({"accessibility": AccessibilityId.ACCESSIBILITY});

class AgeRestrictions {
  bool legalAgeEnforced;
  AgeRestrictionsId id;

  AgeRestrictions({
    required this.legalAgeEnforced,
    required this.id,
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

class Dates {
  Start start;
  Timezone timezone;
  Status status;
  bool spanMultipleDays;
  Access? access;
  End? end;

  Dates({
    required this.start,
    required this.timezone,
    required this.status,
    required this.spanMultipleDays,
    this.access,
    this.end,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        start: Start.fromJson(json["start"]),
        timezone: timezoneValues.map[json["timezone"]]!,
        status: Status.fromJson(json["status"]),
        spanMultipleDays: json["spanMultipleDays"],
        access: json["access"] == null ? null : Access.fromJson(json["access"]),
        end: json["end"] == null ? null : End.fromJson(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "start": start.toJson(),
        "timezone": timezoneValues.reverse[timezone],
        "status": status.toJson(),
        "spanMultipleDays": spanMultipleDays,
        "access": access?.toJson(),
        "end": end?.toJson(),
      };
}

class Access {
  DateTime startDateTime;
  bool startApproximate;
  DateTime endDateTime;
  bool endApproximate;

  Access({
    required this.startDateTime,
    required this.startApproximate,
    required this.endDateTime,
    required this.endApproximate,
  });

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        startDateTime: DateTime.parse(json["startDateTime"]),
        startApproximate: json["startApproximate"],
        endDateTime: DateTime.parse(json["endDateTime"]),
        endApproximate: json["endApproximate"],
      );

  Map<String, dynamic> toJson() => {
        "startDateTime": startDateTime.toIso8601String(),
        "startApproximate": startApproximate,
        "endDateTime": endDateTime.toIso8601String(),
        "endApproximate": endApproximate,
      };
}

class End {
  String localTime;
  DateTime dateTime;
  bool approximate;
  bool noSpecificTime;

  End({
    required this.localTime,
    required this.dateTime,
    required this.approximate,
    required this.noSpecificTime,
  });

  factory End.fromJson(Map<String, dynamic> json) => End(
        localTime: json["localTime"],
        dateTime: DateTime.parse(json["dateTime"]),
        approximate: json["approximate"],
        noSpecificTime: json["noSpecificTime"],
      );

  Map<String, dynamic> toJson() => {
        "localTime": localTime,
        "dateTime": dateTime.toIso8601String(),
        "approximate": approximate,
        "noSpecificTime": noSpecificTime,
      };
}

class Start {
  DateTime localDate;
  String localTime;
  DateTime dateTime;
  bool dateTbd;
  bool dateTba;
  bool timeTba;
  bool noSpecificTime;

  Start({
    required this.localDate,
    required this.localTime,
    required this.dateTime,
    required this.dateTbd,
    required this.dateTba,
    required this.timeTba,
    required this.noSpecificTime,
  });

  factory Start.fromJson(Map<String, dynamic> json) => Start(
        localDate: DateTime.parse(json["localDate"]),
        localTime: json["localTime"],
        dateTime: DateTime.parse(json["dateTime"]),
        dateTbd: json["dateTBD"],
        dateTba: json["dateTBA"],
        timeTba: json["timeTBA"],
        noSpecificTime: json["noSpecificTime"],
      );

  Map<String, dynamic> toJson() => {
        "localDate":
            "${localDate.year.toString().padLeft(4, '0')}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}",
        "localTime": localTime,
        "dateTime": dateTime.toIso8601String(),
        "dateTBD": dateTbd,
        "dateTBA": dateTba,
        "timeTBA": timeTba,
        "noSpecificTime": noSpecificTime,
      };
}

class Status {
  Code code;

  Status({
    required this.code,
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

enum Timezone {
  AMERICA_CHICAGO,
  AMERICA_LOS_ANGELES,
  AMERICA_NEW_YORK,
  EUROPE_LONDON
}

final timezoneValues = EnumValues({
  "America/Chicago": Timezone.AMERICA_CHICAGO,
  "America/Los_Angeles": Timezone.AMERICA_LOS_ANGELES,
  "America/New_York": Timezone.AMERICA_NEW_YORK,
  "Europe/London": Timezone.EUROPE_LONDON
});

class DoorsTimes {
  DateTime localDate;
  String localTime;
  DateTime dateTime;
  String id;

  DoorsTimes({
    required this.localDate,
    required this.localTime,
    required this.dateTime,
    required this.id,
  });

  factory DoorsTimes.fromJson(Map<String, dynamic> json) => DoorsTimes(
        localDate: DateTime.parse(json["localDate"]),
        localTime: json["localTime"],
        dateTime: DateTime.parse(json["dateTime"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "localDate":
            "${localDate.year.toString().padLeft(4, '0')}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}",
        "localTime": localTime,
        "dateTime": dateTime.toIso8601String(),
        "id": id,
      };
}

class EventEmbedded {
  List<Venue> venues;
  List<Attraction> attractions;

  EventEmbedded({
    required this.venues,
    required this.attractions,
  });

  factory EventEmbedded.fromJson(Map<String, dynamic> json) => EventEmbedded(
        venues: List<Venue>.from(json["venues"].map((x) => Venue.fromJson(x))),
        attractions: List<Attraction>.from(
            json["attractions"].map((x) => Attraction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venues": List<dynamic>.from(venues.map((x) => x.toJson())),
        "attractions": List<dynamic>.from(attractions.map((x) => x.toJson())),
      };
}

class Attraction {
  AttractionName name;
  AttractionType type;
  AttractionId id;
  bool test;
  String url;
  Locale locale;
  ExternalLinks externalLinks;
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
    required this.externalLinks,
    required this.images,
    required this.classifications,
    required this.upcomingEvents,
    required this.links,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        name: attractionNameValues.map[json["name"]]!,
        type: attractionTypeValues.map[json["type"]]!,
        id: attractionIdValues.map[json["id"]]!,
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        externalLinks: ExternalLinks.fromJson(json["externalLinks"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        classifications: List<Classification>.from(
            json["classifications"].map((x) => Classification.fromJson(x))),
        upcomingEvents: Map.from(json["upcomingEvents"])
            .map((k, v) => MapEntry<String, int>(k, v)),
        links: AttractionLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "name": attractionNameValues.reverse[name],
        "type": attractionTypeValues.reverse[type],
        "id": attractionIdValues.reverse[id],
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "externalLinks": externalLinks.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "classifications":
            List<dynamic>.from(classifications.map((x) => x.toJson())),
        "upcomingEvents": Map.from(upcomingEvents)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "_links": links.toJson(),
      };
}

class ExternalLinks {
  List<TwitterElement> twitter;
  List<TwitterElement>? youtube;
  List<TwitterElement>? itunes;
  List<TwitterElement>? lastfm;
  List<TwitterElement>? spotify;
  List<TwitterElement>? wiki;
  List<TwitterElement>? facebook;
  List<Musicbrainz>? musicbrainz;
  List<TwitterElement>? instagram;
  List<TwitterElement>? homepage;

  ExternalLinks({
    required this.twitter,
    this.youtube,
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
        twitter: List<TwitterElement>.from(
            json["twitter"].map((x) => TwitterElement.fromJson(x))),
        youtube: json["youtube"] == null
            ? []
            : List<TwitterElement>.from(
                json["youtube"]!.map((x) => TwitterElement.fromJson(x))),
        itunes: json["itunes"] == null
            ? []
            : List<TwitterElement>.from(
                json["itunes"]!.map((x) => TwitterElement.fromJson(x))),
        lastfm: json["lastfm"] == null
            ? []
            : List<TwitterElement>.from(
                json["lastfm"]!.map((x) => TwitterElement.fromJson(x))),
        spotify: json["spotify"] == null
            ? []
            : List<TwitterElement>.from(
                json["spotify"]!.map((x) => TwitterElement.fromJson(x))),
        wiki: json["wiki"] == null
            ? []
            : List<TwitterElement>.from(
                json["wiki"]!.map((x) => TwitterElement.fromJson(x))),
        facebook: json["facebook"] == null
            ? []
            : List<TwitterElement>.from(
                json["facebook"]!.map((x) => TwitterElement.fromJson(x))),
        musicbrainz: json["musicbrainz"] == null
            ? []
            : List<Musicbrainz>.from(
                json["musicbrainz"]!.map((x) => Musicbrainz.fromJson(x))),
        instagram: json["instagram"] == null
            ? []
            : List<TwitterElement>.from(
                json["instagram"]!.map((x) => TwitterElement.fromJson(x))),
        homepage: json["homepage"] == null
            ? []
            : List<TwitterElement>.from(
                json["homepage"]!.map((x) => TwitterElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "twitter": List<dynamic>.from(twitter.map((x) => x.toJson())),
        "youtube": youtube == null
            ? []
            : List<dynamic>.from(youtube!.map((x) => x.toJson())),
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

class TwitterElement {
  String url;

  TwitterElement({
    required this.url,
  });

  factory TwitterElement.fromJson(Map<String, dynamic> json) => TwitterElement(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Musicbrainz {
  String id;
  String url;

  Musicbrainz({
    required this.id,
    required this.url,
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

enum AttractionId { K8_V_Z9171_FW7, K8_V_Z917_G1_ZF }

final attractionIdValues = EnumValues({
  "K8vZ9171fw7": AttractionId.K8_V_Z9171_FW7,
  "K8vZ917G1zf": AttractionId.K8_V_Z917_G1_ZF
});

class Image {
  Ratio? ratio;
  String url;
  int width;
  int height;
  bool fallback;

  Image({
    this.ratio,
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

enum Locale { EN_DE, EN_US }

final localeValues = EnumValues({"en-de": Locale.EN_DE, "en-us": Locale.EN_US});

enum AttractionName { CAGE_THE_ELEPHANT, OASIS }

final attractionNameValues = EnumValues({
  "Cage The Elephant": AttractionName.CAGE_THE_ELEPHANT,
  "Oasis": AttractionName.OASIS
});

enum AttractionType { ATTRACTION }

final attractionTypeValues =
    EnumValues({"attraction": AttractionType.ATTRACTION});

class Venue {
  String name;
  VenueType type;
  String id;
  bool test;
  String url;
  Locale locale;
  String postalCode;
  Timezone timezone;
  City city;
  CityState? state;
  Country country;
  Address address;
  Location location;
  List<Genre> markets;
  List<Dma> dmas;
  BoxOfficeInfo? boxOfficeInfo;
  String? parkingDetail;
  GeneralInfo? generalInfo;
  UpcomingEvents upcomingEvents;
  AttractionLinks links;
  List<Image>? images;
  Social? social;
  String? accessibleSeatingDetail;
  Ada? ada;

  Venue({
    required this.name,
    required this.type,
    required this.id,
    required this.test,
    required this.url,
    required this.locale,
    required this.postalCode,
    required this.timezone,
    required this.city,
    this.state,
    required this.country,
    required this.address,
    required this.location,
    required this.markets,
    required this.dmas,
    this.boxOfficeInfo,
    this.parkingDetail,
    this.generalInfo,
    required this.upcomingEvents,
    required this.links,
    this.images,
    this.social,
    this.accessibleSeatingDetail,
    this.ada,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        name: json["name"],
        type: venueTypeValues.map[json["type"]]!,
        id: json["id"],
        test: json["test"],
        url: json["url"],
        locale: localeValues.map[json["locale"]]!,
        postalCode: json["postalCode"],
        timezone: timezoneValues.map[json["timezone"]]!,
        city: City.fromJson(json["city"]),
        state: json["state"] == null ? null : CityState.fromJson(json["state"]),
        country: Country.fromJson(json["country"]),
        address: Address.fromJson(json["address"]),
        location: Location.fromJson(json["location"]),
        markets:
            List<Genre>.from(json["markets"].map((x) => Genre.fromJson(x))),
        dmas: List<Dma>.from(json["dmas"].map((x) => Dma.fromJson(x))),
        boxOfficeInfo: json["boxOfficeInfo"] == null
            ? null
            : BoxOfficeInfo.fromJson(json["boxOfficeInfo"]),
        parkingDetail: json["parkingDetail"],
        generalInfo: json["generalInfo"] == null
            ? null
            : GeneralInfo.fromJson(json["generalInfo"]),
        upcomingEvents: UpcomingEvents.fromJson(json["upcomingEvents"]),
        links: AttractionLinks.fromJson(json["_links"]),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        social: json["social"] == null ? null : Social.fromJson(json["social"]),
        accessibleSeatingDetail: json["accessibleSeatingDetail"],
        ada: json["ada"] == null ? null : Ada.fromJson(json["ada"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": venueTypeValues.reverse[type],
        "id": id,
        "test": test,
        "url": url,
        "locale": localeValues.reverse[locale],
        "postalCode": postalCode,
        "timezone": timezoneValues.reverse[timezone],
        "city": city.toJson(),
        "state": state?.toJson(),
        "country": country.toJson(),
        "address": address.toJson(),
        "location": location.toJson(),
        "markets": List<dynamic>.from(markets.map((x) => x.toJson())),
        "dmas": List<dynamic>.from(dmas.map((x) => x.toJson())),
        "boxOfficeInfo": boxOfficeInfo?.toJson(),
        "parkingDetail": parkingDetail,
        "generalInfo": generalInfo?.toJson(),
        "upcomingEvents": upcomingEvents.toJson(),
        "_links": links.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "social": social?.toJson(),
        "accessibleSeatingDetail": accessibleSeatingDetail,
        "ada": ada?.toJson(),
      };
}

class Ada {
  String adaPhones;
  String adaCustomCopy;
  String adaHours;

  Ada({
    required this.adaPhones,
    required this.adaCustomCopy,
    required this.adaHours,
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
  String line1;

  Address({
    required this.line1,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        line1: json["line1"],
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
      };
}

class BoxOfficeInfo {
  String? openHoursDetail;
  String? acceptedPaymentDetail;
  String willCallDetail;
  String? phoneNumberDetail;

  BoxOfficeInfo({
    this.openHoursDetail,
    this.acceptedPaymentDetail,
    required this.willCallDetail,
    this.phoneNumberDetail,
  });

  factory BoxOfficeInfo.fromJson(Map<String, dynamic> json) => BoxOfficeInfo(
        openHoursDetail: json["openHoursDetail"],
        acceptedPaymentDetail: json["acceptedPaymentDetail"],
        willCallDetail: json["willCallDetail"],
        phoneNumberDetail: json["phoneNumberDetail"],
      );

  Map<String, dynamic> toJson() => {
        "openHoursDetail": openHoursDetail,
        "acceptedPaymentDetail": acceptedPaymentDetail,
        "willCallDetail": willCallDetail,
        "phoneNumberDetail": phoneNumberDetail,
      };
}

class City {
  String name;

  City({
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Country {
  CountryName name;
  CountryCode countryCode;

  Country({
    required this.name,
    required this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: countryNameValues.map[json["name"]]!,
        countryCode: countryCodeValues.map[json["countryCode"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": countryNameValues.reverse[name],
        "countryCode": countryCodeValues.reverse[countryCode],
      };
}

enum CountryCode { GB, US }

final countryCodeValues =
    EnumValues({"GB": CountryCode.GB, "US": CountryCode.US});

enum CountryName { GREAT_BRITAIN, UNITED_KINGDOM, UNITED_STATES_OF_AMERICA }

final countryNameValues = EnumValues({
  "Great Britain": CountryName.GREAT_BRITAIN,
  "United Kingdom": CountryName.UNITED_KINGDOM,
  "United States Of America": CountryName.UNITED_STATES_OF_AMERICA
});

class Dma {
  int id;

  Dma({
    required this.id,
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
  String childRule;

  GeneralInfo({
    this.generalRule,
    required this.childRule,
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
  String longitude;
  String latitude;

  Location({
    required this.longitude,
    required this.latitude,
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
  SocialTwitter twitter;

  Social({
    required this.twitter,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        twitter: SocialTwitter.fromJson(json["twitter"]),
      );

  Map<String, dynamic> toJson() => {
        "twitter": twitter.toJson(),
      };
}

class SocialTwitter {
  String handle;

  SocialTwitter({
    required this.handle,
  });

  factory SocialTwitter.fromJson(Map<String, dynamic> json) => SocialTwitter(
        handle: json["handle"],
      );

  Map<String, dynamic> toJson() => {
        "handle": handle,
      };
}

class CityState {
  String name;
  String stateCode;

  CityState({
    required this.name,
    required this.stateCode,
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

class UpcomingEvents {
  int? archtics;
  int? tmr;
  int ticketmaster;
  int total;
  int filtered;
  int? sportxrUkScottishrugby;

  UpcomingEvents({
    this.archtics,
    this.tmr,
    required this.ticketmaster,
    required this.total,
    required this.filtered,
    this.sportxrUkScottishrugby,
  });

  factory UpcomingEvents.fromJson(Map<String, dynamic> json) => UpcomingEvents(
        archtics: json["archtics"],
        tmr: json["tmr"],
        ticketmaster: json["ticketmaster"],
        total: json["_total"],
        filtered: json["_filtered"],
        sportxrUkScottishrugby: json["sportxr-uk_scottishrugby"],
      );

  Map<String, dynamic> toJson() => {
        "archtics": archtics,
        "tmr": tmr,
        "ticketmaster": ticketmaster,
        "_total": total,
        "_filtered": filtered,
        "sportxr-uk_scottishrugby": sportxrUkScottishrugby,
      };
}

enum Info {
  PLEASE_READ_FULL_PROMOTER_TERMS_AND_CONDITIONS,
  PLEASE_READ_FULL_PROMOTER_TERMS_CONDITIONS
}

final infoValues = EnumValues({
  "Please read full promoter Terms and Conditions":
      Info.PLEASE_READ_FULL_PROMOTER_TERMS_AND_CONDITIONS,
  "Please read full promoter Terms & Conditions":
      Info.PLEASE_READ_FULL_PROMOTER_TERMS_CONDITIONS
});

class EventLinks {
  First self;
  List<First>? attractions;
  List<First>? venues;

  EventLinks({
    required this.self,
    this.attractions,
    this.venues,
  });

  factory EventLinks.fromJson(Map<String, dynamic> json) => EventLinks(
        self: First.fromJson(json["self"]),
        attractions: json["attractions"] == null
            ? []
            : List<First>.from(
                json["attractions"]!.map((x) => First.fromJson(x))),
        venues: json["venues"] == null
            ? []
            : List<First>.from(json["venues"]!.map((x) => First.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
        "attractions": attractions == null
            ? []
            : List<dynamic>.from(attractions!.map((x) => x.toJson())),
        "venues": venues == null
            ? []
            : List<dynamic>.from(venues!.map((x) => x.toJson())),
      };
}

enum EventName { OASIS, OASIS_LIVE_25 }

final eventNameValues = EnumValues(
    {"Oasis": EventName.OASIS, "OASIS LIVE '25": EventName.OASIS_LIVE_25});

class Place {
  City city;
  Country country;
  Address address;
  Location location;
  CityState state;
  String id;

  Place({
    required this.city,
    required this.country,
    required this.address,
    required this.location,
    required this.state,
    required this.id,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        city: City.fromJson(json["city"]),
        country: Country.fromJson(json["country"]),
        address: Address.fromJson(json["address"]),
        location: Location.fromJson(json["location"]),
        state: CityState.fromJson(json["state"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "city": city.toJson(),
        "country": country.toJson(),
        "address": address.toJson(),
        "location": location.toJson(),
        "state": state.toJson(),
        "id": id,
      };
}

class PriceRange {
  PriceRangeType? type;
  Currency currency;
  double? min;
  double? max;

  PriceRange({
    this.type,
    required this.currency,
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

enum Currency { EUR, GBP, USD }

final currencyValues =
    EnumValues({"EUR": Currency.EUR, "GBP": Currency.GBP, "USD": Currency.USD});

enum PriceRangeType { STANDARD, STANDARD_INCLUDING_FEES }

final priceRangeTypeValues = EnumValues({
  "standard": PriceRangeType.STANDARD,
  "standard including fees": PriceRangeType.STANDARD_INCLUDING_FEES
});

class Product {
  String name;
  String id;
  String url;
  String type;
  List<Classification> classifications;

  Product({
    required this.name,
    required this.id,
    required this.url,
    required this.type,
    required this.classifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        id: json["id"],
        url: json["url"],
        type: json["type"],
        classifications: List<Classification>.from(
            json["classifications"].map((x) => Classification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "url": url,
        "type": type,
        "classifications":
            List<dynamic>.from(classifications.map((x) => x.toJson())),
      };
}

class Promoter {
  String id;
  PromoterName name;
  Description description;

  Promoter({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Promoter.fromJson(Map<String, dynamic> json) => Promoter(
        id: json["id"],
        name: promoterNameValues.map[json["name"]]!,
        description: descriptionValues.map[json["description"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": promoterNameValues.reverse[name],
        "description": descriptionValues.reverse[description],
      };
}

enum Description {
  DF_CONCERTS_NTL_GBR,
  LIVE_NATION_MUSIC_NTL_USA,
  OASIS_NTL_GBR,
  S_J_M_LTD_NTL_GBR
}

final descriptionValues = EnumValues({
  "DF CONCERTS / NTL / GBR": Description.DF_CONCERTS_NTL_GBR,
  "LIVE NATION MUSIC / NTL / USA": Description.LIVE_NATION_MUSIC_NTL_USA,
  "OASIS / NTL / GBR": Description.OASIS_NTL_GBR,
  "S.J.M. LTD / NTL / GBR": Description.S_J_M_LTD_NTL_GBR
});

enum PromoterName { DF_CONCERTS, LIVE_NATION_MUSIC, OASIS, S_J_M_LTD }

final promoterNameValues = EnumValues({
  "DF CONCERTS": PromoterName.DF_CONCERTS,
  "LIVE NATION MUSIC": PromoterName.LIVE_NATION_MUSIC,
  "OASIS": PromoterName.OASIS,
  "S.J.M. LTD": PromoterName.S_J_M_LTD
});

class Sales {
  Public public;
  List<Presale>? presales;

  Sales({
    required this.public,
    this.presales,
  });

  factory Sales.fromJson(Map<String, dynamic> json) => Sales(
        public: Public.fromJson(json["public"]),
        presales: json["presales"] == null
            ? []
            : List<Presale>.from(
                json["presales"]!.map((x) => Presale.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "public": public.toJson(),
        "presales": presales == null
            ? []
            : List<dynamic>.from(presales!.map((x) => x.toJson())),
      };
}

class Presale {
  DateTime startDateTime;
  DateTime endDateTime;
  PresaleName name;

  Presale({
    required this.startDateTime,
    required this.endDateTime,
    required this.name,
  });

  factory Presale.fromJson(Map<String, dynamic> json) => Presale(
        startDateTime: DateTime.parse(json["startDateTime"]),
        endDateTime: DateTime.parse(json["endDateTime"]),
        name: presaleNameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "startDateTime": startDateTime.toIso8601String(),
        "endDateTime": endDateTime.toIso8601String(),
        "name": presaleNameValues.reverse[name],
      };
}

enum PresaleName {
  OASIS_LIVE_25_FAN_PRESALE,
  UK_PRE_SALE_BALLOT,
  VIP_PACKAGES_ONSALE,
  VIP_PACKAGES_PRESALE
}

final presaleNameValues = EnumValues({
  "Oasis Live '25 Fan Presale": PresaleName.OASIS_LIVE_25_FAN_PRESALE,
  "UK Pre-Sale Ballot": PresaleName.UK_PRE_SALE_BALLOT,
  "VIP Packages Onsale": PresaleName.VIP_PACKAGES_ONSALE,
  "VIP Packages Presale": PresaleName.VIP_PACKAGES_PRESALE
});

class Public {
  DateTime startDateTime;
  bool startTbd;
  bool startTba;
  DateTime endDateTime;

  Public({
    required this.startDateTime,
    required this.startTbd,
    required this.startTba,
    required this.endDateTime,
  });

  factory Public.fromJson(Map<String, dynamic> json) => Public(
        startDateTime: DateTime.parse(json["startDateTime"]),
        startTbd: json["startTBD"],
        startTba: json["startTBA"],
        endDateTime: DateTime.parse(json["endDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "startDateTime": startDateTime.toIso8601String(),
        "startTBD": startTbd,
        "startTBA": startTba,
        "endDateTime": endDateTime.toIso8601String(),
      };
}

class Seatmap {
  String staticUrl;
  SeatmapId id;

  Seatmap({
    required this.staticUrl,
    required this.id,
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
  String info;
  TicketLimitId id;

  TicketLimit({
    required this.info,
    required this.id,
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
  SafeTix safeTix;
  AllInclusivePricing allInclusivePricing;
  TicketingId id;

  Ticketing({
    required this.safeTix,
    required this.allInclusivePricing,
    required this.id,
  });

  factory Ticketing.fromJson(Map<String, dynamic> json) => Ticketing(
        safeTix: SafeTix.fromJson(json["safeTix"]),
        allInclusivePricing:
            AllInclusivePricing.fromJson(json["allInclusivePricing"]),
        id: ticketingIdValues.map[json["id"]]!,
      );

  Map<String, dynamic> toJson() => {
        "safeTix": safeTix.toJson(),
        "allInclusivePricing": allInclusivePricing.toJson(),
        "id": ticketingIdValues.reverse[id],
      };
}

class AllInclusivePricing {
  bool enabled;

  AllInclusivePricing({
    required this.enabled,
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
  bool enabled;
  bool inAppOnlyEnabled;

  SafeTix({
    required this.enabled,
    required this.inAppOnlyEnabled,
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

class EventsLinks {
  First first;
  First self;
  First next;
  First last;

  EventsLinks({
    required this.first,
    required this.self,
    required this.next,
    required this.last,
  });

  factory EventsLinks.fromJson(Map<String, dynamic> json) => EventsLinks(
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
