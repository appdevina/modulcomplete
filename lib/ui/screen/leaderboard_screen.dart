part of 'screens.dart';

class LeaderboardScreen extends GetView<HomeController> {
  LeaderboardScreen({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryOneColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryOneColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Leaderboard',
          style: appTitle.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            monthButton(context),
            GetBuilder<HomeController>(
                id: 'score', builder: (_) => _listScore()),
          ],
        ),
      ),
    );
  }

  _listScore() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            controller.quizScore[index].userModel == null
                ? const SizedBox()
                : ScoreTile(
                    quizGetScoreModel: controller.quizScore[index],
                    index: index,
                  ),
        itemCount: controller.quizScore.length,
      ),
    );
  }

  Widget monthButton(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          onPressed: () => showMonthPicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime(2025),
              ).then((value) {
                if (value != null) {
                  homeController.selectedMonth.value =
                      DateFormat('MMM-yyyy').format(value);
                  homeController.getscore(value);
                }
              }),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Obx(
            () => Text(
              'Pick Month : ${homeController.selectedMonth.value}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
