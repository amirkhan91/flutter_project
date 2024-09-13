// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:csv/csv.dart';


// void main() async {
//   fetchAndProcessData();
//   //  var url = Uri.parse('https://coderbyte.com/api/challenges/logs/user-info-csv');
// }
// Future<void> fetchAndProcessData()async{
//   final url = 'https://coderbyte.com/api/challenges/logs/user-info-csv';
//   try{
//   final response= await http.get(Uri.parse(url));
//   if(response.statusCode == 200){
//     final csvData = response.body;
//     print('Row cvs data: $csvData');
//     final List<List<dynamic>> rows = CsvToListConverter().convert(csvData);
//    print('Parsed csv rows: $rows');
//     final headers = rows.first;
//     final dataRows = rows.sublist(1);
//     dataRows.sort((a,b)=>(a[1] as String).compareTo(b[1] as String));
//     final jsonList = dataRows.map((row){
//       return {
//         headers[0]: row[0],
//         headers[1]: row[1],
//         headers[2]: row[2],
//       };
//     }).toList();
//     final jsonString = jsonEncode(jsonList);
//     print(jsonString);
//   }else{
//     print('Failed to load data');
//     print(response.statusCode);
//   }
//   } catch (e){
//     print('Error: $e');
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  fetchAndSortData();
  // var url = Uri.parse('https://coderbyte.com/api/challenges/json/date-list'); 
}
Future<void> fetchAndSortData()async{
  final url = "https://coderbyte.com/api/challenges/json/date-list";

  try{
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final List<dynamic> data= jsonDecode(response.body);
      final sortedData = data.map((item){
        if(item is Map<String, dynamic>){
          return _sortMapKeys(item);
        }
        return item;
      }).toList();

      final jsonString = jsonEncode(sortedData);
      print(jsonString);
    }else{
      print('Failed to load data');
      print(response.statusCode);
    }
  }catch (e){
    print("Error: $e");
  }
}
Map<String, dynamic> _sortMapKeys(Map<String, dynamic> map){
  final sortedMap= <String, dynamic>{};
  final sortedKeys = map.keys.toList()
  ..sort((a,b)=>a.toLowerCase().compareTo(b.toLowerCase()));
  for(var key in sortedKeys){
    final value = map[key];

    if(value is Map<String, dynamic>){
      sortedMap[key] = _sortMapKeys(value);

    }else if(value is List){
      sortedMap[key] = _sortList(value);
    }else{
      sortedMap[key] = value;
    }
  }
  return sortedMap;
}

List<dynamic> _sortList(List<dynamic> list){
  return list.map((item){
    if(item is Map<String, dynamic>){
      return _sortMapKeys(item);
    }else if(item is List){
      return _sortList(item);
    }
    return item;
  }).toList();
}
