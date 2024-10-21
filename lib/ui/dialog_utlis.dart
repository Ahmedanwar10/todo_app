  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtlis{
  static void sowLoadingDialog( BuildContext context,
      String message){
    showDialog(
        context: context,
        builder: (buildContext){
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 12,),
                Text(message),
              ],
            ),
          );
        },barrierDismissible: false,
        );
  }
  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }
  static void showMassage(BuildContext context ,String message,
  {
    String? posActionName,
    VoidCallback? postAction,
    String? negActionName,
    VoidCallback? negAction,
    bool dismissible=true,
  }
  ){
    List<Widget> actoins =[];
    if(posActionName != null){
      actoins.add(TextButton(onPressed: (){
        Navigator.pop(context);
        postAction?.call();
      },
          child: Text(posActionName)));
    }
    if(negActionName != null){
      actoins.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      },
          child: Text(negActionName)));
    }
   showDialog(context: context,
       builder:(buildContext){
     return AlertDialog(
       content: Text(message),
       actions: actoins,
     );

   },
   barrierDismissible: dismissible,
   );
  }
  }