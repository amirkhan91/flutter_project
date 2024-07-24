// To parse this JSON data, do
//
//     final apiCall2 = apiCall2FromJson(jsonString);

import 'dart:convert';

ApiCall2 apiCall2FromJson(String str) => ApiCall2.fromJson(json.decode(str));

String apiCall2ToJson(ApiCall2 data) => json.encode(data.toJson());

class ApiCall2 {
    String? status;
    List<Datum>? data;
    String? message;

    ApiCall2({
        this.status,
        this.data,
        this.message,
    });

    factory ApiCall2.fromJson(Map<String, dynamic> json) => ApiCall2(
        status: json["status"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    int? id;
    String? employeeName;
    int? employeeSalary;
    int? employeeAge;
    String? profileImage;

    Datum({
        this.id,
        this.employeeName,
        this.employeeSalary,
        this.employeeAge,
        this.profileImage,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        employeeName: json["employee_name"],
        employeeSalary: json["employee_salary"],
        employeeAge: json["employee_age"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "employee_salary": employeeSalary,
        "employee_age": employeeAge,
        "profile_image": profileImage,
    };
}
