import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{
  DBhelper._();
  static final DBhelper instance = DBhelper._();
  static Database? _database;

  Future<Database> get database async{
    if(_database!=null) return _database!;
    _database=await initDB();
    return _database!;
  }

  Future<Database> initDB() async{
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join( databaseDirPath,"currency.db");
    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db,version) async{
        await db.execute('''CREATE TABLE currency(id INTEGER PRIMARY KEY AUTOINCREMENT,
        input TEXT NOT NULL,
        result NUMBER NOT NULL
        )''');
      }
    );
  }
  Future<void> insert(String input,double result)async{
    final db=await instance.database;
    await db.insert('histroy', {'input in USD':input,'result in INR':result});
    print(db);
    print("120");
  }
  Future<List<Map<String,dynamic>>> getHistory() async{
    final db=await instance.database;
    return await db.query('history',orderBy: 'id DESC');
  }
  Future<void> clearHistory() async{
    final db= await instance.database;
    await db.delete('history');
  }
}