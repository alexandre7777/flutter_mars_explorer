import 'package:flutter/cupertino.dart';
import 'package:marsroverflutter/db/mars_rover_saved_local_model.dart';
import 'package:marsroverflutter/domain/model/rover_photo_convertor.dart';
import 'package:marsroverflutter/domain/model/rover_photo_ui_model.dart';
import 'package:marsroverflutter/service/mars_rover_photo_service.dart';
import 'package:marsroverflutter/service/model/rover_photo_remote_model.dart';
import 'package:marsroverflutter/db/mars_rover_saved_local_dao.dart';

class SavedPhotoProvider with ChangeNotifier {

  final PhotoDao _photoDao;

  SavedPhotoProvider(this._photoDao);

  RoverPhotoUiState _roverPhotoUiState = Loading();

  RoverPhotoUiState get roverPhotoUiState => _roverPhotoUiState;

  set roverPhotoUiState(RoverPhotoUiState newRoverPhotoUiState) {
    _roverPhotoUiState = newRoverPhotoUiState;
    notifyListeners();
  }

  Future getAllSavedPhoto() async {
    Future.delayed(Duration.zero, () {
      roverPhotoUiState = Loading();
    });
    List<MarsRoverSavedLocalModel> savedPhoto =
        await _photoDao.getAllSavedPhoto();
    roverPhotoUiState = Success(savedPhoto
        .map((photo) => RoverPhotoUiModel(
            photo.roverPhotoId,
            photo.roverName,
            photo.imgSrc,
            photo.sol,
            photo.earthDate,
            photo.cameraFullName,
            true))
        .toList());
  }

  Future removeRoverPhoto(RoverPhotoUiModel roverPhotoUiModel) async {
    _photoDao.remove(toDbModel(roverPhotoUiModel));
    getAllSavedPhoto();
  }
}
