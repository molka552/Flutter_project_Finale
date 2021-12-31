class CompModel{
  int ?_id;
  String ?_nomC;
  String ?_nomF;
  int ?_qt;
  CompModel(dynamic obj){
    _id = obj['id'];
    _nomC =obj['nomC'];
    _nomF =obj['nomF'];
    _qt =obj['qt'];
  }
  CompModel.fromMap(Map<String,dynamic> data){
    _id = data['id'];
    _nomC =data['nomC'];
    _nomF =data['nomF'];
    _qt =data['qt'];

  }
  Map<String, dynamic>toMap()=>{ 'id':_id,'nomC':_nomC,'nomF':_nomF,'qt':_qt};

  int? get id=>_id;
  String? get nomC=>_nomC;
  String? get nomF=>_nomF;
  int? get qt=>_qt;

}