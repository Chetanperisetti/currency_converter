class Currency{
  int? id;
  num input;
  double result;
  Currency({
    this.id,
    required this.input,
    required this.result,
  });
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'input':input,
      'result':result
    };
  }
}