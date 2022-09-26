import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class MyTitle extends StatelessWidget {
  const MyTitle(
      {Key? key,
      this.onBackClick,
      this.onImportanceClick,
      this.isImportance = false,
      this.isDetail = false})
      : super(key: key);

  final VoidCallback? onBackClick;
  final VoidCallback? onImportanceClick;
  final bool isDetail;
  final bool isImportance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onBackClick ??
              () {
                Navigator.pop(context);
              },
          child: SvgPicture.asset("assets/images/ic_prev.svg"),
        ),
        if (isDetail)
          GestureDetector(
            onTap: onImportanceClick,
            child: SvgPicture.asset(isImportance
                ? "assets/images/ic_star_fill.svg"
                : "assets/images/ic_star.svg"),
          ),
      ],
    );
  }
}
