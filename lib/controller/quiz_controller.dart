part of 'controllers.dart';

class QuizController extends GetxController {
  QuizController({required this.quizId});
  int? quizId;
  List<QuizQuestionModel>? quizes;
  RxInt time = 30.obs;
  Timer? timer;
  int index = 0;

  Future<ApiReturnValue<List<QuizQuestionModel>>> getQuestion(
          {required int quizId}) async =>
      QuizService.getQuestion(quizId: quizId);

  void startTimer({int? seconds}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    time.value = prefs.getInt('quiz_time') ?? seconds ?? 30;
    if (time.value == 0) time.value = seconds ?? 30;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (time.value > 0) {
        time.value--;
        prefs.setInt('quiz_time', time.value);
      } else {
        t.cancel();
        notifExpired();
      }
    });
  }

  Future<ApiReturnValue<bool>> answer({
    required int questionId,
    required int quizId,
    required int quizOptionId,
    required bool value,
  }) async =>
      await QuizService.answer(
        questionId: questionId,
        quizId: quizId,
        quizOptionId: quizOptionId,
        value: value,
      );

  Future<ApiReturnValue<QuizResultModel>> calculate({
    required int quizId,
  }) async {
    final result = await QuizService.calculate(quizId: quizId);
    if (result.value == null) {
      return ApiReturnValue(value: null, message: result.message);
    }
    return ApiReturnValue(value: result.value, message: result.message);
  }

  void notifExpired() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (index == quizes!.length - 1) {
      pref.remove('modequiz');
      pref.remove('quizid');
      pref.remove('quiz_time');
      await calculate(quizId: quizId!).then((value) => (value.value != null)
          ? Get.offAll(() => QuizResult(result: value.value!))
          : null);
    } else {
      pref.setInt('index', index + 1);
      pref.setInt('quiz_time', 0);
    }
    Get.defaultDialog(
      onWillPop: () => Future.value(false),
      barrierDismissible: false,
      title: '',
      content: Container(
        height: 250,
        width: 400,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/alarm-clock.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Text(
              'Waktu Anda Telah Habis',
              style: subtTitle,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Get.back();
                next();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 56, 111, 156)),
              ),
              icon: const Icon(Icons.arrow_circle_right_outlined,
                  color: Colors.white),
              label: Text(
                "Lanjut",
                style: generalText.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void next() async {
    if (index < quizes!.length - 1) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      index++;
      pref.setInt('quiz_time', 0);
      startTimer(seconds: quizes?[index].seconds ?? 30);
      update(['quiz']);
    }
  }

  @override
  void onClose() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('modequiz');
    pref.remove('quizid');
    pref.remove('quiz_time');
    timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() async {
    final pref = await SharedPreferences.getInstance();
    index = pref.getInt('index') ?? 0;
    await getQuestion(quizId: quizId!).then((value) {
      if (value.value != null) {
        quizes = value.value;
        startTimer(seconds: quizes?[index].seconds ?? 30);
        update(['quiz']);
      }
    });
    super.onInit();
  }
}
