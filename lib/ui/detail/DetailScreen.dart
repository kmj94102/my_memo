import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_memo/database/MemoItem.dart';
import 'package:my_memo/database/MemoProvider.dart';
import 'package:my_memo/ui/common/MyTitle.dart';
import 'package:my_memo/ui/write/WriteScreen.dart';
import 'package:my_memo/util/colors.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  MemoItem memoItem = MemoItem();

  @override
  void initState() {
    super.initState();
    getMemoItem();
  }

  getMemoItem() async {
    memoItem = await MemoProvider().getMemoItem(id: widget.id) ?? MemoItem();
    setState(() {
      memoItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            children: [
              /// 헤더 : 상단 타이틀 영역
              MyTitle(
                isImportance: memoItem.isImportance,
                isDetail: true,
                onImportanceClick: () {
                  MemoProvider().updateImportance(
                      id: memoItem.id, value: !memoItem.isImportance);
                  getMemoItem();
                },
              ),
              const SizedBox(
                height: 24,
              ),

              /// 바디 : 메모 제목 + 내용
              Expanded(child: detailBody(memoItem)),

              /// 풋터 : 수정/삭제 버튼
              detailFooter(),
            ],
          ),
        ),
      ),
    );
  }

  /// 상단 타이틀 영역
  Widget detailHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("assets/images/ic_prev.svg"),
        SvgPicture.asset("assets/images/ic_star.svg"),
      ],
    );
  }

  /// 바디 : 메모 제목 + 내용
  Widget detailBody(MemoItem memoItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          memoItem.title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF17181D)),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          height: 1,
          color: Color(0xFF17181D),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(18),
          constraints:
              const BoxConstraints(minHeight: 300, minWidth: double.infinity),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MemoColor.getByGroup(memoItem.colorGroup).subColor,
              border: Border.all(
                  width: 1,
                  color: MemoColor.getByGroup(memoItem.colorGroup).mainColor)),
          child: Text(
            memoItem.contents,
            style: const TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }

  /// 풋터 : 수정/삭제 버튼
  Widget detailFooter() {
    return Row(
      children: [
        Expanded(
            child: OutlinedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return WriteScreen(
                id: widget.id,
              );
            }));
          },
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF191A1E)),
              backgroundColor: const Color(0xFFFAD9A1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text(
            "수정하기",
            style: TextStyle(
              color: Color(0xFFFAFAFA),
              fontSize: 16,
            ),
          ),
        )),
        const SizedBox(
          width: 24,
        ),
        Expanded(
            child: OutlinedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("메모 삭제"),
                      content: const Text("선택한 메모를 삭제하시겠습니까?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              MemoProvider().deleteMemo(id: widget.id).then(
                                  (value) => Navigator.pop(context, 'OK'));
                            },
                            child: const Text("확인"))
                      ],
                    )).then((value) => Navigator.of(context).pop());
          },
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF191A1E)),
              backgroundColor: const Color(0xFFF37878),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text(
            "삭제하기",
            style: TextStyle(
              color: Color(0xFFFAFAFA),
              fontSize: 16,
            ),
          ),
        )),
      ],
    );
  }
}
