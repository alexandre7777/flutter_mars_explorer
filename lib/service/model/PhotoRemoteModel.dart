import 'package:marsroverflutter/service/model/CameraRemoteModel.dart';
import 'package:marsroverflutter/service/model/RoverRemoteModel.dart';

class PhotoRemoteModel {
  final CameraRemoteModel camera;
  final String earthDate;
  final int id;
  final String imgSrc;
  final RoverRemoteModel rover;
  final int sol;

  const PhotoRemoteModel(
      {required this.camera,
      required this.earthDate,
      required this.id,
      required this.imgSrc,
      required this.rover,
      required this.sol});

  factory PhotoRemoteModel.fromJson(Map<String, dynamic> json) {
    return PhotoRemoteModel(
        camera: CameraRemoteModel.fromJson(json['camera']),
        earthDate: json['earth_date'],
        id: json['id'],
        imgSrc: json['img_src'],
        rover: RoverRemoteModel.fromJson(json['rover']),
        sol: json['sol']);
  }
}
