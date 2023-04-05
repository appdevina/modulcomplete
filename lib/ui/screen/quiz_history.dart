part of 'screens.dart';

class QuizHistoryScreen extends GetView<HomeController> {
  const QuizHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryOneColor,
      drawer: GetBuilder<HomeController>(
        id: 'user',
        builder: (_) => MyDrawer(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryOneColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Quiz History',
          style: appTitle.copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: controller.quizResults.isNotEmpty
            ? ListView.builder(
                itemCount: controller.quizResults.length,
                itemBuilder: (context, index) => QuizHistoryListTile(
                      history: controller.quizResults[index],
                    ))
            : Center(
                child: Text('No Quiz History',
                    style:
                        title.copyWith(color: Colors.white, letterSpacing: 2)),
              ),
      ),
    );
  }
}
