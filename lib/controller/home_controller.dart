part of 'controllers.dart';

class HomeController extends GetxController {
  UserModel? user;
  ModulModel? modul;
  List<ModulModel>? moduls;
  List<ModulModel>? filteredModuls;
  List<QuizResultModel> quizResults = [];
  final TextEditingController searchController = TextEditingController();

  Future<ApiReturnValue<bool>> getDocument(
      {required bool isSingle, required String? type, String? search}) async {
    final result = isSingle
        ? await ModulService.getSingleModul(type: type, search: search)
        : await ModulService.getMultipleModuls(type: type, search: search);
    if (result.value == null) {
      return ApiReturnValue(value: false, message: result.message);
    }

    if (isSingle) {
      modul = result.value as ModulModel;
    } else {
      moduls = result.value as List<ModulModel>;
      filteredModuls = result.value as List<ModulModel>;
    }
    update(['modulList']);

    return ApiReturnValue(value: true, message: null);
  }

  Future<ApiReturnValue<bool>> isquizable({required int quizId}) async =>
      await QuizService.isquizable(quizId: quizId);

  Future<ApiReturnValue<bool>> getresults() async {
    final result = await QuizService.getresults();
    if (result?.value == null) {
      return ApiReturnValue(value: false, message: result!.message);
    }
    quizResults = result!.value as List<QuizResultModel>;
    return ApiReturnValue(value: true, message: null);
  }

  void search(String? search) {
    if (search == null) {
      filteredModuls = moduls;
    } else {
      filteredModuls = moduls
          ?.where((element) =>
              element.name!.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    update(['modulList']);
  }

  Future<ApiReturnValue<UserModel?>> getDataUser() async =>
      await AuthService.getDataUser();

  Future<ApiReturnValue<bool>> logout() async => await AuthService.logout();

  void notifAbsent() {
    Get.defaultDialog(
      title: 'Halo',
      middleText:
          "Selamat datang kembali ${user!.fullName}\n${DateFormat.yMMMd().format(DateTime.now())}",
      barrierDismissible: false,
      onConfirm: () async => await AuthService.checkIn().then((response) =>
          response.value ?? false
              ? Get.back()
              : Get.snackbar('Error', response.message ?? 'Error')),
      textConfirm: 'Check in',
      confirmTextColor: Colors.white,
    );
  }

  @override
  void onInit() async {
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await getDataUser()
        .then((value) {
          user = value.value;
          update(['user']);
        })
        .then((value) async => await AuthService.checkAbsent())
        .then((value) =>
            value.value ?? false ? notifAbsent() : print('sudah absen'));
    super.onInit();
  }
}
