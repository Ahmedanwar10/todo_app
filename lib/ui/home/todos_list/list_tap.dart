import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyDateUltis.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/ui/home/todos_list/task_item.dart';

import '../../../database/model/Task.dart';

class TododsList extends StatefulWidget {
  @override
  State<TododsList> createState() => _TododsListState();
}

class _TododsListState extends State<TododsList> {
 DateTime selectedDate= DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthinProvider>(context);
    return Container(
      child: Column(
        children: [
          CalendarTimeline(

            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate:DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (selectedDate){
              print("selected day millis");
              print(selectedDate.millisecondsSinceEpoch);
              setState(() {
                this.selectedDate=selectedDate;

              });
            },

            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: Colors.teal[200],
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotColor: const Color(0xFF333A47),
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',


          ),

          Expanded(child:
          StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDataBase.getTasksRealTimeUpdate(authProvider.currentUser?.id??"",
                  MyDateUtils.dateOnly(selectedDate).millisecondsSinceEpoch),
              builder: (context, snapshot)  {

           if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
           }
           if(snapshot.connectionState == ConnectionState.waiting){
             return Center(child: CupertinoActivityIndicator(),);
           }
          var tasksList = snapshot.data?.docs.map((doc) => doc.data()).toList();
           if(tasksList?.isEmpty==true){
             return Center(child: Text("you don't have tasks"));
           }
           return ListView.builder(itemBuilder: (_,index){
             return TaskItem(tasksList! [index]);

           },
           itemCount: tasksList?.length??0,);

          },
)
          )
        ],
      ),
    );
  }

  readFile() async{
    var authProvider= Provider.of<AuthinProvider>(context,listen: false);
   var result= await MyDataBase.getTasks(authProvider.currentUser?.id??"");
    var tasksList= result.docs.map((docSnapshot) => docSnapshot.data()).toList();
    setState(() {

    });
  }
}
