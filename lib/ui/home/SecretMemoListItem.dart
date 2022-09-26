import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../database/MemoItem.dart';

class SecretMemoListItem extends StatefulWidget {
  const SecretMemoListItem(
      {Key? key,
      required this.memoItem,
      required this.context,
      required this.onTap})
      : super(key: key);
  final MemoItem memoItem;
  final BuildContext context;
  final ValueChanged<int> onTap;

  @override
  State<SecretMemoListItem> createState() => _SecretMemoListItemState();
}

class _SecretMemoListItemState extends State<SecretMemoListItem> {
  final _formKey = GlobalKey<FormState>();
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFCFCFCF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("비밀 메모입니다."),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            obscureText: true,
                            controller: controller,
                            decoration:
                                const InputDecoration(hintText: "비밀번호를 입력해주세요", isDense: true),
                            validator: (value) {
                              if (value != widget.memoItem.password) {
                                return "비밀번호를 확인해주세요";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context, 'OK');
                              widget.onTap(widget.memoItem.id);
                            }
                          },
                          child: const Text("확인"))
                    ],
                  ));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/ic_lock.svg"),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "비밀메모 입니다.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
