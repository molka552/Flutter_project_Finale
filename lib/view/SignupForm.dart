 import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:fluterfinale/Model/UserModel.dart';
import 'package:fluterfinale/constant.dart';
import 'package:fluterfinale/view/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';
 class SignupForm extends StatefulWidget {
   @override
   _SignupFormState createState() => _SignupFormState();
 }

 class _SignupFormState extends State<SignupForm> {
   final _formKey = new GlobalKey<FormState>();

   final _conUserId = TextEditingController();
   final _conUserName = TextEditingController();
   final _conEmail = TextEditingController();
   final _conPassword = TextEditingController();
   final _conCPassword = TextEditingController();
   var dbHelper;

   @override
   void initState() {
     super.initState();
     dbHelper = DbHelper();
   }

   signUp() async {
     String uid = _conUserId.text;
     String uname = _conUserName.text;
     String email = _conEmail.text;
     String passwd = _conPassword.text;
     String cpasswd = _conCPassword.text;

     if (_formKey.currentState!.validate()) {
       if (passwd != cpasswd) {
         alertDialog(context, 'Non concordance des mots de passe');
       } else {
         _formKey.currentState!.save();

         UserModel uModel = UserModel(uid, uname, email, passwd);
         await dbHelper.saveData(uModel).then((userData) {
           alertDialog(context, "Enregistré avec succès");

           Navigator.push(
               context, MaterialPageRoute(builder: (_) => LoginForm()));
         }).catchError((error) {
           print(error);
           alertDialog(context, "Erreur: échec de l'enregistrement des données");
         });
       }
     }
   }

   @override
   Widget build(BuildContext context) {
     Size size=MediaQuery.of(context).size;
     return Scaffold(
       body: Form(
         key: _formKey,
         child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Container(
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("S'inscrire",style: TextStyle(fontWeight: FontWeight.bold),),
                   SvgPicture.asset("assets/images/m1.svg",height:size.height*0.35,
                   ),
                   getTextFormField(
                       controller: _conUserId,
                       icon: Icons.person,
                       hintName: 'User ID'),
                   SizedBox(height: 10.0),
                   getTextFormField(
                       controller: _conUserName,
                       icon: Icons.person_outline,
                       inputType: TextInputType.name,
                       hintName: 'Nom'),
                   SizedBox(height: 10.0),
                   getTextFormField(
                       controller: _conEmail,
                       icon: Icons.email,
                       inputType: TextInputType.emailAddress,
                       hintName: 'Email'),
                   SizedBox(height: 10.0),
                   getTextFormField(
                     controller: _conPassword,
                     icon: Icons.lock,
                     hintName: 'Password',
                     isObscureText: true,
                   ),
                   SizedBox(height: 10.0),
                   getTextFormField(
                     controller: _conCPassword,
                     icon: Icons.lock,
                     hintName: 'Confirm Password',
                     isObscureText: true,
                   ),
                   Container(
                     margin: EdgeInsets.all(30.0),
                     width: double.infinity,
                     child: FlatButton(
                       child: Text(
                         'Inscrivez-vous',
                         style: TextStyle(color: Colors.white),
                       ),
                       onPressed: signUp,
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
                         Text('Avez-vous un compte ? '),
                         FlatButton(
                           textColor: kPrimaryColor,
                           child: Text("S'identifier"),
                           onPressed: () {
                             Navigator.pushAndRemoveUntil(
                                 context,
                                 MaterialPageRoute(builder: (_) => LoginForm()),
                                     (Route<dynamic> route) => false);
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
 }