import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/ui/register/register_screen.dart';

import '../../components/custom_form_field.dart';
import '../../validation_utlis.dart';
import '../dialog_utlis.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
static const String routeName ='login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();


  var emailController = TextEditingController(text: "ahmed.anwar.rashed10@gmail.com");

  var passwordController = TextEditingController(text: "Aa01125474900");


  //#DFECDB
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDFECDB),
        image: DecorationImage(
          image: AssetImage("assets/images/SIGN IN – 1.png"),
          fit: BoxFit.fill,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Login",style: TextStyle(
            color: Colors.white,
          ),),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.3,
                  ),
                  CustomFormField(label: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    validator: (text ) {
                      if(text==null || text.trim().isEmpty){
                        return "please enter email";
                      }
                      if(!ValidaionUlits.isValidEmail(text)){
                        return"please enter a valid email";
                      };

                    }, controller: emailController,),
                  CustomFormField(label: "Password",
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    validator: (text ) {
                      if(text==null || text.trim().isEmpty){
                        return "please enter Password";
                      }
                      if(
                      text.length<6
                      ){
                        return"password should at least 6 character";
                      }
                      return null;
                    }, controller: passwordController,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8)
                      ),
                      onPressed: (){
                        login();
                      },
                      child: const Text("Login",style:
                      TextStyle(
                        fontSize: 25,
                      ),)),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context,
                            RegisterScreen.routeName);
                      },
                      child: Text("Don't Have Account ? "),),

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  void login() async {
    if(formKey.currentState?.validate()==false){
      return;
    }
    DialogUtlis.sowLoadingDialog(context, "loading...");
    await Future.delayed(Duration(seconds: 4));
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
     var user =await MyDataBase.readUser(result.user?.uid ??"" );
     DialogUtlis.hideDialog(context);
       if(user == null){
         DialogUtlis.showMassage(context, "Error.Can't Find In Database",
             postActionName:'Ok' );
         return;
       }
      DialogUtlis.showMassage(context, "User Logged Successfully",
        postActionName:'Ok',
        postAction: (){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        },
        dismissible: false,
      );


    } on FirebaseAuthException catch (e) {
      DialogUtlis.hideDialog(context);

      String errorMessage ='Wrong Email or password.';

      DialogUtlis.showMassage(context, errorMessage,
          postActionName:'Ok' );

    } catch (e) {
      DialogUtlis.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtlis.showMassage(context, errorMessage,
          postActionName: 'Cancel',
          negActionName: "Try again",
          negAction: (){
            login();
          }
      );
    }
  }
}
