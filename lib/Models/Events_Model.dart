import 'dart:io';
import 'dart:typed_data';

class EventMediaModel {
  File? image;
  File? video;
  bool? isVideo;
  Uint8List? thumbnail;
  EventMediaModel({this.image, this.video, this.isVideo, this.thumbnail});
}

class EventModel {
  String? uid;
  String? event;
  String? eventName;
  String? eventLocation;
  String? eventdate;
  String? maxentries;
  String? tags;
  String? frequency_of_event;
  String? start_time;
  String? end_time;
  String? description;
  String? inviter;
  String? joined;
  String? price;
  String? media;
  String? who_can_invite;

  EventModel({
    this.uid,
    this.event,
    this.eventName,
    this.eventLocation,
    this.eventdate,
    this.maxentries,
    this.tags,
    this.start_time,
    this.frequency_of_event,
    this.end_time,
    this.description,
    this.inviter,
    this.joined,
    this.price,
    this.media,
    this.who_can_invite,
  });

  EventModel.fromMap(map) {
    uid = map["uid"];
    event = map["event"];
    eventName = map["eventName"];
    eventLocation = map["eventLocation"];
    eventdate = map["eventdate"];
    maxentries = map["maxentries"];
    tags = map["tags"];
    start_time = map["start_time"];
    end_time = map["end_time"];
    frequency_of_event = map["frequency_of_event"];
    description = map["description"];
    inviter = map["inviter"];
    joined = map["joined"];
    who_can_invite = map["who_can_invite"];
    price = map["price"];
    media = map["media"];
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "event": event,
      "eventName": eventName,
      "eventLocation": eventLocation,
      "eventdate": eventdate,
      "maxentries": maxentries,
      "tags": tags,
      "start_time": start_time,
      "end_time": end_time,
      "description": description,
      "frequency_of_event": frequency_of_event,
      "inviter": inviter,
      "joined": joined,
      "price": price,
      "who_can_invite": who_can_invite,
      "media": media,
    };
  }
}
