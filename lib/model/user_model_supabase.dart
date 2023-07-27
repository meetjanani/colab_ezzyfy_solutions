import 'package:json_annotation/json_annotation.dart';

part 'user_model_supabase.g.dart';

@JsonSerializable()
class UserModelSupabase {
  int id = 0;
  String name = "";
  String mobileNumber = "";
  String emailAddress = "";
  String createAt = DateTime.now().toString();

  UserModelSupabase({
    required this.id,
    required this.name,
    required this.mobileNumber,
    required this.emailAddress,
  });

  factory UserModelSupabase.fromJson(Map<String, dynamic> data) =>
      _$UserModelSupabaseFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelSupabaseToJson(this);
}
