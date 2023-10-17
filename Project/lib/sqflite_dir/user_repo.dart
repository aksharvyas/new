import 'package:project/sqflite_dir/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserRepo{

  void createTable(Database? db){
    db?.execute("CREATE TABLE IF NOT EXISTS CATEGORYTABLE(id INTEGER PRIMARY KEY AUTOINCREMENT,CATEGORYNAME TEXT)");

  }
    Future<List<Map<String, dynamic>>> getUsers(Database? db)async{
      final  List<Map<String, dynamic>> maps = await db!.query('CATEGORYTABLE');
    return maps;
    }


}