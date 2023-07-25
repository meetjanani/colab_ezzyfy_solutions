import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSetupController {
  // Get a reference your Supabase client


  void getData() async {
    final supabase = Supabase.instance.client;
    final data = await supabase
        .from('projects')
        .select('*');


    final List<Map<String, dynamic>> project =
    await supabase.from('projects').upsert([
      {'name': 'The Shire', 'mobileNumber': '6666','address': 'addd mobile', 'thumbnailImageUrl': 'mobile image'},
    ]).select();
    Get.showSuccessSnackbar(project.toString());
  }
}
