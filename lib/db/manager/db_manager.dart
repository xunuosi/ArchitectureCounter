import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:architecture_counter/db/model/bean.dart';
import 'package:logger/logger.dart';

class db_manager {
  static Future<Database> initDatabase(String dbName, String tableName) async {
    var database = openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        String sql = "CREATE TABLE " + tableName + "(" + DbField.KEY_ID + " INTEGER PRIMARY KEY, " +
            DbField.KEY_BACK_CONSTANT + " REAL, " +
            DbField.KEY_FRONT_CONSTANT + " REAL, " +
            DbField.KEY_BACK_POINT_NUM + " REAL, " +
            DbField.KEY_BACK_POINT_DISTANCE + " REAL, " +
            DbField.KEY_BACK_BLACK_NUM + " REAL, " +
            DbField.KEY_BACK_RED_NUM + " REAL, " +
            DbField.KEY_FRONT_POINT_NUM + " REAL, " +
            DbField.KEY_FRONT_POINT_DISTANCE + " REAL, " +
            DbField.KEY_FRONT_BLACK_NUM + " REAL, " +
            DbField.KEY_FRONT_RED_NUM + " REAL" +")";
        var logger = Logger(
          printer: PrettyPrinter(),
        );
        logger.d("Create table:[%s]", sql);
        return db.execute(
          sql,
        );
      },
      version: 1,
    );

    return database;
  }
}
