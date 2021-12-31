import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Comm/NavBar.dart';
import '../constant.dart';
class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(
      ),
        appBar: AppBar(
          title: Text("gstock"),
          backgroundColor: kPrimaryColor,
elevation: 0.1,
actions: <Widget>[
  new IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.white,))
],
        ),
        body: Center(),
    );
  }
}