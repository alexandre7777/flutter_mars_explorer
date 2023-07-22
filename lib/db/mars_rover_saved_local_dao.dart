
import 'package:sqflite/sqflite.dart';

import 'mars_rover_saved_local_model.dart';

class PhotoDao {

  final Future<Database> database;

  PhotoDao(this.database);


  // Define a function that inserts dogs into the database
  Future<void> insert(MarsRoverSavedLocalModel marsRoverSavedLocalModel) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'photos',
      marsRoverSavedLocalModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Define a function that inserts dogs into the database
  Future<void> remove(MarsRoverSavedLocalModel marsRoverSavedLocalModel) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.delete(
      'photos',
      // Use a `where` clause to delete a specific dog.
      where: 'roverPhotoId = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [marsRoverSavedLocalModel.roverPhotoId],
    );
  }

  Future<List<int>> allSavedIds(String sol, String roverName) async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.rawQuery("SELECT roverPhotoId FROM photos WHERE sol = $sol AND roverName = '$roverName'");

    return List.generate(maps.length, (i) {
      return maps[i]['roverPhotoId'];
    });
  }

  Future<List<MarsRoverSavedLocalModel>> getAllSavedPhoto() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('photos');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return MarsRoverSavedLocalModel(
        maps[i]['roverPhotoId'],
        maps[i]['roverName'],
        maps[i]['imgSrc'],
        maps[i]['sol'],
        maps[i]['earthDate'],
        maps[i]['cameraFullName'],
      );
    });
  }
}
