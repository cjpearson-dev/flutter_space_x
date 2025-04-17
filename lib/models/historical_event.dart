import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_event.freezed.dart';
part 'historical_event.g.dart';

@freezed
abstract class HistoricalEvent with _$HistoricalEvent {
  const factory HistoricalEvent({
    required int id,
    required String title,
    required String eventDateUtc,
    required int eventDateUnix,
    int? flightNumber,
    required String details,
    required EventLinks links,
  }) = _HistoricalEvent;

  factory HistoricalEvent.fromJson(Map<String, dynamic> json) =>
      _$HistoricalEventFromJson(json);
}

@freezed
abstract class EventLinks with _$EventLinks {
  const factory EventLinks({
    String? reddit,
    String? article,
    String? wikipedia,
  }) = _EventLinks;

  factory EventLinks.fromJson(Map<String, dynamic> json) =>
      _$EventLinksFromJson(json);
}
