import 'package:flutter/material.dart';
import 'package:marsroverflutter/data/PhotoProvider.dart';
import 'package:marsroverflutter/domain/model/RoverPhotoUiModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhotoList extends StatefulWidget {
  static const routeName = 'photo';
  static const fullPath = '/$routeName';

  const PhotoList(
      {super.key,
      required this.title,
      required this.roverName,
      required this.sol});

  final String title;

  final String roverName;

  final String sol;

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  void initState() {
    super.initState();
    var manifestProvider = context.read<PhotoProvider>();
    manifestProvider.getMarsRoverPhoto(widget.roverName, widget.sol);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<PhotoProvider>(
          builder: (context, photoState, child) =>
              switch (photoState.roverPhotoUiState) {
                Success() => ListView.builder(
                    itemCount: (photoState.roverPhotoUiState as Success)
                        .roverPhotoUiModelList
                        .length,
                    cacheExtent: 20.0,
                    controller: ScrollController(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (context, index) => Photo(
                        (photoState.roverPhotoUiState as Success)
                            .roverPhotoUiModelList[index])),
                Loading() => const CircularProgressIndicator(),
                Error() => const CircularProgressIndicator(),
              }),
    );
  }
}

class Photo extends StatelessWidget {
  final RoverPhotoUiModel roverPhotoUiModel;

  const Photo(this.roverPhotoUiModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
                width: double.infinity,
                child: Text(roverPhotoUiModel.roverName,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold))),
            Image.network(roverPhotoUiModel.imgSrc),
            Text(AppLocalizations.of(context)!.sol(roverPhotoUiModel.sol),
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
    );
  }
}
