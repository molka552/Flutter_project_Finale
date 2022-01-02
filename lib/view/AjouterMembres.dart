import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:fluterfinale/Model/UserModel.dart';
import 'package:fluterfinale/constant.dart';
import 'package:fluterfinale/view/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class AjouterCl extends StatefulWidget {
  const AjouterCl({Key? key}) : super(key: key);

  @override
  _AjouterClState createState() => _AjouterClState();
}
class _AjouterClState extends State<AjouterCl> {
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
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      drawer: NavBar(
      ),
      appBar: AppBar(
        title: Text("Ajouter Membres du clubs"),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.white,))
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
                  SvgPicture.asset("assets/images/m15.svg",height:size.height*0.35,
                  ),
                  getTextFormField(
                      controller: _conUserId,
                      icon: Icons.person,
                      hintName: 'Nom'),
                  SizedBox(height: 5.0),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'Prenom'),
                  SizedBox(height: 5.0),
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.phone,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Num tel 1'),
                  SizedBox(height: 5.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.phone,
                    hintName: 'Num tel 2',
                  ),
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