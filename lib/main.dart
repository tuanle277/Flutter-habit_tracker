import 'package:flutter/material.dart';
import 'dart:convert';

import './screens/HabitPage.dart';
import './screens/OneHabitPage.dart';
import './screens/HomePage.dart';

import './widget/Database.dart';

import './class/Habit.dart';

void main() => runApp(MyApp());

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
    Habit(0, 'wake up early', []),
    Habit(1, 'meditate', []),
    Habit(2, 'read a book', []),
    Habit(3, 'code', []),
    Habit(4, 'learn Arduino', []),
  ];
  void insertDummyData() {
    for (Habit habit in _listOfHabits) {
      database.save(habit);
    }
    print('dummyDataInserted');
  }

  void refreshList() {
    setState(() {
      habits = database.getHabits();
    });
  }

  getList() async {
    _habits = await habits!;
    return _habits;
  }

  @override
  void initState() {
    super.initState();
    database = DBHelper();
    database.initDb();
    insertDummyData();
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

    getList();
    refreshList();

    print(_habits.length);
    for (Habit habit in _habits) {
      print(habit.desc);
    }
    print("this runs");

    Set<Habit> _doneHabit = Set.from(_habits);

    void _newHabit(String newDesc) {
      setState(() {
        _habits.add(Habit(_habits.length - 1, newDesc, []));
        _doneHabit.add(Habit(_habits.length - 1, newDesc, []));
        database.save(Habit(_habits.length - 1, newDesc, []));
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
