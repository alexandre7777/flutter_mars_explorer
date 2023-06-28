import 'package:flutter/cupertino.dart';
import 'package:marsroverflutter/domain/model/RoverPhotoUiModel.dart';
import 'package:marsroverflutter/service/mars_rover_photo_service.dart';
import 'package:marsroverflutter/service/model/RoverPhotoRemoteModel.dart';

class PhotoProvider with ChangeNotifier {
  final PhotoService _photoService;

  PhotoProvider(this._photoService);

  RoverPhotoUiState _roverPhotoUiState = Loading();

  RoverPhotoUiState get roverPhotoUiState => _roverPhotoUiState;

  set roverPhotoUiState(RoverPhotoUiState newRoverPhotoUiState) {
    _roverPhotoUiState = newRoverPhotoUiState;
    notifyListeners();
  }

  Future getMarsRoverPhoto(String roverName, String sol) async {
    Future.delayed(Duration.zero,(){
      roverPhotoUiState = Loading();
    });
    RoverPhotoRemoteModel result =
        await _photoService.fetchPhoto(roverName, sol);
    roverPhotoUiState = Success(result.photos
        .map((photo) => RoverPhotoUiModel(
            photo.id,
            photo.rover.name,
            photo.imgSrc,
            photo.sol.toString(),
            photo.earthDate,
            photo.camera.fullName,
            false))
        .toList());
  }
}
