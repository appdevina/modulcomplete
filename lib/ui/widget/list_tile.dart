part of 'widgets.dart';

class ListTileMenu extends StatelessWidget {
  final Function()? ontap;
  final String? titleText;
  final String asset;
  const ListTileMenu(
      {Key? key,
      required this.ontap,
      required this.titleText,
      this.asset = 'file'})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: ontap,
        leading: Container(
          height: 30,
          width: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$asset.png'), fit: BoxFit.fitHeight),
          ),
        ),
        trailing: const Icon((Icons.arrow_circle_right_rounded)),
        title: Text(
          titleText!,
          style: subtTitle,
          overflow: TextOverflow.ellipsis,
        ),
      );
}
