import 'package:fluterfinale/Comm/comHelper.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant.dart';
import 'HomeForm.dart';


class ModifierBackend extends StatefulWidget {
  Map<String, dynamic>  content;

  ModifierBackend({Key? key,required this.content}) : super(key: key);

  @override
  _ModifierBackendState createState() => _ModifierBackendState();
}

class _ModifierBackendState extends State<ModifierBackend> {

  final componentRef = TextEditingController();
  final quantity=TextEditingController();

  final dbaHelper = DbHelper.instance;

  var SelectedValue;

  @override
  void initState(){
    super.initState();
    componentRef.text=widget.content["component_name"];
    quantity.text=widget.content["qte"].toString();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_)=>HomeForm()));
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: componentRef,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Reference'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: quantity,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Quantity'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    _update();
                  },
                  child: Text(
                    "modifier",
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

    );
  }

  _update() async{
    Map<String, dynamic> row = {
      DbHelper.ComponentId :widget.content["component_id"],
      DbHelper.ComponentName : componentRef.text,
      DbHelper.quantity :int.parse(quantity.text)
    };

    try {
      final rowsAffected = await dbaHelper.updateComponent(row);
      if (rowsAffected >0) {
        alertDialog(context, "mise à jour avec succès ");

      }
    }
    catch(error) {
      print(error);
      alertDialog(context, "erreur est survenue ");
    }

  }
  @override
  void dispose() {
    componentRef.dispose();
    quantity.dispose();
    super.dispose();
  }
}
