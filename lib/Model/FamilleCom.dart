class FamilleCom{
  int ?_id;
  String ?_nom;
  FamilleCom(dynamic obj){
_id = obj['id'];
_nom =obj['nom'];
  }
  FamilleCom.fromMap(Map<String,dynamic> data){
_id= data['id'];
_nom= data['nom'];
  }
  Map<String, dynamic>toMap()=>{ 'id':_id,'nom':_nom};

  int? get id=>_id;
  String? get nom=>_nom;
}