part of 'screens.dart';

class JobDetailsScreen extends GetView<HomeController> {
  JobDetailsScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryOneColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: secondaryOneColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Penjelasan Pekerjaan',
            style: appTitle.copyWith(color: Colors.white),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              HomeMenu(
                urlAsset: 'assets/operasional.jpg',
                title: 'Basic 1',
                onTap: () async => await controller
                    .getDocument(isSingle: false, type: 'operational')
                    .then(
                      (value) => value.value ?? false
                          ? Get.to(
                              () => const ModulListScreen(
                                title: 'Basic 1',
                                hintText: 'Search Modul',
                              ),
                              transition: Transition.cupertino,
                            )
                          : snackbar(context, false, value.message ?? 'Error',
                              duration: 1000),
                    ),
              ),
              ((homeController.user?.divisi.id ?? 0) == 10)
                  ? HomeMenu(
                      urlAsset: 'assets/penjualan.jpg',
                      title: 'Basic 2',
                      onTap: () async => await controller
                          .getDocument(isSingle: false, type: 'sales')
                          .then(
                            (value) => value.value ?? false
                                ? Get.to(
                                    () => const ModulListScreen(
                                      title: 'Basic 2',
                                      hintText: 'Search Modul',
                                    ),
                                    transition: Transition.cupertino,
                                  )
                                : snackbar(
                                    context, false, value.message ?? 'Error',
                                    duration: 1000),
                          ),
                    )
                  : const SizedBox(),
              ((homeController.user?.divisi.id ?? 0) == 10)
                  ? HomeMenu(
                      urlAsset: 'assets/pelayanan.jpg',
                      title: 'Basic 3',
                      onTap: () async => await controller
                          .getDocument(isSingle: false, type: 'service')
                          .then(
                            (value) => value.value ?? false
                                ? Get.to(
                                    () => const ModulListScreen(
                                      title: 'Basic 3',
                                      hintText: 'Search Modul',
                                    ),
                                    transition: Transition.cupertino,
                                  )
                                : snackbar(
                                    context, false, value.message ?? 'Error',
                                    duration: 1000),
                          ),
                    )
                  : const SizedBox(),
              HomeMenu(
                urlAsset: 'assets/quiz.jpg',
                title: 'Quiz',
                onTap: () async => await controller
                    .getDocument(isSingle: false, type: 'quiz')
                    .then(
                      (value) => value.value ?? false
                          ? Get.to(
                              () => const ModulListScreen(
                                title: 'Quiz',
                                hintText: 'Search Modul',
                              ),
                              transition: Transition.cupertino,
                            )
                          : snackbar(context, false, value.message ?? 'Error',
                              duration: 1000),
                    ),
              ),
            ],
          ),
        ),
      );
}
