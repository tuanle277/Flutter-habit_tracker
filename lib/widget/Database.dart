// import 'dart:async';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import '../class/Habit.dart';
// import 'package:path_provider/path_provider.dart';

// class DBase {
//   void data() async {
//     // Avoid errors caused by flutter upgrade.
//     // Importing 'package:flutter/widgets.dart' is required.
//     WidgetsFlutterBinding.ensureInitialized();
//     // Open the database and store the reference.
//     final database = openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//       join(await getDatabasesPath(), 'habit_database.db'),
//       // When the database is first created, create a table to store dogs.
//       onCreate: (db, version) {
//         // Run the CREATE TABLE statement on the database.
//         return db.execute(
//           "CREATE TABLE habits(id INTEGER PRIMARY KEY, desc TEXT, dateDone JSON DEFAULT('[]'))",
//         );
//       },
//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.
//       version: 1,
//     );

// // Define a function that inserts dogs into the database
//     Future<void> insertHabit(Habit habit) async {
//       // Get a reference to the database.
//       final db = await database;
//       //
//       // In this case, replace any previous data.
//       await db.insert(
//         'habits',
//         habit.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }

//     Future<List<Habit>> habits() async {
//       // Get a reference to the database.
//       final db = await database;
//       final List<Map<String, dynamic>> maps = await db.query('habits');

//       return List.generate(maps.length, (i) {
//         return Habit(
//           maps[i]['id'],
//           maps[i]['desc'],
//           maps[i]['timeDone'],
//         );
//       });
//     }

//     Future<void> updateDog(Habit habit) async {
//       // Get a reference to the database.
//       final db = await database;

//       await db.update(
//         'habits',
//         habit.toMap(),
//         where: 'id = ?',
//         whereArgs: [habit.id],
//       );
//     }

//     Future<void> deleteDog(int id) async {
//       // Get a reference to the database.
//       final db = await database;

//       // Remove from the database.
//       await db.delete(
//         'habits',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//     }
//   }
// }

// class DBHelper {
//   static Database? _db;
//   static const String ID = 'id';
//   static const String DESC = 'desc';
//   static const String DATEDONE = 'dateDone';
//   static const String TABLE1 = 'Habits';
//   static const String TABLE2 = 'DatesDone';
//   static const String DB_NAME = 'habit_database.db';

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db!;
//     }
//     _db = await initDb();
//     return _db!;
//   }

//   Future<void> deleteDatabase(String path) =>
//       databaseFactory.deleteDatabase(path);
//   initDb() async {
//     // init db
//     print("init db");
//     // String databasesPath = await getDatabasesPath();
//     // String path = join(databasesPath, DB_NAME);

//     io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, DB_NAME);
//     if (await databaseExists(path)) {
//       deleteDatabase(path);
//     }
//     print("table created");

//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   _onCreate(Database db, int version) async {
//     print("table created");
//     //tạo database
//     await db
//         .execute("CREATE TABLE $TABLE1 ($ID INTEGER PRIMARY KEY, $DESC TEXT)");
//     await db.execute("CREATE TABLE $TABLE2 ($ID INTEGER PRIMARY KEY)");
//   }

//   void _onUpgrade(Database db) async {
//     await db.execute("ALTER TABLE $TABLE2 ADD COLUMN newCol TEXT;");
//   }

//   Future<Habit> save(Habit habit) async {
//     // insert employee vào bảng đơn giản
//     print("insert db");
//     var dbHabit = await db;
//     habit.id = await dbHabit.insert(TABLE1, habit.toMap1());
//     for (DateTime date in habit.dateDone) {
//       habit.id = await dbHabit.insert(TABLE2, habit.toMap2(date));
//     }
//     return habit;
//     /*
//     await dbClient.transaction((txn) async {
//       var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
//       return await txn.rawInsert(query); //các bạn có thể sử dụng rawQuery nếu truy vẫn phức tạp để thay thế cho các phước thức có sẵn của lớp Database.
//     });
//     */
//   }

//   Future<List<Habit>> getHabits() async {
//     print("get db");

//     //get list đơn giản
//     var dbHabit = await db;
//     List<Map> maps1 = await dbHabit.query(TABLE1, columns: [ID, DESC]);
//     List<Map> maps2 = await dbHabit.query(TABLE2, columns: [ID, DATEDONE]);
//     //List<Map> maps = await dbHabit.rawQuery("SELECT * FROM $TABLE");
//     List<Habit> habits = [];
//     if (maps1.isNotEmpty) {
//       for (int i = 0; i < maps1.length; i++) {
//         habits.add(Habit.fromMap(maps1[i]));
//         habits[i].dateDone = Habit.fromMap(maps2[i]).dateDone;
//       }
//     }
//     return habits;
//   }

//   // Future<int> delete(int id) async {
//   //   // xóa
//   //   var dbHabit = await db;
//   //   return await dbHabit.delete(TABLE1,
//   //       where: '$ID = ?',
//   //       whereArgs: [id]); //where - xóa tại ID nào, whereArgs - argument là gì?
//   // }

//   // Future<int> update(Habit habit) async {
//   //   var dbHabit = await db;
//   //   return await dbHabit
//   //       .update(TABLE, habit.toMap(), where: '$ID = ?', whereArgs: [habit.id]);
//   // }

//   Future close() async {
//     //close khi không sử dụng
//     var dbHabit = await db;
//     dbHabit.close();
//   }
// }
