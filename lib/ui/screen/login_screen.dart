part of 'screens.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: Form(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/file.png')),
                Text(
                  'Modul App',
                  style: title,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  controller: usernameController,
                  hintText: 'Username (NIK)',
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                TextFieldInput(
                  controller: passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async => await controller
                      .login(
                        username: usernameController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then((value) => value.value ?? false
                          ? Get.offAll(() => HomeScreen())
                          : snackbar(context, false, value.message ?? 'Error',
                              duration: 1000)),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blue,
                    ),
                    child: Obx(
                      () => controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                              'Login',
                              style: subtTitle.copyWith(
                                  color: Colors.white, letterSpacing: 3),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      );
}
