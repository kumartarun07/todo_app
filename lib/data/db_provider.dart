import 'package:flutter/foundation.dart';
import 'package:to_do_app/data/db_helper.dart';
import 'package:to_do_app/data/todo_model.dart';

class DbProvider extends ChangeNotifier
{
  DbHelper dbHelper;
  DbProvider({required this.dbHelper});
  List<TodoModel>_mTodo =[];

   void addTodo(TodoModel newtodo)
   async{
     bool check = await dbHelper.addTodo(newtodo: newtodo);
          if(check)
            {
              _mTodo = await dbHelper.fetchTodo();
               notifyListeners();
            }
   }

   void updateTodo(TodoModel updateTodo,int sno)
   async{
     bool check = await dbHelper.updateTodo(updatetodo: updateTodo, sno: sno);
     if(check)
       {
         _mTodo = await dbHelper.fetchTodo();
         notifyListeners();
       }
   }

   void deleteTodo(int sno)
   async{
     bool check = await dbHelper.deleteTodo(sno: sno);
     if(check)
       {
         _mTodo = await dbHelper.fetchTodo();
         notifyListeners();
       }

   }

  void getintialzeTodo()
  async{
      _mTodo = await dbHelper.fetchTodo();
      notifyListeners();
  }

    List<TodoModel> getTodo() => _mTodo;


}