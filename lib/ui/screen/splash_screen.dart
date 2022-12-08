part of 'screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future setUp() async {
    final pref = await SharedPreferences.getInstance();
    bool quizMode = pref.getBool('modequiz') ?? false;
    String? token = pref.getString('token');
    if (quizMode && token != null) {
      await checkToken().then((value) async => (value.value != null)
          ? Get.offAll(
              () => QuizScreen(),
              arguments: pref.getInt('quizid'),
            )
          : await clearAllCredentials(pref).then((value) => Get.offAll(
                () => LoginScreen(),
              )));

      return;
    }

    if (token != null) {
      await checkToken().then((value) async => value.value != null
          ? Get.offAll(() => HomeScreen())
          : await clearAllCredentials(pref)
              .then((_) => Get.offAll(() => LoginScreen())));
      return;
    }

    await clearAllCredentials(pref)
        .then((_) => Get.offAll(() => LoginScreen()));
    return;
  }

  Future clearAllCredentials(SharedPreferences pref) async =>
      await pref.clear();

  Future<ApiReturnValue<UserModel?>> checkToken() async =>
      await AuthService.getDataUser();

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => setUp());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff1F1D2B),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 130,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/file.png'),
                        fit: BoxFit.contain)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Modul App',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Ver 1.0.1',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      );
}
