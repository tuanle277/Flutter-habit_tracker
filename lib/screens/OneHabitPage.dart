import 'package:flutter/material.dart';

import '../class/habit.dart';

class OneHabitPage extends StatefulWidget {
  @override
  State<OneHabitPage> createState() => _OneHabitPageState();
}

// whatever is 3 was widget.timeDone
class _OneHabitPageState extends State<OneHabitPage> {
  @override
  Widget build(BuildContext context) {
    final habit = ModalRoute.of(context)!.settings.arguments as Habit;
    final _descController = TextEditingController();

    showAlertDialog(BuildContext context) {
      Widget okButton = ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
        ),
        child: const Text("OK"),
        onPressed: () {
          if (_descController.text.isNotEmpty) {
            habit.desc = _descController.text;
            Navigator.of(context).pop();
          }
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text(
          "Change description name",
          style: TextStyle(fontSize: 20),
        ),
        content: TextField(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.deepPurple,
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
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      ).then((value) => {});
    }

    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff131b26),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: mediaQuery.height * 0.08),
          SizedBox(
            height: mediaQuery.height * 0.1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: mediaQuery.width * 7 / 9,
                    child: Text(
                      habit.desc.replaceFirst(
                          habit.desc[0], habit.desc[0].toUpperCase()),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 31,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[700]!,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => showAlertDialog(context),
                    child: Icon(
                      Icons.edit,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "3 from 7 this week",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 21,
              ),
            ),
          ),
          const SizedBox(
            height: 11.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: LinearProgressIndicator(
              value: 3 / 7,
              backgroundColor: const Color(0xff1c232d),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xff701bff),
              ),
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Strength",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 21,
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "${(3 / 7 * 100).toInt()}%",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 31,
                    ),
                  ),
                ),
                CircularProgressIndicator(
                  value: 3 / 7,
                  backgroundColor: Colors.grey[600],
                  valueColor: const AlwaysStoppedAnimation(
                    Color(0xff701bff),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Container(
              color: Colors.grey[500],
              height: 0.8,
            ),
          ),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (f) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        f == 0
                            ? "Repeat"
                            : f == 1
                                ? "Streak"
                                : "Best",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        f == 0
                            ? "Every Day"
                            : f == 1
                                ? "8 Days"
                                : "11 Days",
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Transform.rotate(
              angle: 3.14,
              child: CustomPaint(
                child: MyBezierCurve(),
                painter: CurvePath(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = const Color(0xff701dff);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;

    var path = Path();

    path.moveTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);

    path.moveTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyBezierCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ClippingClass(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: const [
              Color(0xff221b4c),
              Color(0xff151b2b),
            ],
          ),
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);

    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);

    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
