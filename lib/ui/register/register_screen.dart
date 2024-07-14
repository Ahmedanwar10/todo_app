
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/components/custom_form_field.dart';
import 'package:todo/database/my_database.dart';
import 'package:todo/database/model/user.dart' as MyUser;
import 'package:todo/ui/dialog_utlis.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/validation_utlis.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController(text:"Ahmed Anwar");

  var emailController = TextEditingController(text: "ahmed.anwar.rashed10@gmail.com");

  var passwordController = TextEditingController(text: "Aa01125474900");

  var PasswordConfirmationController = TextEditingController(text: "Aa01125474900");

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
          title: Text("Register",style: TextStyle(
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
                  CustomFormField(label: "Full Name",
                    validator: (text ) {
                    if(text==null || text.trim().isEmpty){
                      return"please enter full name";
                    }
                    }, controller: nameController,),
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
                  CustomFormField(label: "Password Confirmation",
                    keyboardType: TextInputType.text,
                    isPassword: true,
                    validator: (text ) {
                      if(text==null || text.trim().isEmpty){
                        return "please enter Password Confirmation";
                      }if(
                      passwordController.text !=text
                      ){
                        return"password doesn't match";
                      }
                      return null;
                    }, controller: PasswordConfirmationController,),
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   padding: EdgeInsets.symmetric(vertical: 8)
                 ),
                   onPressed: (){
                   register();
                   },
                   child: Text("Register",style:
                     TextStyle(
                       fontSize: 25,
                     ),)),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context,
                          LoginScreen.routeName);
                    },
                    child: Text("Already You Have Account ? "),),


                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  void register() async {
    if(formKey.currentState?.validate()==false){
         return;
    }
    DialogUtlis.sowLoadingDialog(context, "loading...");
    await Future.delayed(Duration(seconds: 4));
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      var myUsr = MyUser.User(
        id: result.user?.uid,
        name: nameController.text,
        email: emailController.text,
      );
      await MyDataBase.addUser(myUsr);
      DialogUtlis.hideDialog(context);
      DialogUtlis.showMassage(context, "User register Successfully",
      postActionName:'Ok',
      postAction: (){
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      },
        dismissible: false,
      );


    } on FirebaseAuthException catch (e) {
      DialogUtlis.hideDialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
         errorMessage ='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
         errorMessage ='The account already exists for that email.';
      }
      DialogUtlis.showMassage(context, errorMessage,
          postActionName:'Ok' );

    } catch (e) {
      DialogUtlis.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtlis.showMassage(context, errorMessage,
      postActionName: 'Cancel',
        negActionName: "Try again",
        negAction: (){
        register();
        }
      );
    }
  }
}
