import 'dart:convert';

class Habit {
  int? id;
  late String desc;
  late List<DateTime> dateDone;
  late int timeDone;
  late bool done;

  Habit(int newId, String newDesc, List<DateTime> newDateDone) {
    id = newId;
    desc = newDesc;
    dateDone = newDateDone;
    timeDone = dateDone.length;
    done = false;
  }

  Habit.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    desc = map['desc'];
    dateDone = map['dateDone'];
  }

  Map<String, dynamic> toMap1() {
    var map = <String, dynamic>{
      'id': id,
      'desc': desc,
      // 'dateDone': jsonEncode(dateDone),
    };
    return map;
  }

  Map<String, dynamic> toMap2(DateTime date) {
    var map = <String, dynamic>{
      'id': id,
      'dateDone': jsonEncode(date),
    };
    return map;
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $desc, timeDone: $dateDone}';
  }
}
