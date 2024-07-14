import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/MyDateUltis.dart';
import 'package:todo/components/custom_form_field.dart';

class AddTaskButtomSheet extends StatefulWidget {
   AddTaskButtomSheet({super.key});

  @override
  State<AddTaskButtomSheet> createState() => _AddTaskButtomSheetState();
}

class _AddTaskButtomSheetState extends State<AddTaskButtomSheet> {
 var titleController = TextEditingController();

 var descriptionController =TextEditingController();

 var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
       child: Form(
         key: formKey,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Add Task",style: Theme.of(context).textTheme.headline4,),
            CustomFormField(
                label: "Task title",
                validator: (value) =>
                (value?.isNotEmpty ?? false) ? null : "Cannot be null",
                controller: titleController,
            ),
            CustomFormField(
              label: "Task description",
              validator: (value) =>
              (value?.isNotEmpty ?? false) ? null : "Cannot be null",
              lines: 5,
              controller: descriptionController,
            ),
            SizedBox(height: 12,),
            Text('Task Date'),
            InkWell(
              onTap:(){
                showTaskDatePicker();
              } ,
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text('${MyDateUtils.formatTaskDate(selectedDate)}',
                    style: TextStyle(fontSize: 18),)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.blue
              ),
                onPressed: (){
                AddTask();
                },
                child: Text('Add Task',
                style: TextStyle(
                  fontSize: 18
                ),
                )),
          ],
               ),
       ),
    );
  }

  void AddTask(){
    if(formKey.currentState?.validate()==false){
      return;
    }
  }
var selectedDate = DateTime.now();
  void showTaskDatePicker()async{
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),);
    if(date==null)return;
    selectedDate: date;
    setState(() {
      selectedDate: date;

    });
  }
}
