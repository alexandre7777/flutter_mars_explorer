import 'package:flutter/material.dart';
import 'package:marsroverflutter/data/saved_photo_provider.dart';
import 'package:marsroverflutter/domain/model/rover_photo_ui_model.dart';
import 'package:marsroverflutter/screens/photo.dart';
import 'package:provider/provider.dart';

import 'mars_rover_bottom_navigation_bar.dart';

class SavedList extends StatefulWidget {
  static const routeName = '/';

  SavedList({super.key, required this.title});

  final String title;

  SavedPhotoProvider? savedPhotoProvider;

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  void initState() {
    super.initState();
    widget.savedPhotoProvider = context.read<SavedPhotoProvider>();
    widget.savedPhotoProvider?.getAllSavedPhoto();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<SavedPhotoProvider>(
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
                        .roverPhotoUiModelList[index],
                        () => widget.savedPhotoProvider?.removeRoverPhoto(
                        (photoState.roverPhotoUiState as Success)
                            .roverPhotoUiModelList[index]))),
            Loading() => const CircularProgressIndicator(),
            Error() => const CircularProgressIndicator(),
          }),
      bottomNavigationBar: marsRoverBottomNavigationBar(context),
    );
  }
}
