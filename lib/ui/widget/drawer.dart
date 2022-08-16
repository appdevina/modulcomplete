part of 'widgets.dart';

class MyDrawer extends GetView<HomeController> {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  height: 150,
                  width: double.infinity / 4,
                  child: GetBuilder<HomeController>(
                      id: 'user',
                      builder: (_) => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/file.png',
                                scale: 0.5,
                              ),
                              const Spacer(),
                              Text(
                                _.user?.fullName ?? '-',
                                style: title.copyWith(
                                    color: Colors.white, letterSpacing: 1),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${_.user?.divisi.name ?? '-'} - ${_.user?.joblevel.name ?? '-'}",
                                style: subtTitle.copyWith(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ))),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              DrawerListTile(
                ontap: () => Get.offAll(() => HomeScreen()),
                title: 'Home',
                icon: MdiIcons.home,
              ),
              DrawerListTile(
                ontap: () async => await controller.getresults().then((value) =>
                    (value.value ?? false)
                        ? Get.to(() => const QuizHistoryScreen())
                        : snackbar(context, value.value ?? false,
                            value.message ?? 'error')),
                title: 'History Quiz',
                icon: MdiIcons.history,
              ),
              const Spacer(),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              DrawerListTile(
                ontap: () async => await controller.logout().then((value) =>
                    value.value ?? false
                        ? Get.offAll(() => LoginScreen())
                        : snackbar(context, value.value ?? false,
                            value.message ?? 'error')),
                title: 'Log Out',
                icon: MdiIcons.logout,
              ),
            ],
          ),
        ),
      );
}
