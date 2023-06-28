import 'package:flutter/cupertino.dart';
import 'package:marsroverflutter/domain/model/RoverManifestConvertor.dart';
import 'package:marsroverflutter/domain/model/RoverManifestUiModel.dart';
import 'package:marsroverflutter/service/mars_rover_manifest_service.dart';
import 'package:marsroverflutter/service/model/RoverManifestRemoteModel.dart';

class ManifestProvider with ChangeNotifier {
  final ManifestService _manifestService;

  ManifestProvider(this._manifestService);

  RoverManifestUiState _roverManifestUiState = Loading();

  RoverManifestUiState get roverManifestUiState => _roverManifestUiState;

  set roverManifestUiState(RoverManifestUiState newRoverManifestUiState) {
    _roverManifestUiState = newRoverManifestUiState;
    notifyListeners();
  }

  Future getMarsRoverManifest(String roverName) async {
    Future.delayed(Duration.zero,(){
      roverManifestUiState = Loading();
    });
    RoverManifestRemoteModel result =
        await _manifestService.fetchManifest(roverName);
    roverManifestUiState = toUiModel(result);
  }
}
