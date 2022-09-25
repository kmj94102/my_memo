import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/MemoProvider.dart';

class ConditionSelect extends StatefulWidget {
  const ConditionSelect(
      {Key? key, required this.onSelected, required this.onChanged})
      : super(key: key);

  final ValueChanged<MemoListSearch> onSelected;
  final ValueChanged<String> onChanged;

  @override
  State<ConditionSelect> createState() => _ConditionSelectState();
}

class _ConditionSelectState extends State<ConditionSelect> {
  var selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 검색 창
        searchField(onChanged: widget.onChanged),
        const SizedBox(
          height: 10,
        ),

        /// 검색 조건 선택
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            conditionSelectBox(
                text: "기본순",
                isSelect: selectIndex == 0,
                onSelected: (value) {
                  setState(() {
                    selectIndex = 0;
                    widget.onSelected(MemoListSearch.searchDefault);
                  });
                }),
            const SizedBox(
              width: 5,
            ),
            conditionSelectBox(
                text: "날짜순",
                isSelect: selectIndex == 1,
                onSelected: (value) {
                  setState(() {
                    selectIndex = 1;
                    widget.onSelected(MemoListSearch.searchDate);
                  });
                }),
            const SizedBox(
              width: 5,
            ),
            conditionSelectBox(
                text: "중요글만",
                isSelect: selectIndex == 2,
                onSelected: (value) {
                  setState(() {
                    selectIndex = 2;
                    widget.onSelected(MemoListSearch.searchImportance);
                  });
                }),
            const SizedBox(
              width: 5,
            ),
            conditionSelectBox(
                text: "비밀글만",
                isSelect: selectIndex == 3,
                onSelected: (value) {
                  setState(() {
                    selectIndex = 3;
                    widget.onSelected(MemoListSearch.searchSecret);
                  });
                })
          ],
        ),
      ],
    );
  }
}

/// 검색 창
Widget searchField({required ValueChanged<String> onChanged}) {
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
    onChanged: onChanged,
  );
}

/// 조건 선택 아이템
Widget conditionSelectBox(
    {String text = "",
    bool isSelect = false,
    required ValueChanged<bool> onSelected}) {
  var textColor = const Color(0xFF17181D);
  if (isSelect) {
    textColor = const Color(0xFFFAFAFA);
  }

  return ChoiceChip(
    label: Text(
      text,
      style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
    ),
    selected: isSelect,
    onSelected: onSelected,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    selectedColor: const Color(0xFFF37878),
    backgroundColor: const Color(0xFFCFCFCF),
  );
}
