// Var arry - [1, 2,3,7,9]
// Out put - [9,7,3,2,1]
void main(){
  List<int> arry = [1, 2,3,7,9];
  List<int> arra1 = revInt(arry);
  print(arra1);

}
List<int> revInt(List<int> input){
  List<int> array1= [];
  for(int i = input.length-1;i>=0;i--){
    array1 += input[i] as List<int>;
  }
  return array1;
}