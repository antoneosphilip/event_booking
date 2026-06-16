import '../datasource/events_remote_data_source.dart';
import '../models/classification_model.dart';
import '../models/event_model.dart';

class EventsRepository {
  final EventsRemoteDataSource remoteDataSource;

  EventsRepository(this.remoteDataSource);

  Future<List<ClassificationModel>> getClassifications(String apiKey) async {
    try {
      final data = await remoteDataSource.getClassifications(apiKey);
      if (data['_embedded'] != null && data['_embedded']['classifications'] != null) {
        return (data['_embedded']['classifications'] as List)
            .map((e) => ClassificationModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get classifications: $e');
    }
  }

  Future<List<EventModel>> getUpcomingEvents(String apiKey, String city) async {
    try {
      final data = await remoteDataSource.getUpcomingEvents(apiKey, city);
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        return (data['_embedded']['events'] as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get upcoming events: $e');
    }
  }

  Future<List<EventModel>> getNearbyEvents(String apiKey, String latlong) async {
    try {
      final data = await remoteDataSource.getNearbyEvents(apiKey, latlong);
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        return (data['_embedded']['events'] as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get nearby events: $e');
    }
  }
  Future<List<EventModel>> getAllUpcomingEvents(String apiKey, String city) async {
    try {
      final data = await remoteDataSource.getAllUpcomingEvents(apiKey, city);
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        return (data['_embedded']['events'] as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get all upcoming events: $e');
    }
  }

  Future<List<EventModel>> getPastEvents(String apiKey, String city) async {
    try {
      final data = await remoteDataSource.getPastEvents(apiKey, city);
      if (data['_embedded'] != null && data['_embedded']['events'] != null) {
        return (data['_embedded']['events'] as List)
            .map((e) => EventModel.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to get past events: $e');
    }
  }
}
