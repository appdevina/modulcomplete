part of 'screens.dart';

class QuizScreen extends StatelessWidget {
  final controller = Get.put(QuizController(quizId: Get.arguments as int));
  QuizScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Quiz',
          style: appTitle.copyWith(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (context) => _confirmDialog(context)),
              child: Text(
                'Keluar',
                style: subtTitle.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GetBuilder<QuizController>(
          id: 'quiz',
          builder: (_) => controller.quizes == null
              ? const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 42, 58, 97),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          controller.quizes![controller.index].question!,
                          style: subtTitle.copyWith(
                              fontSize: 24, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: controller
                              .quizes![controller.index].options!
                              .map((e) => QuizOpsi(
                                  opsi: e.content!,
                                  ontap: () async {
                                    controller.timer?.cancel();
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.setInt('index', controller.index + 1);
                                    await controller
                                        .answer(
                                          questionId: controller
                                              .quizes![controller.index].id!,
                                          quizId: controller
                                              .quizes![controller.index]
                                              .quizId!,
                                          quizOptionId: controller
                                              .quizes![controller.index]
                                              .options!
                                              .firstWhere((element) =>
                                                  element.content == e.content)
                                              .id!,
                                          value: e.content! ==
                                              controller
                                                  .quizes![controller.index]
                                                  .options!
                                                  .firstWhere((element) =>
                                                      element.isTrue!)
                                                  .content,
                                        )
                                        .then(
                                          (value) => value.value!
                                              ? showDialog<String>(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) =>
                                                      WillPopScope(
                                                    child: resultDialog(
                                                      context,
                                                      e.content! ==
                                                          controller
                                                              .quizes![
                                                                  controller
                                                                      .index]
                                                              .options!
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .isTrue!)
                                                              .content,
                                                      e.content!,
                                                      correctAnswer: controller
                                                          .quizes![controller
                                                              .index]
                                                          .options!
                                                          .firstWhere(
                                                              (element) =>
                                                                  element
                                                                      .isTrue!)
                                                          .content,
                                                    ),
                                                    onWillPop: () =>
                                                        Future.value(false),
                                                  ),
                                                )
                                              : snackbar(context, value.value!,
                                                  value.message!),
                                        );
                                  }))
                              .toList(),
                        ),
                      ),
                      Obx(
                        () => Container(
                            height: 70,
                            width: 70,
                            margin: const EdgeInsets.only(top: 30),
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(
                                  color: controller.time.value < 10
                                      ? Colors.red
                                      : controller.time.value < 20
                                          ? Colors.yellow
                                          : Colors.green,
                                  width: 4),
                            ),
                            child: Text(
                              controller.time.value.toString(),
                              textAlign: TextAlign.center,
                              style: subtTitle.copyWith(
                                  fontSize: 30,
                                  color: controller.time.value < 10
                                      ? Colors.red[400]
                                      : controller.time.value < 20
                                          ? Colors.yellow[400]
                                          : Colors.green[400]),
                            )),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  _confirmDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Keluar",
        style: title,
      ),
      content: Text(
        'Apakah anda yakin keluar dari quiz sekarang dan tidak mendapatkan nilai',
        style: subtTitle,
      ),
      actions: [
        TextButton(
            onPressed: () async =>
                await controller.calculate(quizId: controller.quizId!).then(
                  (value) async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove('modequiz');
                    pref.remove('quizid');
                    pref.remove('index');
                    pref.remove('quiz_time');

                    value.value != null
                        ? Get.offAll(
                            () => QuizResult(
                              result: value.value!,
                            ),
                            transition: Transition.cupertino,
                          )
                        : snackbar(context, false, value.message!);
                  },
                ),
            child: Text(
              "YES",
              style: subtTitle.copyWith(color: Colors.green[400]),
            )),
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "NO",
              style: subtTitle.copyWith(color: Colors.red[400]),
            )),
      ],
    );
  }

  resultDialog(BuildContext context, bool isTrue, String answer,
      {String? correctAnswer}) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      title: Text(
        isTrue ? "Benar" : "Salah",
        textAlign: TextAlign.center,
        style: title,
      ),
      scrollable: false,
      content: Container(
        padding: const EdgeInsets.all(10),
        height: isTrue ? 200 : 400,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Jawaban anda :",
                  textAlign: TextAlign.center,
                  style: subtTitle,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: isTrue ? Colors.green[800] : Colors.red[600]),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Text(
                      answer,
                      textAlign: TextAlign.center,
                      style: subtTitle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            isTrue
                ? const SizedBox()
                : Column(
                    children: [
                      Text(
                        "Jawaban yang benar :",
                        textAlign: TextAlign.center,
                        style: subtTitle,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.green[600]),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            correctAnswer!,
                            textAlign: TextAlign.center,
                            style: subtTitle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
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
          onPressed: () async {
            if (controller.index < controller.quizes!.length - 1) {
              Get.back();
              controller.next();
            } else {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('modequiz');
              pref.remove('quizid');
              pref.remove('index');
              pref.remove('quiz_time');

              await controller.calculate(quizId: controller.quizId!).then(
                  (value) => value.value != null
                      ? Get.offAll(() => QuizResult(result: value.value!))
                      : snackbar(context, false, value.message!));
            }
          },
        )
      ],
    );
  }
}
