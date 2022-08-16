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
                title: 'Operasional',
                onTap: () async => await controller
                    .getDocument(isSingle: false, type: 'operational')
                    .then(
                      (value) => value.value ?? false
                          ? Get.to(
                              () => const ModulListScreen(
                                title: 'Operasional',
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
                      title: 'Penjualan',
                      onTap: () async => await controller
                          .getDocument(isSingle: false, type: 'sales')
                          .then(
                            (value) => value.value ?? false
                                ? Get.to(
                                    () => const ModulListScreen(
                                      title: 'Penjualan',
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
                      title: 'Pelayanan',
                      onTap: () async => await controller
                          .getDocument(isSingle: false, type: 'service')
                          .then(
                            (value) => value.value ?? false
                                ? Get.to(
                                    () => const ModulListScreen(
                                      title: 'Pelayanan',
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
            ],
          ),
        ),
      );
}
