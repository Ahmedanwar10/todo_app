import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/provider/auth_provider.dart';
import 'package:todo/ui/dialog_utlis.dart';

import '../../../database/model/Task.dart';

class TaskItem extends StatefulWidget {
Task task;
TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: DrawerMotion(),
          children: [
            SlidableAction(onPressed:
            (buildContext){
              deleteTask();
            },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: "Delete",
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18)
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor
                ),
                width: 12,
                height: 80,
              ),
              SizedBox(width: 15,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.task.title}",style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),),
                  SizedBox(height: 19,),

                  Text("${widget.task.desc}"),
                ],
              ),),
              SizedBox(width: 15,),

              Container(
                padding: EdgeInsets.symmetric(horizontal:20,vertical: 5 ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),

                ),
                child: Image.asset("assets/images/img.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask(){
    DialogUtlis.showMassage(context, "Do You want to delete this task? ",
    posActionName: 'Yes',
    postAction: (){
      deleteTaskFromDatabase();
    },
    negActionName:  'No',
    );
  }
  void deleteTaskFromDatabase()async{
    var authProvider= Provider.of<AuthinProvider>(context,listen: false);
     try{
       await MyDataBase.deleteTask(authProvider.currentUser?.id??"", widget.task.id??"");

       Fluttertoast.showToast(
           msg: "Task Deleted Successfully",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.SNACKBAR,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.black45,
           textColor: Colors.white,
           fontSize: 16.0
       );

     }catch(e){
       DialogUtlis.showMassage(context, "some went wrong,'${e.toString()}",);
     }


  }
}
