import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  List<Datum> data;
  String cursor;
  bool hasNextPage;

  ChatModel({
    required this.data,
    required this.cursor,
    required this.hasNextPage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        cursor: json["cursor"],
        hasNextPage: json["hasNextPage"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "cursor": cursor,
        "hasNextPage": hasNextPage,
      };
}

class Datum {
  String contentType;
  List<String> alternateResponses;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String speaker;
  String text;
  String speechUrl;

  Datum({
    required this.contentType,
    required this.alternateResponses,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.speaker,
    required this.text,
    required this.speechUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        contentType: json["contentType"],
        alternateResponses:
            List<String>.from(json["alternateResponses"].map((x) => x)),
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        speaker: json["speaker"],
        text: json["text"],
        speechUrl: json["speechUrl"],
      );

  Map<String, dynamic> toJson() => {
        "contentType": contentType,
        "alternateResponses":
            List<dynamic>.from(alternateResponses.map((x) => x)),
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "speaker": speaker,
        "text": text,
        "speechUrl": speechUrl,
      };
}
