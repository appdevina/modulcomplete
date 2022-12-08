part of 'widgets.dart';

class ModulListWidget extends GetView<HomeController> {
  const ModulListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: secondaryOneColor,
        body: Column(
          children: [
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (String? value) => controller.search(value),
                  autocorrect: true,
                  decoration: const InputDecoration(
                    hintText: 'Search Modul',
                    prefixIcon: Icon(Icons.search),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: GetBuilder<HomeController>(
                  id: 'modulList',
                  builder: (_) => controller.filteredModuls!.isEmpty
                      ? Center(
                          child: Text(
                            controller.searchController.text.isEmpty
                                ? 'Belum ada modul'
                                : 'Tidak ditemukan modul',
                            style: subtTitle.copyWith(
                                color: Colors.white, fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.filteredModuls!.length,
                          itemBuilder: (context, index) => Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            elevation: 10,
                            child: ListTileMenu(
                              ontap: () => Get.to(
                                  () => PdfScreen(
                                        modul:
                                            controller.filteredModuls![index],
                                      ),
                                  transition: Transition.cupertino),
                              titleText: controller.filteredModuls![index].name,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      );
}
