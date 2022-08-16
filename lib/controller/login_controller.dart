part of 'controllers.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  UserModel? user;
  Future<ApiReturnValue<bool>> login(
      {required String username, required String password}) async {
    isLoading.value = true;
    final result = await AuthService.login(
      username: username,
      password: password,
    );
    isLoading.value = false;
    if (result.value == false) {
      return ApiReturnValue(value: false, message: result.message);
    }

    return ApiReturnValue(value: true, message: null);
  }

  Future<ApiReturnValue<bool>> logout() async => await AuthService.logout();
}
