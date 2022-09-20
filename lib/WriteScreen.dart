import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: const Color(0xFFFAFAFA),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            /// 헤더 : 타이틀 영역
            writeHeader(),
            const SizedBox(
              height: 20,
            ),

            /// 바디 : 제목, 내용, 색상, 비밀 메모 설정
            Expanded(child: writeBody()),
            writeFooter()
          ],
        ),
      ),
    ));
  }
}

/// 헤더 : 타이틀 영역
Widget writeHeader() {
  return Row(
    children: [SvgPicture.asset("assets/images/ic_prev.svg")],
  );
}

/// 바디 : 제목, 내용, 색상, 비밀 메모 설정
Widget writeBody() {
  return Column(
    children: [
      /// 타이틀
      customTextField(hint: "타이틀을 입력해주세요"),
      const SizedBox(
        height: 7,
      ),

      /// 내용 카운트
      Row(children: const [
        Expanded(
            child: Text(
          "100",
          textAlign: TextAlign.end,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ))
      ]),
      const SizedBox(
        height: 7,
      ),
      customTextField(hint: "내용을 입력해주세요", isContents: true),
      const SizedBox(
        height: 10,
      ),
      /// 메모 색상 설정
      Row(
        children: [
          selectColorWidget(),
          const SizedBox(
            width: 10,
          ),
          selectColorWidget(),
          const SizedBox(
            width: 10,
          ),
          selectColorWidget(),
          const SizedBox(
            width: 10,
          ),
          selectColorWidget(),
        ],
      ),

      /// 비밀 메모 설정
      secretMemoSetting()
    ],
  );
}

/// 커스텀 텍스트 필드
Widget customTextField(
    {Color mainColor = const Color(0xFFF37878),
    Color subColor = const Color(0xFFFFBEBE),
    bool isContents = false,
    String hint = ""}) {
  double minHeight = 0;
  int? maxLines = 1;
  if (isContents) {
    minHeight = 230;
    maxLines = null;
  }

  return Container(
    constraints: BoxConstraints(minHeight: minHeight),
    decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: subColor),
    child: TextField(
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          border: InputBorder.none,
          hintText: hint),
      cursorColor: mainColor,
      maxLines: maxLines,
    ),
  );
}

/// 메모 색상 선택
Widget selectColorWidget(
    {Color mainColor = const Color(0xFFF37878),
    Color subColor = const Color(0xFFFFBEBE)}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(60)),
        color: mainColor,
        border: Border.all(color: const Color(0xFF17181D), width: 1)),
    width: 60,
    height: 60,
  );
}

/// 비밀 메모 설정
Widget secretMemoSetting() {
  return Column(
    children: [
      CheckboxListTile(
        title: const Text("비밀 메모 설정"),
        value: false,
        onChanged: (_) {},
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
      customTextField(hint: "비밀번호를 입력해주세요"),
    ],
  );
}

/// 풋터 : 작성 완료
Widget writeFooter() {
  return Container(
    constraints: const BoxConstraints(minWidth: double.infinity),
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF17181D), width: 1),
        color: const Color(0xFFF37878),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: const Text(
      "작성완료",
      style: TextStyle(
          color: Color(0xFFFAFAFA), fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
  );
}
