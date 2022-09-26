import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_memo/database/MemoItem.dart';
import 'package:my_memo/database/MemoProvider.dart';
import 'package:my_memo/ui/detail/DetailScreen.dart';
import 'package:my_memo/ui/home/ConditionSelect.dart';
import 'package:my_memo/ui/write/WriteScreen.dart';
import 'package:my_memo/util/colors.dart';

import 'SecretMemoListItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchState = MemoListSearch.searchDefault;
  var searchText = "";
  List<MemoItem> list = [];

  searchMemoList() async {
    list = await MemoProvider().getMemoList(searchState, searchText);
    setState(() {
      list;
    });
  }

  @override
  initState() {
    super.initState();
    searchMemoList();
  }

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
                ConditionSelect(onChanged: (value) {
                  setState(() {
                    searchText = value;
                    searchMemoList();
                  });
                }, onSelected: (value) {
                  setState(() {
                    searchState = value;
                    searchMemoList();
                  });
                }),
                const SizedBox(
                  height: 10,
                ),

                /// 메모 리스트 아이템
                Expanded(
                  child: (() {
                    if (list.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                              child: Text(
                            "작성된 메모가 없어요.",
                          ))
                        ],
                      );
                    } else {
                      return memoListWidget(
                          onChange: () {
                            searchMemoList();
                          },
                          list: list,
                          onTap: (id) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return DetailScreen(id: id);
                            })).then((value) => searchMemoList());
                          });
                    }
                  })(),
                )
              ],
            ),
          ),
          floatingActionButton: customFloat(
              context: context,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const WriteScreen();
                })).then((value) => searchMemoList());
              })),
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

Widget memoListWidget(
    {required VoidCallback onChange,
    required List<MemoItem> list,
    required ValueChanged<int> onTap}) {
  return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];
        return Column(
          children: [
            item.isSecret
                ? SecretMemoListItem(
                    memoItem: item, context: context, onTap: onTap)
                : memoListItem(
                    memoItem: item,
                    onChange: onChange,
                    onTap: onTap,
                    context: context),
            const SizedBox(
              height: 10,
            )
          ],
        );
      });
}

/// 메모 리스트 아이템
Widget memoListItem(
    {required MemoItem memoItem,
    required VoidCallback onChange,
    required ValueChanged<int> onTap,
    required BuildContext context}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(memoItem.timestamp);

  return GestureDetector(
    onTap: () {
      onTap(memoItem.id);
    },
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MemoColor.getByGroup(memoItem.colorGroup).subColor),
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
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("메모 삭제"),
                                      content: const Text("선택한 메모를 삭제하시겠습니까?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              MemoProvider()
                                                  .deleteMemo(id: memoItem.id)
                                                  .then((value) =>
                                                      Navigator.pop(
                                                          context, 'OK'));
                                            },
                                            child: const Text("확인"))
                                      ],
                                    )).then((value) => onChange());
                          },
                          child: SvgPicture.asset("assets/images/ic_trash.svg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            MemoProvider().updateImportance(
                                id: memoItem.id, value: !memoItem.isImportance);
                            onChange();
                          },
                          child: SvgPicture.asset(memoItem.isImportance
                              ? "assets/images/ic_star_fill.svg"
                              : "assets/images/ic_star.svg"),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        )),
  );
}

/// Float 아이템
Widget customFloat(
    {required BuildContext context, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
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
