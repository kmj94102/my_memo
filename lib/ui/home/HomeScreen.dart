import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_memo/database/MemoItem.dart';
import 'package:my_memo/ui/write/WriteScreen.dart';
import 'package:my_memo/util/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFFAFAFA),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 타이틀
                mainTitle(),
                const SizedBox(height: 10),

                /// 조건 영역 : 검색 + 검색 조건
                conditionArea(),
                const SizedBox(
                  height: 10,
                ),

                /// 메모 리스트 아이템
                Expanded(
                  child: FutureBuilder(
                    future: getMemoList(),
                    builder: (context, AsyncSnapshot<List<MemoItem>> snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var list = snapshot.data ?? [];

                      return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            var item = list[index];
                            return Column(
                              children: [
                                memoListItem(
                                    memoItem: item),
                                const SizedBox(height: 10,)
                              ],
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: customFloat(context)),
    );
  }
}

/// 메인 타이틀
Widget mainTitle() {
  return const Text(
    "Memo",
    style: TextStyle(
        color: Color(0xFF17181d), fontSize: 24, fontWeight: FontWeight.bold),
  );
}

/// 조건 영역
Widget conditionArea() {
  return Column(
    children: [
      /// 검색 창
      searchField(),
      const SizedBox(
        height: 10,
      ),

      /// 검색 조건 선택
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          conditionSelectBox("기본순", true),
          const SizedBox(
            width: 5,
          ),
          conditionSelectBox("날짜순", false),
          const SizedBox(
            width: 5,
          ),
          conditionSelectBox("중요글만", false),
          const SizedBox(
            width: 5,
          ),
          conditionSelectBox("비밀글만", false)
        ],
      ),
    ],
  );
}

/// 검색 창
Widget searchField() {
  return TextFormField(
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
  );
}

/// 조건 선택 아이템
Widget conditionSelectBox(String text, bool isSelect) {
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

/// 메모 리스트 아이템
Widget memoListItem({
  required MemoItem memoItem
}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(memoItem.timestamp);

  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: MemoColor.getByGroup(memoItem.colorGroup).subColor),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: MemoColor.getByGroup(memoItem.colorGroup).mainColor),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memoItem.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Text(
                        "${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color(0x80000000)),
                      )),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset("assets/images/ic_trash.svg"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset("assets/images/ic_star.svg"),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ));
}

/// Float 아이템
Widget customFloat(context) {
  return InkWell(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const WriteScreen();
      }));
    },
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: const Color(0xFF17181D)),
          color: const Color(0xFFF37878),
          boxShadow: const [
            BoxShadow(
                color: Color(0x40000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          "assets/images/ic_write.svg",
          color: Colors.white,
        ),
      ),
    ),
  );
}
