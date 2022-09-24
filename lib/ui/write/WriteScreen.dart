import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_memo/database/MemoItem.dart';
import 'package:my_memo/ui/common/Title.dart';
import '../detail/WriteBody.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  var memoItem = MemoItemModify();
  final controller = TextEditingController();
  int count = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: const Color(0xFFFAFAFA),
        padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
        child: Column(
          children: [
            /// 타이틀
            const MyTitle(),
            const SizedBox(
              height: 20,
            ),
            /// 바디 : 제목, 내용, 색상, 비밀 메모 설정
            Expanded(
                child: SingleChildScrollView(
                    child: WriteBody(memoItem: memoItem,))),
            /// 풋터 : 작성 완료
            writeFooter(onPressed: () {
              insert(memoItem.mapper());
              Navigator.of(context).pop();
            })
          ],
        ),
      ),
    ));
  }
}

/// 커스텀 텍스트 필드
Widget customTextField(
    {Color mainColor = const Color(0xFFF37878),
    Color subColor = const Color(0xFFFFBEBE),
    bool isContents = false,
    bool isSecret = false,
    String hint = "",
    ValueChanged? onChange,
    TextEditingController? controller}) {
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
      onChanged: onChange,
      controller: controller,
      obscureText: isSecret,
    ),
  );
}

/// 메모 색상 선택
Widget selectColorWidget(
    {Color mainColor = const Color(0xFFF37878),
    Color subColor = const Color(0xFFFFBEBE),
    VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          color: mainColor,
          border: Border.all(color: const Color(0xFF17181D), width: 1)),
      width: 60,
      height: 60,
    ),
  );
}

/// 풋터 : 작성 완료
Widget writeFooter(
    {Color mainColor = const Color(0xFFF37878), VoidCallback? onPressed}) {
  return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: OutlinedButton(
        onPressed: () {
          onPressed?.call();
        },
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF191A1E)),
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: const Text(
          "작성완료",
          style: TextStyle(
              color: Color(0xFFFAFAFA),
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ));
}
