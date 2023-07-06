part of 'widgets.dart';

class HomeMenu extends StatelessWidget {
  final String title;
  final Function() onTap;
  final String urlAsset;
  const HomeMenu(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.urlAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 170,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              image: DecorationImage(
                  image: AssetImage(urlAsset), fit: BoxFit.cover),
            ),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: subtTitle
                  .copyWith(fontSize: 22, color: Colors.white, shadows: [
                const Shadow(
                  color: Colors.black,
                  blurRadius: 40,
                ),
                const Shadow(
                  color: Colors.black,
                  blurRadius: 40,
                ),
                const Shadow(
                  color: Colors.black,
                  blurRadius: 40,
                ),
              ]),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      );
}
