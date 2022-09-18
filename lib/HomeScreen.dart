import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Memo",
              style: TextStyle(
                  color: Color(0xFF17181d),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Color(0xFFF37878))),
                filled: true,
                fillColor: Color(0xFFCFCFCF),
                contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                hintText: "검색어를 입력해주세요",
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                selectBox("기본순", true),
                const SizedBox(width: 5,),
                selectBox("날짜순", false),
                const SizedBox(width: 5,),
                selectBox("중요글만", false),
                const SizedBox(width: 5,),
                selectBox("비밀글만", false)
              ],
            ),
            const SizedBox(height: 10,),
            memoListItem(const Color(0xFFF37878), const Color(0xFFFFBEBE))
          ],
        ),
      ),
    );
  }
}

Widget selectBox(String text, bool isSelect) {
  var textColor = const Color(0xFF17181D);
  if (isSelect) {
    textColor = const Color(0xFFFAFAFA);
  }
  var backgroundColor = const Color(0xFFCFCFCF);
  if (isSelect) {
    backgroundColor = const Color(0xFFF37878);
  }

  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: backgroundColor),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
  );
}

Widget memoListItem(Color mainColor, Color subColor) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: subColor
    ),
    child:Column(
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                  color: mainColor
              ),
            ),
          ],
        )
      ],
    ),
  );
}