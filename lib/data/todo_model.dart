import 'package:to_do_app/data/db_helper.dart';

class TodoModel
{
  int? sno;
  String title;
  String desc;
  int completed = 0;

  TodoModel({this.sno,required this.title, required this.desc,required this.completed});

  factory TodoModel.frommap(Map<String,dynamic>map) => TodoModel(
      sno: map[DbHelper.COLUMN_TODO_SNO],
      title: map[DbHelper.COLUMN_TODO_TITLE] , 
      desc: map[DbHelper.COLUMN_TODO_DESC], 
      completed: map[DbHelper.COLUMN_TODO_COMPLETED],
  );
  
  Map<String,dynamic>tomap() => {
     DbHelper.COLUMN_TODO_TITLE : title,
    DbHelper.COLUMN_TODO_DESC : desc,
    DbHelper.COLUMN_TODO_COMPLETED: completed
  };

}