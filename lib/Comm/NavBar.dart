import 'package:fluterfinale/view/AjouterComposant.dart';
import 'package:fluterfinale/view/AjouterMembres.dart';
import 'package:fluterfinale/view/EnregistrerEmprunts.dart';
import 'package:fluterfinale/view/EnregistrerRetour.dart';
import 'package:fluterfinale/view/ListeCNR.dart';
import 'package:fluterfinale/view/ModifierQt.dart';
import 'package:fluterfinale/view/ajouterFamille.dart';
import 'package:flutter/material.dart';
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
child: ListView(
  padding: EdgeInsets.zero,
children: [
  UserAccountsDrawerHeader(accountName:Text(''), accountEmail: Text(''),
  decoration: BoxDecoration(
    image: DecorationImage(
image: new ExactAssetImage('assets/images/im3.png',
),
      fit: BoxFit.cover,
    ),
  ),
  ),
ListTile(
  leading:Icon(Icons.add_circle,color:Color(0xFF6F35A5)),
  title:Text('Ajouter Familles') ,
  onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewF())),
),
  Divider(),
  ListTile(
    leading:Icon(Icons.add_circle,color:Color(0xFF6F35A5)),
    title:Text('Ajouter Composant') ,
    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewC())),
  ),
  Divider(),
  ListTile(
    leading:Icon(Icons.add_circle,color:Color(0xFF6F35A5)),
    title:Text('Ajouter Membres clubs') ,
    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => AjouterCl())),
  ),
  Divider(),
  ListTile(
    leading:Icon(Icons.settings,color:Colors.blue),
    title:Text('Modifier quantite') ,
    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => ModifierQt())),
  ),
  Divider(),
  ListTile(
    leading:Icon(Icons.save,color:Colors.black),
    title:Text('Enregistrer les emprunts') ,
    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnregistrerE())),
  ),
  Divider(),
  ListTile(
    leading:Icon(Icons.save,color:Colors.black),
    title:Text('Enregistrer le retour') ,
    onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => EnregistrerR())),
  ),
  Divider(),
  ListTile(
    leading:Icon(Icons.checklist_sharp,color:Colors.green),
    title:Text('liste des composants non retournés') ,
    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => Liste())),
  ),
],
),
    );
  }
}
