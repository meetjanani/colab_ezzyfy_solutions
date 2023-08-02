import 'package:json_annotation/json_annotation.dart';

part 'user_model_supabase.g.dart';

@JsonSerializable()
class UserModelSupabase {
  int id = 0;
  String name = "";
  String mobileNumber = "";
  String emailAddress = "";
  String createAt = DateTime.now().toString();
  bool isAdmin = false;
  String profilePictureUrl =
      "https://firebasestorage.googleapis.com/v0/b/colab-sample.appspot.com/o/default_placeholder%2Fuser_default_profile_picture.png?alt=media&token=e00268a3-7e48-4586-b06b-99aa449d3f3e";

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
