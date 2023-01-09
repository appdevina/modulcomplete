part of 'screens.dart';

class BudayaDetailsScreen extends GetView<HomeController> {
  BudayaDetailsScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryOneColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: secondaryOneColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Budaya Perusahaan',
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
                urlAsset: 'assets/handclap.jpg',
                title: 'Budaya Perusahaan',
                onTap: () async => await controller
                    .getDocument(
                        isSingle: true,
                        type: 'general',
                        search: 'budaya perusahaan')
                    .then((value) => value.value ?? false
                        ? Get.to(() => PdfScreen(
                            modul: controller.modul ?? const ModulModel()))
                        : snackbar(context, false, value.message ?? 'Error',
                            duration: 1000)),
              ),
              ((homeController.user?.divisi.id ?? 0) == 10)
                  ? HomeMenu(
                      urlAsset: 'assets/coins.jpg',
                      title: 'Budaya Penjualan',
                      onTap: () async => await controller
                          .getDocument(
                              isSingle: true,
                              type: 'budaya-sales',
                              search: 'budaya perusahaan sales')
                          .then((value) => value.value ?? false
                              ? Get.to(() => PdfScreen(
                                  modul:
                                      controller.modul ?? const ModulModel()))
                              : snackbar(
                                  context, false, value.message ?? 'Error',
                                  duration: 1000)),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      );
}
