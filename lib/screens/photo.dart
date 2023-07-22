import 'package:flutter/material.dart';
import 'package:marsroverflutter/data/PhotoProvider.dart';
import 'package:marsroverflutter/domain/model/RoverPhotoUiModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mars_rover_bottom_navigation_bar.dart';

class Photo extends StatelessWidget {
  final RoverPhotoUiModel roverPhotoUiModel;

  final GestureTapCallback gestureTapCallback;

  const Photo(this.roverPhotoUiModel, this.gestureTapCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: gestureTapCallback,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Row(children: [
                          if (roverPhotoUiModel.isSaved)
                            const Icon(Icons.save)
                          else
                            const Icon(Icons.save_outlined),
                          Text(roverPhotoUiModel.roverName,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))
                        ])),
                    Image.network(roverPhotoUiModel.imgSrc),
                    Text(
                        AppLocalizations.of(context)!
                            .sol(roverPhotoUiModel.sol),
                        style: const TextStyle(fontSize: 12)),
                    Text(
                        AppLocalizations.of(context)!
                            .earthDate(roverPhotoUiModel.earthDate),
                        style: const TextStyle(fontSize: 12)),
                    Text(roverPhotoUiModel.cameraFullName,
                        style: const TextStyle(fontSize: 12))
                  ]),
            ),
          ),
        ));
  }
}
