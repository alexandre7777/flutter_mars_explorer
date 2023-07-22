import 'package:flutter/cupertino.dart';
import 'package:marsroverflutter/domain/model/RoverPhotoConvertor.dart';
import 'package:marsroverflutter/domain/model/RoverPhotoUiModel.dart';
import 'package:marsroverflutter/service/mars_rover_photo_service.dart';
import 'package:marsroverflutter/service/model/RoverPhotoRemoteModel.dart';
import 'package:marsroverflutter/db/mars_rover_saved_local_dao.dart';

class PhotoProvider with ChangeNotifier {
  final PhotoService _photoService;

  final PhotoDao _photoDao;

  PhotoProvider(this._photoService, this._photoDao);

  RoverPhotoUiState _roverPhotoUiState = Loading();

  RoverPhotoUiState get roverPhotoUiState => _roverPhotoUiState;

  set roverPhotoUiState(RoverPhotoUiState newRoverPhotoUiState) {
    _roverPhotoUiState = newRoverPhotoUiState;
    notifyListeners();
  }

  Future getMarsRoverPhoto(String roverName, String sol) async {
    Future.delayed(Duration.zero, () {
      roverPhotoUiState = Loading();
    });
    List<int> allSavedIds = await _photoDao.allSavedIds(sol, roverName);
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
            allSavedIds.contains(photo.id)))
        .toList());
  }

  Future insertRoverPhoto(RoverPhotoUiModel roverPhotoUiModel) async {
    if (roverPhotoUiModel.isSaved) {
      _photoDao.remove(toDbModel(roverPhotoUiModel));
    } else {
      _photoDao.insert(toDbModel(roverPhotoUiModel));
    }
    roverPhotoUiState = Success((roverPhotoUiState as Success)
        .roverPhotoUiModelList
        .map((photo) => RoverPhotoUiModel(
        photo.id,
        photo.roverName,
        photo.imgSrc,
        photo.sol.toString(),
        photo.earthDate,
        photo.cameraFullName,
        roverPhotoUiModel.id == photo.id
            ? !photo.isSaved
            : photo.isSaved))
        .toList());
  }
}
