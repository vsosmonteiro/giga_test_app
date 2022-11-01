import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqLiteService {
  final String database_name = 'Users.db';

  Future<Database> initDB() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, database_name);

    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE users(email STRING PRIMARY KEY,gender STRING,title STRING,first_name STRING,last_name STRING,picture_large STRING,picture_medium STRING,picture_small STRING,thumbnail STRING)');
      },
    );
  }
}
