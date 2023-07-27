import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/project_create_model.dart';
import '../resource/database_schema.dart';

class SupabaseSetupController {
  static SupabaseSetupController get to => Get.find();
  // Get a reference your Supabase client

  void createNewProject(ProjectCreateModel projectCreateModel) async {
    showProgress();
    final supabase = Supabase.instance.client;
    final data = await supabase.from('projects').select('*');

    final List<Map<String, dynamic>> project =
        await supabase.from(DatabaseSchema.projectTable).upsert([
      projectCreateModel.toJson(),
    ]).select();
    hideProgressBar();
    Get.showSuccessSnackbar(project.toString());
  }
}
