import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';
import 'HomeForm.dart';
import 'SignupForm.dart';
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}


class _LoginFormState extends State<LoginForm> {
  final _formKey = new GlobalKey<FormState>();
  final _myIdController=TextEditingController();
  final _myPwdController=TextEditingController();

  final dbaHelper = DbHelper.instance;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Connexion",style: TextStyle(fontWeight: FontWeight.bold),),
                SvgPicture.asset("assets/images/m4.svg",height:size.height*0.47,
                ),
                getTextFormField(
                    controller: _myIdController,
                    icon: Icons.person,
                    hintName: 'User ID'
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _myPwdController,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),

                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Connexion',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Login();
                    },
                  ),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("N'a pas de compte? "),
                      FlatButton(
                        textColor: kPrimaryColor,
                        child: Text('Inscrivez-vous'),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
  Login() {
    String id=_myIdController.text;
    String password=_myPwdController.text;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    if(id.isEmpty){
      alertDialog(context, 'saisir id');

    }else if(password.isEmpty){
      alertDialog(context, "saisir ");

    } else {
      _login(id,password);
    }
  }

  void _login(String id,String pwd) async{
    Map<String,dynamic> row={
      DbHelper.Id : id,
      DbHelper.Password : pwd
    };


    await dbaHelper.getAdmin(row).then((value) { if (value == null) {
      Fluttertoast.showToast(
          msg: "Admin does not exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (_)=>HomeForm()));
    }
    });

  }
  @override
  void dispose(){
    _myIdController.dispose();
    _myPwdController.dispose();
    super.dispose();
  }
}

