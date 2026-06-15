class EventDetailsModel {
  final String id;
  final String name;
  final String url;
  final List<String> images;
  final String localDate;
  final String localTime;
  final String dateTime;
  final String timezone;
  final String venueName;
  final String venueAddress;
  final String venueCity;
  final String venueCountry;
  final double venueLatitude;
  final double venueLongitude;
  final String organizerName;
  final String organizerImageUrl;
  final String info;
  final String pleaseNote;
  final double minPrice;
  final double maxPrice;
  final String currency;

  EventDetailsModel({
    required this.id,
    required this.name,
    required this.url,
    required this.images,
    required this.localDate,
    required this.localTime,
    required this.dateTime,
    required this.timezone,
    required this.venueName,
    required this.venueAddress,
    required this.venueCity,
    required this.venueCountry,
    required this.venueLatitude,
    required this.venueLongitude,
    required this.organizerName,
    required this.organizerImageUrl,
    required this.info,
    required this.pleaseNote,
    required this.minPrice,
    required this.maxPrice,
    required this.currency,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json, Map<String, dynamic>? imagesJson) {
    List<String> parsedImages = [];
    
    // Parse main images
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      parsedImages = (json['images'] as List).map((i) => i['url'] as String).toList();
    }
    
    // Parse additional images if provided
    if (imagesJson != null && imagesJson['images'] != null && (imagesJson['images'] as List).isNotEmpty) {
      final extraImages = (imagesJson['images'] as List).map((i) => i['url'] as String).toList();
      // Add unique images
      for (var img in extraImages) {
        if (!parsedImages.contains(img)) {
          parsedImages.add(img);
        }
      }
    }

    String lDate = '';
    String lTime = '';
    String dt = '';
    String tz = json['dates']?['timezone'] ?? '';

    if (json['dates'] != null && json['dates']['start'] != null) {
      lDate = json['dates']['start']['localDate'] ?? '';
      lTime = json['dates']['start']['localTime'] ?? '';
      dt = json['dates']['start']['dateTime'] ?? '';
    }

    String vName = '';
    String vAddress = '';
    String vCity = '';
    String vCountry = '';
    double vLat = 0.0;
    double vLng = 0.0;

    if (json['_embedded'] != null && json['_embedded']['venues'] != null && (json['_embedded']['venues'] as List).isNotEmpty) {
      var venue = json['_embedded']['venues'][0];
      vName = venue['name'] ?? '';
      if (venue['address'] != null) {
        vAddress = venue['address']['line1'] ?? '';
      }
      if (venue['city'] != null) {
        vCity = venue['city']['name'] ?? '';
      }
      if (venue['country'] != null) {
        vCountry = venue['country']['name'] ?? '';
      }
      if (venue['location'] != null) {
        vLat = double.tryParse(venue['location']['latitude']?.toString() ?? '0') ?? 0.0;
        vLng = double.tryParse(venue['location']['longitude']?.toString() ?? '0') ?? 0.0;
      }
    }

    String orgName = '';
    String orgImg = '';

    if (json['_embedded'] != null && json['_embedded']['attractions'] != null && (json['_embedded']['attractions'] as List).isNotEmpty) {
      var attraction = json['_embedded']['attractions'][0];
      orgName = attraction['name'] ?? '';
      if (attraction['images'] != null && (attraction['images'] as List).isNotEmpty) {
        orgImg = attraction['images'][0]['url'] ?? '';
      }
    }

    double mnPrice = 0.0;
    double mxPrice = 0.0;
    String curr = 'USD';

    if (json['priceRanges'] != null && (json['priceRanges'] as List).isNotEmpty) {
      var pr = json['priceRanges'][0];
      mnPrice = (pr['min'] as num?)?.toDouble() ?? 0.0;
      mxPrice = (pr['max'] as num?)?.toDouble() ?? 0.0;
      curr = pr['currency'] ?? 'USD';
    }

    return EventDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      images: parsedImages,
      localDate: lDate,
      localTime: lTime,
      dateTime: dt,
      timezone: tz,
      venueName: vName,
      venueAddress: vAddress,
      venueCity: vCity,
      venueCountry: vCountry,
      venueLatitude: vLat,
      venueLongitude: vLng,
      organizerName: orgName,
      organizerImageUrl: orgImg,
      info: json['info'] ?? '',
      pleaseNote: json['pleaseNote'] ?? '',
      minPrice: mnPrice,
      maxPrice: mxPrice,
      currency: curr,
    );
  }
}
