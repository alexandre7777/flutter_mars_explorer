import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:marsroverflutter/data/ManifestProvider.dart';
import 'package:marsroverflutter/data/PhotoProvider.dart';
import 'package:marsroverflutter/data/SavedPhotoProvider.dart';
import 'package:marsroverflutter/db/mars_rover_saved_local_dao.dart';
import 'package:marsroverflutter/screens/photo_list.dart';
import 'package:marsroverflutter/screens/rover_list.dart';
import 'package:marsroverflutter/screens/manifest_list.dart';
import 'package:marsroverflutter/screens/saved_list.dart';
import 'package:marsroverflutter/service/mars_rover_manifest_service.dart';
import 'package:marsroverflutter/service/mars_rover_photo_service.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'photo_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE photos(roverPhotoId INTEGER PRIMARY KEY, roverName TEXT, imgSrc TEXT, sol TEXT, earthDate TEXT, cameraFullName TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => ManifestProvider(ManifestService())),
    ChangeNotifierProvider(
        create: (context) => PhotoProvider(PhotoService(), PhotoDao(database))),
    ChangeNotifierProvider(
        create: (context) => SavedPhotoProvider(PhotoDao(database)))
  ], child: const MarsRoverExplorer()));
}

GoRouter router() {
  return GoRouter(
    routes: [
      GoRoute(
        path: RoverList.routeName,
        builder: (context, state) =>
            const RoverList(title: "Mars Rover Explorer"),
        routes: [
          GoRoute(
              path: 'manifest/:rovername',
              name: 'manifest',
              builder: (context, state) {
                return ManifestList(
                    title: "Mars Rover Explorer",
                    roverName:
                        state.pathParameters["rovername"] ?? 'not found');
              }),
          GoRoute(
              path: 'photo/:name',
              name: 'photo',
              builder: (context, state) {
                return PhotoList(
                    title: "Mars Rover Explorer",
                    roverName: state.pathParameters["name"] ?? 'not found',
                    sol: state.queryParameters["sol"] ?? 'not found');
              }),
          GoRoute(
              path: 'saved',
              name: 'saved',
              builder: (context, state) {
                return SavedList(title: "Mars Rover Explorer");
              })
        ],
      ),
    ],
  );
}

class MarsRoverExplorer extends StatelessWidget {
  const MarsRoverExplorer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Mars Rover Explorer',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router());
  }
}
