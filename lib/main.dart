import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import './screens/HabitPage.dart';
import './screens/OneHabitPage.dart';
import './screens/HomePage.dart';

// import './widget/Database.dart';

import 'class/habit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox("habits");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Habit>>? habits;
  List<Habit> _habits = [];
  var database;
  final List<Habit> _listOfHabits = [
    Habit(desc: 'wake up early', done: false, timeDone: 0, dateDone: []),
    Habit(desc: 'meditate', done: false, timeDone: 0, dateDone: []),
    Habit(desc: 'read a book', done: false, timeDone: 0, dateDone: []),
    Habit(desc: 'code', done: false, timeDone: 0, dateDone: []),
    Habit(desc: 'learn Arduino', done: false, timeDone: 0, dateDone: []),
  ];

  void addHabit(Habit habit) {
    final contactsBox = Hive.box('habits');
    // phương thức add() sẽ tự động tăng key lên +1 mỗi khi có liên hệ được thêm vào.
    contactsBox.add(habit);
  }

  void insertDummyData() {
    for (Habit habit in _listOfHabits) {
      addHabit(habit);
    }
  }

  // void refreshList() {
  //   setState(() {
  //     habits = database.getHabits();
  //   });
  // }

  // getList() async {
  //   _habits = await habits!;
  //   return _habits;
  // }

  void dispose() {
    Hive.box('habits').compact();
    Hive.close();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // insertDummyData();
  //   // database.initDb();
  //   // refreshList();
  // }

  @override
  Widget build(BuildContext context) {
    // Future<List<Habit>>? habits;
    // List<Habit> _habits = [];

    // insertDummyData() {
    //   for (Habit habit in _listOfHabits) {
    //     database.save(habit);
    //   }
    //   print('dummyDataInserted');
    // }

    // refreshList() {
    //   setState(() {
    //     habits = database.getHabits();
    //   });
    // }

    // getList() async {
    //   _habits = await habits!;
    //   return _habits;
    // }

    // database.initDb();
    // insertDummyData();
    // refreshList();
    // getList();
    // database.close();

    // getList();
    // refreshList();

    var habits = Hive.box('habits');
    habits.deleteAll(Iterable.empty());
    insertDummyData();

    Set<Habit> _doneHabit = Set.from(_habits);

    void _newHabit(String newDesc) {
      setState(() {
        // _habits.add(Habit(_habits.length - 1, newDesc, []));
        _habits
            .add(Habit(desc: newDesc, done: false, timeDone: 0, dateDone: []));
        addHabit(Habit(desc: newDesc, done: false, timeDone: 0, dateDone: []));

        // _doneHabit.add(Habit(_habits.length - 1, newDesc, []));
        // database.save(Habit(_habits.length - 1, newDesc, []));
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: HomePage(),
      routes: {
        '/habitPage': (context) => HabitPage(_habits, _newHabit, _doneHabit),
        '/oneHabitPage': ((context) => OneHabitPage()),
      },
    );
  }
}
