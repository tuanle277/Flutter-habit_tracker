import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit {
  // int? id;
  @HiveField(0)
  String desc;
  @HiveField(1)
  bool done;
  @HiveField(2)
  List<DateTime> dateDone;
  @HiveField(3)
  int timeDone;

  Habit(
      // int newId,
      // String newDesc
      // List<DateTime> newDateDone
      {
      // id = newId;
      required this.desc,
      required this.dateDone,
      required this.timeDone,
      required this.done});

  // factory Habit.fromMap(Map<String, dynamic> json) => Habit(
  //     // id = map['id'];
  //     desc: json['desc'],
  //     dateDone = json['dateDone'];
  //     done: false);

  // Map<String, dynamic> toMap1() {
  //   var map = <String, dynamic>{
  //     // 'id': id,
  //     'desc': desc,
  //     // 'dateDone': jsonEncode(dateDone),
  //   };
  //   return map;
  // }

  // Map<String, dynamic> toMap2(DateTime date) {
  //   var map = <String, dynamic>{
  //     // 'id': id,
  //     'dateDone': jsonEncode(date),
  //   };
  //   return map;
  // }

  // @override
  // String toString() {
  //   return 'Dog{id: $id, name: $desc, timeDone: $dateDone}';
  // }
}
