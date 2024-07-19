void main() {
  String str = 'bsabddbsaaaasas';
  charCount(str);
}

void charCount(String str) {
  Map<String, int> count = {};
  for (int i = 0; i < str.length; i++) {
    String char = str[i];
    if (count.containsKey(char)) {
      count[char] = count[char]! + 1;
    } else {
      count[char] = 1;
    }
  }
count.forEach((char,count){
  print('$char:$count');
});
}
