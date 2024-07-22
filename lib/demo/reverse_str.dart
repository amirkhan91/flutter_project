void main(){
  String str = "sjadjsdjwbaabdbabdwbbwdd";
}
void charCount(String str){
  Map<String, int> charCount = {};
  for(int i = 0;i<str.length;i++){
    String char = str[i];
    if(charCount.containsKey(char)){
      charCount[char] = charCount[char]!+1;
    }else{
      charCount[char] = i;
    }
  }
  charCount.forEach((char, count){
    print('$char:$count');
  });
}