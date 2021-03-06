import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:fluterfinale/Model/UserModel.dart';
import 'package:fluterfinale/constant.dart';
import 'package:fluterfinale/view/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EnregistrerE extends StatefulWidget {
  const EnregistrerE({Key? key}) : super(key: key);

  @override
  _EnregistrerEState createState() => _EnregistrerEState();
}
class _EnregistrerEState extends State<EnregistrerE> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  final helper = DbHelper.instance;

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
    DateTime date=DateTime.now();
    /*final format = new DateFormat('yyyy-MM-dd ');*/
    Future<Null> selectTimePicker(BuildContext context,currentValue) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate:currentValue,
          firstDate: DateTime(1940),
          lastDate: DateTime(2030)
      );
      if (picked != null && picked != date) {
        setState(() {
          date = picked;
          print(date.toString());
        });
      }
    }
    Size size=MediaQuery.of(context).size;
    return Scaffold(
    drawer: NavBar(),
      appBar: AppBar(
        title: Text("Enregistrer les emprunts"),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/m12.svg",height:size.height*0.35,
                  ),
                  Column(
                    children: [
                      FlatButton(onPressed: (){
                        selectTimePicker(context,DateTime.now());
                      }, child: Text('choisir une date'),color:Colors.blue,
                      textColor: Colors.white,),
                    ],
                  ),

Text(date.toString()),
                  SizedBox(height: 5.0),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'nom composants'),
                  SizedBox(height: 5.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Nom membre',
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        'Enregistrer',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: signUp,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(30.0),
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