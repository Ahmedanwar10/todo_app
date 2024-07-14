import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/home/add_task_buttom_sheet.dart';
import 'package:todo/ui/home/todos_list/list_tap.dart';
import 'package:todo/ui/home/todos_settings/settings_tap.dart';

class HomeScreen extends StatefulWidget {

 static const String routeName ='Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Todo App"),
      ),
     floatingActionButton: Container(

       child: FloatingActionButton(
         onPressed: (){
           ShowAddTaskSheet();
         },
         child: Icon(Icons.add),
         shape:StadiumBorder(
           side: BorderSide(color: Colors.white,width: 3)
         ) ,
       ),
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     bottomNavigationBar:BottomAppBar(
       shape: const CircularNotchedRectangle(),
       notchMargin: 5,

       child: BottomNavigationBar(
         currentIndex: selectedIndex,
         onTap: (index){
           setState(() {
             selectedIndex=index;

           });
         },
         items:   const [
           BottomNavigationBarItem(icon: Icon(Icons.list,size: 21,),label: ""),
           BottomNavigationBarItem(icon: Icon(Icons.settings,size: 21,),label: ""),

         ],
       ),
     ) ,
      body: tabs[selectedIndex],
    );

  }
   void ShowAddTaskSheet(){
     showModalBottomSheet(
         context: context,
         builder: (buildCountext) {
           return AddTaskButtomSheet();
         },
     );
   }
  var tabs=[
    TododsList(),
    SettingsList(),
  ];
}
