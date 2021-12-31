import 'package:dropdownfield/dropdownfield.dart';
import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:fluterfinale/Model/ComposantModel.dart';
import 'package:fluterfinale/Model/FamilleCom.dart';
import 'package:fluterfinale/view/HomeForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class NewC extends StatefulWidget {
  const NewC({Key? key}) : super(key: key);

  @override
  _NewCState createState() => _NewCState();
}

class _NewCState extends State<NewC> {
  final _formKey = new GlobalKey<FormState>();
  final _conC = TextEditingController();
  final _conS = TextEditingController();
  final _conQ = TextEditingController();
  late DbHelper helper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper=DbHelper();
  }
  ajoutC() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      CompModel CModel = CompModel({'nomC':_conC,'nomF':_conS,'qt':_conQ});
      int id =await helper.saveDataC(CModel);
      print('composant id is $id');
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
        title: Text("Ajouter Composant"),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SvgPicture.asset("assets/images/m16.svg",height:size.height*0.35,
              ),
              getTextFormField(controller: _conC, hintName:'Nom Composant', icon: Icons.drive_file_rename_outline),
              SizedBox(height: 10.0),

              Container(
  decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(30),
  ),
  padding: EdgeInsets.symmetric(horizontal: 20.0),
  margin:EdgeInsets.only(top:20.0),
  child: Column(
mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children:<Widget> [
      DropDownField(
controller: _conS,
        hintText: "sélectionner",
        enabled: true,
        itemsVisibleInDropdown:c.length ,
        items:c,
        onValueChanged: (value){
  FocusScope.of(context).requestFocus(new FocusNode());
setState(() {
  selectC=value;
});

        },
      ),
      Text(selectC)
    ],
  ),



),
              SizedBox(height: 10.0),
              getTextFormField(controller: _conQ, hintName:'Qt', icon: Icons.family_restroom),

              Container(
                margin: EdgeInsets.all(20.0),
                width: double.infinity,
                child: FlatButton(
                  child: Text(
                    'Enregistrer',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ajoutC,
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
String selectC="";
List<String> c=[
  "Tunis",
  "Sfax",
  "Sousse",
  "Ariana",
  "Kairouan",
  "Gabès",
  "Bizerte",
  "Gafsa",
  "El Mourouj",
];
