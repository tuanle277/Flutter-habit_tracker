import 'package:flutter/material.dart';

import '../class/habit.dart';

class HabitCell extends StatefulWidget {
  final Habit habit;
  final Set _done;

  HabitCell(this.habit, this._done);

  @override
  State<HabitCell> createState() => _HabitCellState();
}

class _HabitCellState extends State<HabitCell> {
  void didTheHabit() {
    setState(() {
      if (widget.habit.done) {
        widget.habit.done = false;
        widget.habit.dateDone.remove(DateTime.now());
        widget._done.add(widget.habit);
        widget.habit.timeDone--;
      } else {
        widget.habit.done = true;
        widget.habit.dateDone.add(DateTime.now());
        widget._done.remove(widget.habit);
        widget.habit.timeDone++;
      }
    });
  }

// whatever is 3 was widget.habit.timeDone.toDouble()
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.pushNamed(context, '/oneHabitPage',
        arguments: widget.habit);
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      widget.habit.desc = result as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final int id = 0;
    Size mediaQuery = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => _awaitReturnValueFromSecondScreen(context),
      child: Card(
        color: const Color(0xff131b26),
        child: SizedBox(
          height: mediaQuery.height * 0.13,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    splashColor: const Color(0xff727be8),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.habit.done
                            ? Colors.deepPurple
                            : Colors.transparent,
                        border: widget.habit.done
                            ? const Border()
                            : Border.all(
                                color: Colors.grey,
                              ),
                      ),
                      child: Icon(
                        Icons.check,
                        color:
                            widget.habit.done ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.habit.desc,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          ' ${widget.habit.timeDone} out of 7 days this week',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: LinearProgressIndicator(
                  minHeight: 5,
                  value: widget.habit.timeDone / 7,
                  backgroundColor: const Color(0xff1c232d),
                  valueColor: const AlwaysStoppedAnimation(
                    Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
