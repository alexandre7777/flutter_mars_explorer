class MarsRoverSavedLocalModel {
  final int roverPhotoId;
  final String roverName;
  final String imgSrc;
  final String sol;
  final String earthDate;
  final String cameraFullName;

  MarsRoverSavedLocalModel(this.roverPhotoId, this.roverName, this.imgSrc,
      this.sol, this.earthDate, this.cameraFullName);

  Map<String, dynamic> toMap() {
    return {
      'roverPhotoId': roverPhotoId,
      'roverName': roverName,
      'imgSrc': imgSrc,
      'sol': sol,
      'earthDate': earthDate,
      'cameraFullName': cameraFullName,
    };
  }
}
