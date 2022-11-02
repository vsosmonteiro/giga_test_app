import 'package:giga_test_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

 abstract class SqLiteService {


  static Future<Database> initDB() async {
    final String database_name = 'Users.db';
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, database_name);

    return await openDatabase(path, onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE users(email STRING PRIMARY KEY,gender STRING,title STRING,first_name STRING,last_name STRING,picture_large STRING,picture_medium STRING,thumbnail STRING)');
    }, version: 1);
  }

  static Future<void> insertUser(Database db, User results) async {
    await db.rawInsert(
        'INSERT OR REPLACE INTO users(email,gender,title,first_name,last_name,picture_large,picture_medium,thumbnail) VALUES(\$1,\$2,\$3,\$4,\$5,\$6,\$7,\$8)',
        [
          results.email,
          results.gender,
          results.name!.title,
          results.name!.first,
          results.name!.last,
          results.picture!.large,
          results.picture!.medium,
          results.picture!.thumbnail
        ]);
  }

  static Future<List<Map<String, dynamic>>> getUsers(
      Database db, String gender , int offset) async {
    var newoffset = offset * 20;
    String query = "SELECT * FROM users WHERE gender = '$gender' LIMIT 20 OFFSET $newoffset";
    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    //print(maps);
    return maps;
  }

  static Future<void> deleteDB(Database db) async {
    await db.delete('users');
  }

  static Future<void> deleteUser(Database db, String email) async {
    String query = 'DELETE FROM users WHERE email =' + "'" + email + "';";
    await db.rawDelete(query);
  }
}
