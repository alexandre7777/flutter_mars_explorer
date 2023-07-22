import 'package:flutter/material.dart';
import 'package:marsroverflutter/data/PhotoProvider.dart';
import 'package:marsroverflutter/domain/model/RoverPhotoUiModel.dart';
import 'package:marsroverflutter/screens/error_screen.dart';
import 'package:marsroverflutter/screens/photo.dart';
import 'package:provider/provider.dart';

import 'loading_screen.dart';
import 'mars_rover_bottom_navigation_bar.dart';

class PhotoList extends StatefulWidget {
  static const routeName = 'photo';
  static const fullPath = '/$routeName';

  PhotoList(
      {super.key,
      required this.title,
      required this.roverName,
      required this.sol});

  final String title;

  final String roverName;

  final String sol;

  PhotoProvider? photoProvider;

  @override
  State<PhotoList> createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  @override
  void initState() {
    super.initState();
    widget.photoProvider = context.read<PhotoProvider>();
    widget.photoProvider?.getMarsRoverPhoto(widget.roverName, widget.sol);
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
                            .roverPhotoUiModelList[index],
                        () => widget.photoProvider?.insertRoverPhoto(
                            (photoState.roverPhotoUiState as Success)
                                .roverPhotoUiModelList[index]))),
                Loading() => const LoadingScreen(),
                Error() => const ErrorScreen(),
              }),
      bottomNavigationBar: marsRoverBottomNavigationBar(context),
    );
  }
}
