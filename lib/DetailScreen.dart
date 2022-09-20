import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

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
              detailHeader(),
              const SizedBox(height: 24,),
              /// 바디 : 메모 제목 + 내용
              Expanded(child: detailBody("제목이 들어갑니다", "내용이 들어갑니다")),

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
  Widget detailBody(String title, String content) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF17181D)),),
        const SizedBox(height: 5,),
        const Divider(height: 1, color: Color(0xFF17181D),),
        const SizedBox(height: 15,),
        Container(
          padding: const EdgeInsets.all(18),
          constraints: const BoxConstraints(
            minHeight: 100,
            minWidth: double.infinity
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFFBEBE),
            border:  Border.all(width: 1, color: const Color(0xFFF37878))
          ),
          child: Text(content, style: const TextStyle(fontSize: 14),),
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
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF191A1E)),
              backgroundColor: const Color(0xFFFAD9A1)),
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
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF191A1E)),
              backgroundColor: const Color(0xFFF37878)),
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
