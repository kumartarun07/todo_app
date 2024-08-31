import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/data/db_helper.dart';
import 'package:to_do_app/data/db_provider.dart';
import 'package:to_do_app/ui/addnote_page.dart';
import 'package:to_do_app/ui/home_page.dart';

void main()
{
  runApp(ChangeNotifierProvider(create: (context)=>DbProvider(dbHelper: DbHelper.getInstance())
    ,child: MyApp(),));
}

class MyApp extends StatelessWidget {  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: HomePage() ,
   );
  }
}
