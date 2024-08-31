import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/db_provider.dart';
import 'package:to_do_app/data/todo_model.dart';

class AddnotePage extends StatelessWidget 
{
  int sno,completed;
  String title,desc;
  bool isupdate;
  AddnotePage({this.completed=0,this.sno=0,this.title="",this.desc="",this.isupdate=false});

  TextEditingController titletController =TextEditingController();
  TextEditingController descController =TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    if(isupdate)
      {
        titletController.text = title;
        descController.text = desc;
      }

    return Consumer<DbProvider>(builder: (_,provider,__){
      List<TodoModel>mTOdo=context.read<DbProvider>().getTodo();
      return Scaffold(backgroundColor: Colors.grey,
        appBar: AppBar(toolbarHeight: 100,
          backgroundColor: Colors.primaries[(Random().nextInt(Colors.primaries.length))],centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(40))),
          title: Text(isupdate?"Update Todo's":"Add Todo",style: TextStyle(fontSize: 35,color: Colors.white),),),
        body: Container(width: double.infinity,
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(height: 150,width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color: Colors.primaries[(Random().nextInt(Colors.primaries.length))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(controller:titletController,
                    decoration: InputDecoration(hintText: "Add Title...",
                      hintStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,

                          color: Colors.white70,),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 400,width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  color:Colors.primaries[(Random().nextInt(Colors.primaries.length))],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(controller: descController,maxLines: null,
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
                    decoration:InputDecoration(hintText: "Add Deascripation ....",
                        hintStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
                        enabledBorder: InputBorder.none,disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,border: InputBorder.none

                    ),

                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  isupdate?   Container(height: 50,width: 150,margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                      child: TextButton(onPressed: (){
                        if(titletController.text.isNotEmpty &&
                            descController.text.isNotEmpty) {
                            context.read<DbProvider>().updateTodo(
                                TodoModel(title: titletController.text,
                                    desc: descController.text,
                                    completed: completed), sno);
                            Navigator.pop(context);
                          }
                      }, child: Text("Update",style: TextStyle(fontSize: 25),))):
                  Container(height: 50,width: 150,margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                      child: TextButton(onPressed: (){
                        if(titletController.text.isNotEmpty &&
                            descController.text.isNotEmpty)
                        {
                          context.read<DbProvider>().addTodo(TodoModel(title: titletController.text,
                              desc: descController.text, completed: completed),);
                          Navigator.pop(context);
                        }
                      }, child: Text("Save",style: TextStyle(fontSize: 25),))),
                  Container(height: 50,width: 150,margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                      child: TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Cancel",style: TextStyle(fontSize: 25),))),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
