import 'package:heal_meals/features/home/data/models/profile_model.dart';
import '/../../../core/network/api_client.dart';
import '/../../../core/network/endpoints.dart';


class ProfileRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Profile> getProfile() async {
    final json = await _apiClient.get(Endpoints.profile);
    return Profile.fromJson(json);
  }
}
