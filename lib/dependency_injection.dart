
import 'package:colab_ezzyfy_solutions/shared/api_provider.dart';
import 'package:colab_ezzyfy_solutions/shared/api_repository.dart';
import 'package:colab_ezzyfy_solutions/shared/common/dio_helper.dart';
import 'package:colab_ezzyfy_solutions/shared/get_storage_repository.dart';
import 'package:colab_ezzyfy_solutions/shared/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';




class DependencyInjection {
  static void init() {
    Get.lazyPut<GetStorage>(() => GetStorage(), fenix: true);
    Get.lazyPut<GetStorageRepository>(() => GetStorageRepository(Get.find()), fenix: true);

    //DIO BINDIN
    Get.lazyPut<DioHelper>(() => DioHelper(Dio()), fenix: true);
    Get.lazyPut<ApiProvider>(() => ApiProvider(Get.find()), fenix: true);
    Get.lazyPut<ApiRepository>(() => ApiRepository(Get.find()), fenix: true);

    Get.lazyPut<Connectivity>(Connectivity.new, fenix: true);
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()), fenix: true);
  }
}

