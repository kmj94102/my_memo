import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database/MemoItem.dart';
import '../../util/colors.dart';
import '../write/WriteScreen.dart';

/// 바디 : 제목, 내용, 색상, 비밀 메모 설정
class WriteBody extends StatefulWidget {
  const WriteBody({Key? key, required this.memoItem}) : super(key: key);

  final MemoItemModify memoItem;

  @override
  State<WriteBody> createState() => _WriteBodyState();
}

class _WriteBodyState extends State<WriteBody> {
  var _color = MemoColor.getByGroup(1);
  var _isSecret = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 타이틀
        customTextField(
            hint: "타이틀을 입력해주세요",
            mainColor: _color.mainColor,
            subColor: _color.subColor,
            onChange: (value) {
              widget.memoItem.title = value;
            }),
        const SizedBox(
          height: 7,
        ),

        /// 내용 카운트
        Row(children: [
          Expanded(
              child: Text(
            "${widget.memoItem.contents.length}",
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ))
        ]),
        const SizedBox(
          height: 7,
        ),
        customTextField(
          hint: "내용을 입력해주세요",
          mainColor: _color.mainColor,
          subColor: _color.subColor,
          isContents: true,
          onChange: (value) {
            setState(() {
              widget.memoItem.contents = value;
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),

        /// 메모 색상 설정
        Row(
          children: [
            selectColorWidget(onTap: () {
              setState(() {
                widget.memoItem.colorGroup = 1;
                _color = MemoColor.getByGroup(1);
              });
            }),
            const SizedBox(
              width: 10,
            ),
            selectColorWidget(
                mainColor: getMainOrange(),
                subColor: getSubOrange(),
                onTap: () {
                  setState(() {
                    widget.memoItem.colorGroup = 2;
                    _color = MemoColor.getByGroup(2);
                  });
                }),
            const SizedBox(
              width: 10,
            ),
            selectColorWidget(
                mainColor: getMainGreen(),
                subColor: getSubGreen(),
                onTap: () {
                  setState(() {
                    widget.memoItem.colorGroup = 3;
                    _color = MemoColor.getByGroup(3);
                  });
                }),
            const SizedBox(
              width: 10,
            ),
            selectColorWidget(
                mainColor: getMainYellow(),
                subColor: getSubYellow(),
                onTap: () {
                  setState(() {
                    _color = MemoColor.getByGroup(4);
                  });
                }),
          ],
        ),

        const SizedBox(height: 15,),
        /// 비밀 메모 설정
        GestureDetector(
          child: Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                    value: _isSecret,
                    activeColor: _color.mainColor,
                    onChanged: (value) {
                      setState(() {
                        _isSecret = !_isSecret;
                        widget.memoItem.isSecret = _isSecret;
                      });
                    }),
              ),
              const SizedBox(width: 6,),
              const Text("비밀 메모 설정"),
            ],
          ),
          onTap: (){
            setState(() {
              _isSecret = !_isSecret;
              widget.memoItem.isSecret = _isSecret;
            });
          },
        ),
        const SizedBox(height: 10,),
        if(_isSecret)
          customTextField(
            mainColor: _color.mainColor,
            subColor: _color.subColor,
            isSecret: true,
            hint: "비밀번호를 입력해주세요",
            onChange: (value){
              widget.memoItem.password = value;
            }
          )
      ],
    );
  }
}
