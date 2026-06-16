import '../../../../core/network/dio_helper.dart';

class EventsRemoteDataSource {
  Future<Map<String, dynamic>> getClassifications(String apiKey) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/classifications.json',
      query: {
        'apikey': apiKey,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getUpcomingEvents(String apiKey, String city) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events.json',
      query: {
        'apikey': apiKey,
        'city': city,
        'sort': 'date,asc',
        'size': 10,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getNearbyEvents(String apiKey, String latlong) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events.json',
      query: {
        'apikey': apiKey,
        'latlong': latlong,
        'radius': 20,
        'unit': 'km',
        'sort': 'distance,asc',
        'size': 10,
      },
    );
    return response.data;
  }
  Future<Map<String, dynamic>> getAllUpcomingEvents(String apiKey, String city) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events.json',
      query: {
        'apikey': apiKey,
        'city': city,
        'sort': 'date,asc',
        'size': 20,
        'page': 0,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getPastEvents(String apiKey, String city) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events.json',
      query: {
        'apikey': apiKey,
        'city': city,
        'endDateTime': '2026-06-15T00:00:00Z',
        'sort': 'date,desc',
        'size': 20,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getEventDetails(String apiKey, String eventId) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events/$eventId.json',
      query: {
        'apikey': apiKey,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getEventImages(String apiKey, String eventId) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events/$eventId/images',
      query: {
        'apikey': apiKey,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> searchEvents(String apiKey, String keyword) async {
    final response = await DioHelper.getData(
      url: '/discovery/v2/events.json',
      query: {
        'apikey': apiKey,
        'keyword': keyword,
        'size': 20,
      },
    );
    return response.data;
  }
}
