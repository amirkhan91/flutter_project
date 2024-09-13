void main(){
  List<int> list = [1,2,3,3,4,3,3,4,5,6,7];
  List<int> un = removeDP(list);
  print(un);
}
List<int> removeDP(List<int> numbers){
  List<int> rp = [];
  for(int number in numbers){
    if(!rp.contains(number)){
      rp.add(number);
    }
  }
  return rp;
}