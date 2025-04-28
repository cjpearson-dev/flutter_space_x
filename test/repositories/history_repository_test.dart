import 'dart:convert';

import 'package:flutter_space_x/models/historical_event.dart';
import 'package:flutter_space_x/repositories/history/history_repository_impl.dart';
import 'package:flutter_space_x/services/api/api_response.dart';
import 'package:flutter_space_x/services/api/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'history_repository_test.mocks.dart';
import 'history_repository_test_data.dart';

// Annotation which generates the history_repository_test.mocks.dart and the MockApiService class.
@GenerateNiceMocks([MockSpec<ApiService>()])
void main() {
  group('HistoryRepositoryImplTest -', () {
    // Instantiate the mock ApiService
    final mockApiService = MockApiService();
    // Inject mock ApiService into HistoryRepository implementation
    final historyRepository = HistoryRepositoryImpl(mockApiService);

    final urlString = 'api.spacexdata.com/v3/history';

    group('getAllEvents -', () {
      final url = Uri.parse('$urlString?order=desc');

      test(
        'returns a list of historical events when the api call completes successfully',
        () async {
          // Arrange
          final mockResponse = ApiResponse.success(
            <String, String>{},
            jsonDecode(mockHistoricalEventsJson),
          );
          provideDummy(mockResponse);
          when(
            mockApiService.get(url: url),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final response = await historyRepository.getAllEvents();

          // Assert
          expect(response.isSuccessful, isTrue);
          expect(response.message, isNull);
          expect(response.content, isNotNull);
          expect(response.content, isA<List<HistoricalEvent>>());
          expect(response.content!.length, 6);
          expect(response.content![0].title, "Falcon 1 Makes History");
          expect(response.content![1].eventDateUnix, 1229994000);
          expect(response.content![2].id, 3);
          expect(response.content![3].flightNumber, 6);
        },
      );

      test(
        'returns an error message when the http call completes with a failure',
        () async {
          // Arrange
          final mockResponse = ApiResponse.failure('Error');
          provideDummy(mockResponse);
          when(
            mockApiService.get(url: url),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final response = await historyRepository.getAllEvents();

          // Assert
          expect(response.isSuccessful, isFalse);
          expect(response.message, 'Error');
          expect(response.content, isNull);
        },
      );

      test(
        'return an error message when the response cannot be parsed into List<HistoricalEvent>',
        () async {
          // Arrange
          final mockResponse = ApiResponse.success(
            <String, String>{},
            'invalid json',
          );
          provideDummy(mockResponse);
          when(
            mockApiService.get(url: url),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final response = await historyRepository.getAllEvents();

          // Assert
          expect(response.isSuccessful, isFalse);
          expect(response.message, 'Something went wrong');
          expect(response.content, isNull);
        },
      );
    });

    group('getSingleEvent -', () {
      test(
        'returns an historical event when the http call completes successfully',
        () async {
          final url = Uri.parse('$urlString/1');
          // Arrange
          final mockResponse = ApiResponse.success(
            <String, String>{},
            jsonDecode(mockHistoricalEventJson),
          );
          provideDummy(mockResponse);
          when(
            mockApiService.get(url: url),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final response = await historyRepository.getSingleEvent(1);

          // Assert
          expect(response.isSuccessful, isTrue);
          expect(response.message, isNull);
          expect(response.content, isNotNull);
          expect(response.content, isA<HistoricalEvent>());
          expect(response.content!.title, "Falcon 1 Makes History");
          expect(response.content!.eventDateUnix, 1222643700);
          expect(response.content!.id, 1);
          expect(response.content!.flightNumber, 4);
        },
      );

      test(
        'returns an error message when the http call completes with a failure',
        () async {
          // Arrange
          final url = Uri.parse('$urlString/2');
          final mockResponse = ApiResponse.failure('Error');
          provideDummy(mockResponse);
          when(
            mockApiService.get(url: url),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final response = await historyRepository.getSingleEvent(2);

          // Assert
          expect(response.isSuccessful, isFalse);
          expect(response.message, 'Error');
          expect(response.content, isNull);
        },
      );

      test(
        'throws an exception when the response cannot be parsed into Post',
        () async {
          final url = Uri.parse('$urlString/1');
          // Arrange
          final mockResponse = ApiResponse.success(
            <String, String>{},
            'invalid json',
          );
          provideDummy(mockResponse);
          when(
            mockApiService.get(url: url),
          ).thenAnswer((_) async => mockResponse);

          // Act
          final response = await historyRepository.getSingleEvent(1);

          // Assert
          expect(response.isSuccessful, isFalse);
          expect(response.message, 'Something went wrong');
          expect(response.content, isNull);
        },
      );
    });
  });
}
