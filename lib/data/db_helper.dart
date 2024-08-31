import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/data/todo_model.dart';

class DbHelper
{
  DbHelper ._();
  static DbHelper getInstance() => DbHelper._();
  static final String TABLE_TODO ="todo";
  static final String COLUMN_TODO_SNO="sno";
  static final String COLUMN_TODO_TITLE="title";
  static final String COLUMN_TODO_DESC="desc";
  static final String COLUMN_TODO_COMPLETED="completed";
  Database?  tdb;

  Future<Database> getDB()
  async{
    if(tdb!=null)
      {
        return tdb!;
      }
    else{
      tdb ??= await openDB();
      return tdb!;
    }
  }

  Future<Database> openDB()
  async{
    Directory dir = await getApplicationDocumentsDirectory();
    String dbpath = join(dir.path,"todo.db");
     return await openDatabase(dbpath,onCreate: (db,version){
      db.execute(
        "Create Table $TABLE_TODO ( $COLUMN_TODO_SNO integer primary key autoincrement,"
                                       "$COLUMN_TODO_TITLE text,$COLUMN_TODO_DESC text,"
                                        "$COLUMN_TODO_COMPLETED integer) "
      );
    },version: 1);
  }

  Future<bool> addTodo({ required TodoModel newtodo})
  async{
      var tdb = await getDB();
      int rowsEffected = await tdb.insert(TABLE_TODO, newtodo.tomap());
      return rowsEffected>0;
  }

 Future<List<TodoModel>> fetchTodo()
 async{
   var tdb = await getDB();
   var data = await tdb.query(TABLE_TODO);
   List<TodoModel>mTodo =[];
   for(Map<String,dynamic> eachData in data)
   {
    mTodo.add(TodoModel.frommap(eachData));
   }
       return mTodo;
 }

  Future<bool> updateTodo({required TodoModel updatetodo , required int sno})
  async{
    var tdb = await getDB();
    int rowsEffected = await tdb.update(TABLE_TODO, updatetodo.tomap(),
             where: "$COLUMN_TODO_SNO = ?",whereArgs: ["$sno"]);
    return rowsEffected>0;
  }

  Future<bool> deleteTodo({required int sno})
  async{
    var tdb = await getDB();
     int rowsEffected = await tdb.delete(TABLE_TODO,
         where: "$COLUMN_TODO_SNO=?",whereArgs: ["$sno"]);
     return rowsEffected>0;
  }

}