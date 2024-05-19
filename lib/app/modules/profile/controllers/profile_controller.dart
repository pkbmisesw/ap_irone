import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:irone/app/data/models/profile/item_profile_model.dart';
import 'package:irone/app/services/profile_services.dart';

class ProfileController extends GetxController {
  late final ProfileServices _profileServices;

  final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();

    _profileServices = ProfileServices();
  }

  Future<List<ItemProfileModel>?> getProfile() async {
    try {
      final resProfile = await _profileServices.getProfile();

      if (resProfile.data != null) {
        return resProfile.data;
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      logger.e('Error Type: ${e.type}');
      return Future.error(e);
    }

    return null;
  }
}
