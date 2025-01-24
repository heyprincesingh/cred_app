import 'dart:convert';

class LoanDataModel {
  List<LoanModelItem>? items;

  LoanDataModel({
    this.items,
  });

  factory LoanDataModel.fromJson(String str) => LoanDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoanDataModel.fromMap(Map<String, dynamic> json) => LoanDataModel(
    items: json["items"] == null ? [] : List<LoanModelItem>.from(json["items"]!.map((x) => LoanModelItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
  };
}

class LoanModelItem {
  OpenState? openState;
  ClosedState? closedState;
  String? ctaText;

  LoanModelItem({
    this.openState,
    this.closedState,
    this.ctaText,
  });

  factory LoanModelItem.fromJson(String str) => LoanModelItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoanModelItem.fromMap(Map<String, dynamic> json) => LoanModelItem(
    openState: json["open_state"] == null ? null : OpenState.fromMap(json["open_state"]),
    closedState: json["closed_state"] == null ? null : ClosedState.fromMap(json["closed_state"]),
    ctaText: json["cta_text"],
  );

  Map<String, dynamic> toMap() => {
    "open_state": openState?.toMap(),
    "closed_state": closedState?.toMap(),
    "cta_text": ctaText,
  };
}

class ClosedState {
  ClosedStateBody? body;

  ClosedState({
    this.body,
  });

  factory ClosedState.fromJson(String str) => ClosedState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClosedState.fromMap(Map<String, dynamic> json) => ClosedState(
    body: json["body"] == null ? null : ClosedStateBody.fromMap(json["body"]),
  );

  Map<String, dynamic> toMap() => {
    "body": body?.toMap(),
  };
}

class ClosedStateBody {
  String? key1;
  String? key2;

  ClosedStateBody({
    this.key1,
    this.key2,
  });

  factory ClosedStateBody.fromJson(String str) => ClosedStateBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClosedStateBody.fromMap(Map<String, dynamic> json) => ClosedStateBody(
    key1: json["key1"],
    key2: json["key2"],
  );

  Map<String, dynamic> toMap() => {
    "key1": key1,
    "key2": key2,
  };
}

class OpenState {
  OpenStateBody? body;

  OpenState({
    this.body,
  });

  factory OpenState.fromJson(String str) => OpenState.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OpenState.fromMap(Map<String, dynamic> json) => OpenState(
    body: json["body"] == null ? null : OpenStateBody.fromMap(json["body"]),
  );

  Map<String, dynamic> toMap() => {
    "body": body?.toMap(),
  };
}

class OpenStateBody {
  String? title;
  String? subtitle;
  Card? card;
  String? footer;
  List<BodyItem>? items;

  OpenStateBody({
    this.title,
    this.subtitle,
    this.card,
    this.footer,
    this.items,
  });

  factory OpenStateBody.fromJson(String str) => OpenStateBody.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OpenStateBody.fromMap(Map<String, dynamic> json) => OpenStateBody(
    title: json["title"],
    subtitle: json["subtitle"],
    card: json["card"] == null ? null : Card.fromMap(json["card"]),
    footer: json["footer"],
    items: json["items"] == null ? [] : List<BodyItem>.from(json["items"]!.map((x) => BodyItem.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "subtitle": subtitle,
    "card": card?.toMap(),
    "footer": footer,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
  };
}

class Card {
  String? header;
  String? description;
  int? maxRange;
  int? minRange;

  Card({
    this.header,
    this.description,
    this.maxRange,
    this.minRange,
  });

  factory Card.fromJson(String str) => Card.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Card.fromMap(Map<String, dynamic> json) => Card(
    header: json["header"],
    description: json["description"],
    maxRange: json["max_range"],
    minRange: json["min_range"],
  );

  Map<String, dynamic> toMap() => {
    "header": header,
    "description": description,
    "max_range": maxRange,
    "min_range": minRange,
  };
}

class BodyItem {
  String? emi;
  String? duration;
  String? title;
  dynamic subtitle;
  String? tag;
  String? icon;

  BodyItem({
    this.emi,
    this.duration,
    this.title,
    this.subtitle,
    this.tag,
    this.icon,
  });

  factory BodyItem.fromJson(String str) => BodyItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BodyItem.fromMap(Map<String, dynamic> json) => BodyItem(
    emi: json["emi"],
    duration: json["duration"],
    title: json["title"],
    subtitle: json["subtitle"],
    tag: json["tag"],
    icon: json["icon"],
  );

  Map<String, dynamic> toMap() => {
    "emi": emi,
    "duration": duration,
    "title": title,
    "subtitle": subtitle,
    "tag": tag,
    "icon": icon,
  };
}
