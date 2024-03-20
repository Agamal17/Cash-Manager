List<Map> b = [{'ID':2}, {'ID': 3}];

void main(){
  var c = b.map((e) => [e]).toList();
  var d = [...c];
  print(d);
}