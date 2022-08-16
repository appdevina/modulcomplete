part of 'screens.dart';

class ModulListScreen extends GetView<HomeController> {
  final String title;
  final String hintText;
  final bool isModul;
  const ModulListScreen(
      {Key? key,
      required this.title,
      required this.hintText,
      this.isModul = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          controller.searchController.clear();
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: secondaryOneColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: secondaryOneColor,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              title,
              style: appTitle.copyWith(color: Colors.white),
            ),
          ),
          body: ListView(
            children: [
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: controller.searchController,
                    onChanged: (String? value) => controller.search(value),
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: hintText,
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height - 200,
                child: GetBuilder<HomeController>(
                  id: 'modulList',
                  builder: (_) => (controller.filteredModuls ?? []).isEmpty
                      ? Center(
                          child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/no-data.png'),
                                      fit: BoxFit.cover)),
                            ),
                            Text(
                              controller.searchController.text.isEmpty
                                  ? 'Belum ada modul'
                                  : 'Tidak ditemukan modul',
                              style: subtTitle.copyWith(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ))
                      : ListView.builder(
                          itemCount: controller.filteredModuls?.length,
                          itemBuilder: (context, index) => Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            elevation: 10,
                            child: ListTileMenu(
                              asset: isModul ? 'file' : 'catalog',
                              ontap: () => Get.to(
                                  () => PdfScreen(
                                        modul: controller.moduls![index],
                                      ),
                                  transition: Transition.cupertino),
                              titleText: controller.filteredModuls![index].name,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
}
