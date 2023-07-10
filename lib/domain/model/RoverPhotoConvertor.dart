
import 'package:marsroverflutter/db/mars_rover_saved_local_model.dart';
import 'RoverPhotoUiModel.dart';

MarsRoverSavedLocalModel toDbModel(RoverPhotoUiModel roverPhotoUiModel) {
  return MarsRoverSavedLocalModel(
      roverPhotoUiModel.id,
      roverPhotoUiModel.roverName,
      roverPhotoUiModel.imgSrc,
      roverPhotoUiModel.sol,
      roverPhotoUiModel.earthDate,
      roverPhotoUiModel.cameraFullName
  );
}