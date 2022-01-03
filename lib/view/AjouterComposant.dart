import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/Comm/genTextFormField.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';
import 'HomeForm.dart';




class NewC extends StatefulWidget {
  const NewC({Key? key}) : super(key: key);

  @override
  _NewCState createState() => _NewCState();
}
class _NewCState extends State<NewC> {

  final componentId= TextEditingController();
  final componentRef = TextEditingController();
  final quantity=TextEditingController();

  final dbaHelper = DbHelper.instance;

  var SelectedValue;

  late List<String> myList;

  @override
  void initState(){
    super.initState();
    myList=[];
    _getCategory();
  }

  _getCategory() async {

    List<String> items=[];
    await dbaHelper.getAllCat().then((value) {
      for (var i = 0; i < value.length; i++) {
        items.add(value[i]['category_name']);
      }
    }
    );
    myList=items;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    print(myList);
    return Scaffold(

      drawer: NavBar(
      ),
      appBar: AppBar(
        title: Text("Ajouter Composant",),
        backgroundColor: kPrimaryColor,
        elevation: 0.1,
        actions: <Widget>[
          new IconButton(onPressed: (){ Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeForm()),
                  (Route<dynamic> route) => false);}, icon: Icon(Icons.home,color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/m16.svg",height:size.height*0.35,
                ),
                getTextFormField(controller: componentId, hintName:'Id Composant', icon: Icons.drive_file_rename_outline),
                SizedBox(height: 10.0),
                getTextFormField(controller: componentRef, hintName:'Ref Composant', icon: Icons.drive_file_rename_outline),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    controller: quantity,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          borderSide: BorderSide(color: Colors.deepPurpleAccent)
                      ),
                      prefixIcon: Icon(Icons.confirmation_number_outlined),
                      hintText: "Quantité",
                      fillColor:kPrimaryLightColor,
                      filled: true,

                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    child:DropdownButton<String>(
                      hint: Text('Choisir une catégorie'),
                      value: null,
                      onChanged:(newValue){
                        setState(() {
                          SelectedValue=newValue.toString();
                          print(SelectedValue);
                        });
                      },
                      items: myList.map<DropdownMenuItem<String>>((ValueItem){
                        return DropdownMenuItem<String>(
                            value: ValueItem,
                            child:Text(
                              ValueItem,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                        );
                      }).toList(),
                    )
                ),

                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      add();
                    },
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(color:Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color:kPrimaryColor,
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> add() async {
    String id = componentId.text;
    String ref = componentRef.text;
    String qte = quantity.text;

    if (id.isEmpty) {
      alertDialog(context, "Erreur: échec de l'enregistrement des données");

    } else if (ref.isEmpty) {
      alertDialog(context, "Erreur: échec de l'enregistrement des données");
    } else if (qte.isEmpty) {
      alertDialog(context, "Erreur: échec de l'enregistrement des données");

    } else if(SelectedValue == null){
      alertDialog(context, "Erreur: échec de l'enregistrement des données");

    }
    else {
      var value= await dbaHelper.getIdCategory(SelectedValue);
      insert(int.parse(qte),value![0]['category_id']);
    }
  }


  void insert(int qte,String category) async{



    Map<String, dynamic> row = {
      DbHelper.ComponentId: componentId.text,
      DbHelper.ComponentName: componentRef.text,
      DbHelper.quantity: qte,
      DbHelper.cate: category
    };

    try {
      final id = await dbaHelper.insertComponent(row);
      if (id >0)  {
        alertDialog(context, "enregistré avec succès");

      }

    }
    catch (error) {
      print(error);
      alertDialog(context, "erreur est survenu");

    }


  }
  @override
  void dispose() {
    componentId.dispose();
    componentRef.dispose();
    quantity.dispose();
    super.dispose();
  }
}




