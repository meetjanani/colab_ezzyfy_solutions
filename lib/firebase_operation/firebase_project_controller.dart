import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:colab_ezzyfy_solutions/resource/firebase_database_schema.dart';
import 'package:get/get.dart';

import '../model/project_create_model.dart';

class FirebaseProjectController extends GetxController {
  static FirebaseProjectController get to => Get.find();

  void createNewProject(ProjectCreateModel projectCreateModel) async {
    showProgress();
    CollectionReference projectRef = FirebaseFirestore.instance
        .collection(FirebaseDatabaseSchema.projectTable);
    projectRef
        .where(FirebaseDatabaseSchema.projectNameCol,
            isEqualTo: projectCreateModel.projectName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        projectRef.add(projectCreateModel).then((value) {
          Get.showSuccessSnackbar('Project Created Succesfully');
          hideProgressBar();
        });
      } else {
        Get.showErrorSnackbar('Project already exists');
      }
    });
  }
}
