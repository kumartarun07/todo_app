import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/db_provider.dart';
import 'package:to_do_app/data/todo_model.dart';
import 'package:to_do_app/ui/addnote_page.dart';

class HomePage extends StatefulWidget
{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DbProvider>().getintialzeTodo();
  }
  @override
  Widget build(BuildContext context)
  {
  ///
   return  Scaffold(backgroundColor: Colors.white,
     appBar: AppBar(backgroundColor: Colors.grey,
       title: Text("My Todo's",style:
       TextStyle(fontSize: 25,color: Colors.white),),centerTitle: true,),
     body: Consumer<DbProvider>(builder: (_,provide,__){
       List<TodoModel>mTodo = provide.getTodo();
       return mTodo.isNotEmpty? ListView.builder(
           itemCount:mTodo.length, //mTodo.length,
           itemBuilder: (_,index){
             return Stack(
               children: [ Positioned(right: 10,top: 20,
                 child: Row(
                   children: [
                   IconButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> AddnotePage(isupdate: true,
                     title: mTodo[index].title,desc: mTodo[index].desc,sno: mTodo[index].sno!,
                     )));
                   }, icon:Icon(Icons.edit,size: 30,)),
                   IconButton(onPressed: (){
                     context.read<DbProvider>().deleteTodo(mTodo[index].sno!);
                   }, icon:Icon(Icons.delete,size: 30,color: Colors.red,)),
                 ],),
               ),
                 Container(width: 350,
                   child: CheckboxListTile(controlAffinity: ListTileControlAffinity.leading,
                      value: mTodo[index].completed==1,
                     onChanged: (value){
                       var updatetodo = TodoModel(sno: mTodo[index].sno,
                           title: mTodo[index].title,
                           desc: mTodo[index].desc, completed: value! ? 1 : 0);
                         provide.updateTodo(updatetodo,mTodo[index].sno!);
                     },
                     title: Text('${mTodo[index].title}',
                       style: TextStyle(decoration:mTodo[index].completed==1 ?
                       TextDecoration.lineThrough:TextDecoration.none),),
                     subtitle: Text('${mTodo[index].desc}',style: TextStyle(decoration: mTodo[index].completed==1 ?
                     TextDecoration.lineThrough:TextDecoration.none),),
                   ),
                 ),
               ],
             );
           }):Center(child: Text("Not Notes Found",style: TextStyle(fontSize: 20),));
     },),
     floatingActionButton: FloatingActionButton(onPressed: ()
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>AddnotePage()));
     },
       child: Icon(Icons.add,size: 35,color: Colors.black,),backgroundColor: Colors.white,
     ),
   );
  }
}
