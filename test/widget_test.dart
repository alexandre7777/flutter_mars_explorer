import 'package:flutter_test/flutter_test.dart';
import 'package:marsroverflutter/domain/model/RoverManifestUiModel.dart';
import 'package:marsroverflutter/service/mars_rover_manifest_service.dart';
import 'package:marsroverflutter/service/model/RoverManifestRemoteModel.dart';
import 'package:marsroverflutter/data/ManifestProvider.dart';
import 'package:mocktail/mocktail.dart';

class MockManifestService extends Mock implements ManifestService {}

void main() {
  test('adding item increases total cost', () async {
    // Given
    final mockManifestService = MockManifestService();
    final roverManifestRemoteModel = RoverManifestRemoteModel.fromJson({
      "photo_manifest": {
        "name": "Perseverance",
        "landing_date": "2021-02-18",
        "launch_date": "2020-07-30",
        "status": "active",
        "max_sol": 832,
        "max_date": "2023-06-22",
        "total_photos": 161827,
        "photos": [{
          "sol": 0,
          "earth_date": "2021-02-18",
          "total_photos": 54,
          "cameras": ["EDL_DDCAM", "FRONT_HAZCAM_LEFT_A", "FRONT_HAZCAM_RIGHT_A", "REAR_HAZCAM_LEFT", "REAR_HAZCAM_RIGHT"]
        }]
      }
    });
    when(() => mockManifestService.fetchManifest('perseverance')).thenAnswer((invocation) => Future.value(roverManifestRemoteModel));
    final manifestProvider = ManifestProvider(mockManifestService);

    // When
    await manifestProvider.getMarsRoverManifest('perseverance');

    // Then
    expect(manifestProvider.roverManifestUiState is Success, true);
    expect((manifestProvider.roverManifestUiState as Success).roverManifestUiModelList.length, 1);
    expect((manifestProvider.roverManifestUiState as Success).roverManifestUiModelList[0].sol, "0");
    expect((manifestProvider.roverManifestUiState as Success).roverManifestUiModelList[0].earthDate, "2021-02-18");
    expect((manifestProvider.roverManifestUiState as Success).roverManifestUiModelList[0].photoNumber, "54");
  });
}

/*testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MarsRoverExplorer());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });*/
