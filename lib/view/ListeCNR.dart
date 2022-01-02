import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/Model/FamilleCom.dart';
import 'package:flutter/material.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import '../constant.dart';
class Liste extends StatefulWidget {
  const Liste({Key? key}) : super(key: key);

  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  final helper = DbHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Enregistrer le retour"),
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
body: FutureBuilder(
  future: helper.getAllCom(),
  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    if(!snapshot.hasData){
      return CircularProgressIndicator();
    }
    else{
      return ListView.builder(
itemCount:snapshot.data!.length ,
          itemBuilder:(contex,i){
  FamilleCom fm= FamilleCom.fromMap(snapshot.data![i]);
  return ListTile(
    title: Text('${fm.nom.toString()} ${fm.id}'),
  );
          });
    }
  },
),
    );
  }
}
