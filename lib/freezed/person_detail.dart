import 'package:freezed_annotation/freezed_annotation.dart';
part 'person_detail.freezed.dart';
part 'person_detail.g.dart';

@freezed
class PersonDetail  with _$PersonDetail{
  const factory PersonDetail({
    required String firstName,
    required String lastName,
    required int age
  })= _PersonDetail;
factory PersonDetail.fromJson(Map<String,Object?> json)
=> _$PersonDetailFromJson(json);
}