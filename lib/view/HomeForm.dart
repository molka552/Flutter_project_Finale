import 'package:fluterfinale/Comm/NavBar.dart';
import 'package:fluterfinale/DataBaseHandler/DbHelper.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'Recherche.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  _HomeFormState createState() => _HomeFormState();
}
class _HomeFormState extends State<HomeForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbaHelper = DbHelper.instance;

  late List<Map<String, dynamic>>  myComp;

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
        drawer: NavBar(
        ),
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: kPrimaryColor,
          elevation: 0.1,
          actions: <Widget>[
            new IconButton(onPressed: (){Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => Recherche()),
                    (Route<dynamic> route) => false);}, icon: Icon(Icons.search,color: Colors.white,))
          ],
        ),
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



