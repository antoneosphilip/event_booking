class EventModel {
  final String id;
  final String name;
  final String imageUrl;
  final String date;
  final String venueName;
  final String cityName;

  EventModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.date,
    required this.venueName,
    required this.cityName,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    String imgUrl = '';
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      imgUrl = json['images'][0]['url'] ?? '';
    }
    
    String d = '';
    if (json['dates'] != null && json['dates']['start'] != null) {
      d = json['dates']['start']['localDate'] ?? '';
    }

    String vName = '';
    String cName = '';
    if (json['_embedded'] != null && json['_embedded']['venues'] != null && (json['_embedded']['venues'] as List).isNotEmpty) {
      var venue = json['_embedded']['venues'][0];
      vName = venue['name'] ?? '';
      if (venue['city'] != null) {
        cName = venue['city']['name'] ?? '';
      }
    }

    return EventModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: imgUrl,
      date: d,
      venueName: vName,
      cityName: cName,
    );
  }
}
