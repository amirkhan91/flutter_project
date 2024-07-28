void main(){
  List<int> list = [1,2,3,2,2,1,1,2,3,3,3,2,2,3,4];
  List<int> un = removeDP(list);
  print(un);
}
List<int> removeDP(List<int> input){
  List<int> unique = [];
  for(int number in input){
    if(!unique.contains(number)){
      unique.add(number);
    }
  }
  return unique;
} 