import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../class/habit.dart';

import '../widget/HabitCell.dart';

class HabitPage extends StatefulWidget {
  final List<Habit> _listOfHabits;
  final Function _addHabit;
  final Set _done;

  HabitPage(this._listOfHabits, this._addHabit, this._done);

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  @override
  Widget build(BuildContext context) {
    List<DateTime> week = [];

    DateTime now = DateTime.now();
    int currentDay = now.weekday;
    DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay - 1));

    for (int i = 0; i < 7; i++) {
      week.add(firstDayOfWeek);
      firstDayOfWeek = firstDayOfWeek.add(Duration(days: 1));
    }

    final _descController = TextEditingController();

    Size mediaQuery = MediaQuery.of(context).size;

    void _newHabit() {
      if (_descController.text.isNotEmpty) {
        widget._addHabit(
          _descController.text,
        );
        _descController.text = "";
      } else {
        return;
      }
      Navigator.of(context).pop();
    }

    void _addNewHabit(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            color: Colors.deepPurple,
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: "Enter a habit!",
                      suffixIcon: IconButton(
                        onPressed: _descController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    controller: _descController,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: _newHabit,
                      child: const Text(
                        "Add habit",
                      ),
                    ))
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => _addNewHabit(context),
        child: const Icon(
          Icons.add,
          shadows: <Shadow>[Shadow(color: Colors.white, blurRadius: 4.0)],
        ),
      ),
      backgroundColor: const Color(0xff131b26),
      body: Column(
        children: [
          SizedBox(
            height: mediaQuery.height * 0.06,
            width: mediaQuery.width,
          ),
          Container(
            // duration: const Duration(seconds: 1),
            // curve: Curves.fastOutSlowIn,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: mediaQuery.height * 0.26,
            width: mediaQuery.width * 9 / 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple[200]!,
                    Colors.deepPurple[400]!,
                    Colors.deepPurple[600]!,
                  ]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mediaQuery.height / 15),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Hi, ",
                                  style: TextStyle(
                                      fontSize: 26, color: Colors.grey[400]),
                                ),
                                const TextSpan(
                                  text: "Kevin",
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget._done.isEmpty
                                ? "You did everything! congrats!"
                                : "You have ${widget._done.length} thing(s) to do today!",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.transparent,
                        elevation: 50.0,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20),
                          height: 90,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          child: Image.asset(
                            "assets/icons/calendar.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.02),
          SizedBox(
            height: mediaQuery.height * 0.15,
            width: mediaQuery.width,
            child: Container(
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xff1b232e),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: week.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, f) {
                  int day = week[f].day;
                  Color color;
                  if (day == DateTime.now().day) {
                    color = const Color(0xff727be8);
                  } else if (day < DateTime.now().day) {
                    color = const Color.fromRGBO(255, 93, 98, 154);
                  } else {
                    color = const Color(0xff131b26);
                  }
                  return FittedBox(
                    child: Container(
                      width: 90,
                      height: 90,
                      margin: const EdgeInsets.only(right: 15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${week[f].day}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: day == DateTime.now().day
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: day == DateTime.now().day
                                  ? Colors.white
                                  : Colors.grey[500],
                            ),
                          ),
                          Text(
                            DateFormat('EE').format(week[f]),
                            style: TextStyle(
                                color: day == DateTime.now().day
                                    ? Colors.white
                                    : Colors.grey[700],
                                fontWeight: day == DateTime.now().day
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
              top: 20,
            ),
            height: mediaQuery.height / 2,
            width: mediaQuery.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Your Habits ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      TextSpan(
                        text: " " + widget._listOfHabits.length.toString(),
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: WatchBoxBuilder(
                    box: Hive.box("habits"),
                    builder: (context, habitList) {
                      return ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (
                          context,
                          index,
                        ) {
                          final habit = habitList.getAt(index) as Habit;
                          return HabitCell(habit, widget._done);
                        },
                        itemCount: habitList.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
