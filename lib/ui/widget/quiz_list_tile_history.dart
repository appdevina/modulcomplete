part of 'widgets.dart';

class QuizHistoryListTile extends StatelessWidget {
  final QuizResultModel history;
  const QuizHistoryListTile({Key? key, required this.history})
      : super(key: key);

  String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy - HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
          child: ListTile(
            onTap: () => showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (context) => resultDialog(modul: history)),
            leading: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/file.png'), fit: BoxFit.fill),
              ),
            ),
            title: Text(
              history.quizModel?.modulModel?.name ?? 'Modul Error',
              style: subtTitle.copyWith(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "Start : ${formatDate(history.start ?? DateTime.now())} || End : ${formatDate(history.end ?? DateTime.now())}",
              style: subtTitle.copyWith(color: Colors.grey[600], fontSize: 10),
            ),
          ),
        ),
      );

  AlertDialog resultDialog({required QuizResultModel modul}) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      title: Column(
        children: [
          Text(
            modul.quizModel?.modulModel?.name ?? 'Result',
            textAlign: TextAlign.center,
            style: title.copyWith(fontSize: 16),
          ),
          Text(
            "Start : ${formatDate(history.start ?? DateTime.now())}\nEnd : ${formatDate(history.end ?? DateTime.now())}",
            textAlign: TextAlign.center,
            style: subtTitle.copyWith(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
      scrollable: false,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          PieCharResult(
              correct: modul.correctAnswer!.toDouble(),
              wrong: (modul.totalQuestion! - modul.correctAnswer!).toDouble()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardDetailResult(
                title: 'Pertanyaan',
                value: modul.totalQuestion.toString(),
              ),
              CardDetailResult(
                  title: "Nilai",
                  value: modul.value.toString(),
                  titleTooltip: 'Total Nilai'),
            ],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
          ),
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
          ),
          label: Text(
            "Kembali",
            style: generalText.copyWith(color: Colors.white),
          ),
          onPressed: () => Get.back(),
        )
      ],
    );
  }
}
