import 'package:marsroverflutter/domain/model/RoverManifestUiModel.dart';
import 'package:marsroverflutter/service/model/RoverManifestRemoteModel.dart';

Success toUiModel(RoverManifestRemoteModel roverManifestRemoteModel) {
   final roverManifestUiModelList = roverManifestRemoteModel.photoManifest.photos
       .map((photo) => RoverManifestUiModel(
       photo.sol.toString(),
       photo.earthDate,
       photo.totalPhotos.toString()))
       .toList();

   roverManifestUiModelList.sort((a, b) => b.earthDate.compareTo(a.earthDate));

  return Success(roverManifestUiModelList);
}
