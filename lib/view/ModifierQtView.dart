import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:flutter/material.dart';


import '../constant.dart';
import 'ModifierBackend.dart';

class ModifierQtView extends StatefulWidget {
  const ModifierQtView({Key? key}) : super(key: key);

  @override
  _ModifierQtViewState createState() => _ModifierQtViewState();
}


class  _ModifierQtViewState extends State<ModifierQtView> {

  final dbaHelper = DbHelper.instance;

  late List<Map<String, dynamic>>  myComp=[];

  @override
  void initState(){
    super.initState();
    myComp=[];
    _getComponents();
  }

  void _getComponents() async{

    final dbaHelper = DbHelper.instance;
    final allRows = await dbaHelper.getAllCom();
    myComp=allRows;
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(title: Text("Home"),backgroundColor: kPrimaryColor,),
        body:SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[

                    ],
                  ),
                ),

                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: myComp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key:  UniqueKey(),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    ' ${myComp[index]["component_name"]}  ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '  ${myComp[index]["category_name"]}  ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${myComp[index]["qte"]}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      onPressed: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (_)=>
                                                ModifierBackend(
                                                    content:myComp[index]
                                                )));
                                      },
                                      color:Colors.red,
                                      child: Icon(Icons.edit,color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      onDismissed: (direction) {
                        dbaHelper.deleteComponent(myComp[index]["component_id"]);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )

    );
  }
}

Map<int, Color> color =
{
  50:Color.fromRGBO(111,53,165, .1),
  100:Color.fromRGBO(111,53,165, .2),
  200:Color.fromRGBO(111,53,165, .3),
  300:Color.fromRGBO(111,53,165, .4),
  400:Color.fromRGBO(111,53,165, .5),
  500:Color.fromRGBO(111,53,165, .6),
  600:Color.fromRGBO(111,53,165, .7),
  700:Color.fromRGBO(111,53,165, .8),
  800:Color.fromRGBO(111,53,165, .9),
  900:Color.fromRGBO(111,53,165, 1),
};
MaterialColor colorCustom = MaterialColor(0xFF6F35A5, color);