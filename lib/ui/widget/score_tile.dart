part of 'widgets.dart';

class ScoreTile extends StatelessWidget {
  final QuizGetScoreModel quizGetScoreModel;
  final int index;
  const ScoreTile(
      {required this.quizGetScoreModel, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        "${index + 1}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(quizGetScoreModel.userModel!.fullName),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 110,
                      child: Text(
                        quizGetScoreModel.score.toString() + " point",
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
