import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:fluterfinale/Model/FamilleCom.dart';
import 'package:fluterfinale/view/HomeForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite_common/sqlite_api.dart';

import '../constant.dart';

class NewF extends StatefulWidget {
  const NewF({Key? key}) : super(key: key);

  @override
  _NewFState createState() => _NewFState();
}

class _NewFState extends State<NewF> {
  final _formKey = new GlobalKey<FormState>();
  final _conNom = TextEditingController();
  late DbHelper helper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper=DbHelper();
  }
  ajoutF() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FamilleCom FModel = FamilleCom({'nom':_conNom.text});
      int id =await helper.saveDataF(FModel);
        print('course id is $id');
        if(id!=null){
        alertDialog(context, "Enregitré avec succés");
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeForm()));}
      else{
        alertDialog(context, "Erreur: échec de l'enregistrement des données");
      };
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        drawer: NavBar(
      ),
      appBar: AppBar(
        title: Text("Ajouter Famille"),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset("assets/images/m14.svg",height:size.height*0.45,
                ),
getTextFormField(controller: _conNom, hintName:'Nom famille', icon: Icons.family_restroom),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed:ajoutF,
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
    );
  }
}
