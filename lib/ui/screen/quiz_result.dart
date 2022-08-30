part of 'screens.dart';

class QuizResult extends StatelessWidget {
  final QuizResultModel result;
  QuizResult({Key? key, required this.result}) : super(key: key);

  final List<int> point = [0, 20, 40, 80, 90];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryOneColor,
        appBar: AppBar(
          backgroundColor: secondaryOneColor,
          elevation: 0,
          title: Text(
            'Quiz Result',
            style: appTitle.copyWith(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Text(
                  'Keluar',
                  style: subtTitle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Quiz Selesai',
                      style:
                          subtTitle.copyWith(color: Colors.white, fontSize: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: point
                          .map(
                            (e) => SizedBox(
                              height: 60,
                              width: 60,
                              child: Image.asset(
                                  'assets/star${(result.value ?? 0) >= e ? 'fill' : 'blank'}.png'),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Nilai Anda :',
                      style:
                          subtTitle.copyWith(color: Colors.white, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${result.value}',
                      style: title.copyWith(color: Colors.white, fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
