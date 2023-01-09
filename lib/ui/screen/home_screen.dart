part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeScreen({Key? key}) : super(key: key);

  String lastSeen = DateTime.now().toString();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryOneColor,
        drawer: const MyDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: secondaryOneColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Modul App',
            style: appTitle.copyWith(color: Colors.white),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // HomeMenu(
              //   title: 'Complete Selular',
              //   urlAsset: 'assets/complete.jpg',
              //   onTap: () async => await controller
              //       .getDocument(
              //           isSingle: true,
              //           type: 'general',
              //           search: 'complete selular')
              //       .then(
              //         (value) => value.value ?? false
              //             ? Get.to(
              //                 () => PdfScreen(
              //                     modul:
              //                         controller.modul ?? const ModulModel()),
              //               )
              //             : snackbar(context, false, value.message ?? 'Error',
              //                 duration: 1000),
              //       ),
              // ),
              HomeMenu(
                urlAsset: 'assets/budaya.jpg',
                title: 'Budaya Perusahaan',
                onTap: () => Get.to(
                  () => BudayaDetailsScreen(),
                  transition: Transition.cupertino,
                ),
              ),
              // HomeMenu(
              //   urlAsset: 'assets/csa.jpg',
              //   title: 'Pengenalan Program',
              //   onTap: () async => await controller
              //       .getDocument(
              //           isSingle: true,
              //           type: 'general',
              //           search: 'pengenalan program')
              //       .then(
              //         (value) => value.value ?? false
              //             ? Get.to(
              //                 () => PdfScreen(
              //                     modul:
              //                         controller.modul ?? const ModulModel()),
              //               )
              //             : snackbar(context, false, value.message ?? 'Error',
              //                 duration: 1000),
              //       ),
              // ),
              HomeMenu(
                  urlAsset: 'assets/job_desc.jpg',
                  title: 'Job Description',
                  onTap: () async {
                    final result1 = await controller.getDocument(
                        isSingle: true, type: 'general', search: 'job desc');
                    final result2 = await controller.getDocument(
                        isSingle: false, type: 'job-desc');

                    if ((result1.value ?? false) && (result2.value ?? false)) {
                      Get.to(() => const JobDescScreen());
                    } else {
                      snackbar(context, false, result1.message ?? 'Error',
                          duration: 1000);
                    }
                  }),
              HomeMenu(
                urlAsset: 'assets/explain_job.jpg',
                title: 'Penjelasan Pekerjaan',
                onTap: () => Get.to(
                  () => JobDetailsScreen(),
                  transition: Transition.cupertino,
                ),
              ),
              HomeMenu(
                urlAsset: 'assets/katalog.jpg',
                title: 'Katalog',
                onTap: () async {
                  final result = await controller.getDocument(
                      isSingle: false, type: 'katalog', search: 'katalog');
                  if (result.value ?? false) {
                    Get.to(() => const ModulListScreen(
                          title: 'Katalog',
                          hintText: 'Search Katalog',
                          isModul: false,
                        ));
                  } else {
                    snackbar(context, false, result.message ?? 'Error',
                        duration: 1000);
                  }
                },
              ),
            ],
          ),
        ),
      );
}
