import 'package:Deal_Connect/api/qna.dart';
import 'package:Deal_Connect/components/common_item/color_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/qna.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MoreQnaIndex extends StatefulWidget {
  const MoreQnaIndex({super.key});

  @override
  State<MoreQnaIndex> createState() => _MoreQnaIndexState();
}

class _MoreQnaIndexState extends State<MoreQnaIndex> {
  List<Qna> qnaList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getQnas().then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Qna>? resData =
        List<Qna>.from(iterable.map((e) => Qna.fromJSON(e)));
        setState(() {
          if (resData != null) {
            qnaList = resData;
          }
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Loading();
    }
    return DefaultNextLayout(
      isNotInnerPadding: 'true',
      titleName: '고객센터',
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: () {
        Navigator.pushNamed(context, '/more/qna/create').then((value) {
          _initData();
        });
      },
      nextTitle: '문의하기',
      prevTitle: '',
      isProcessable: true,
      bottomBar: true,
      child: Column(
        children: [
          qnaList != null && qnaList!.isNotEmpty
              ? Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf5f6f8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13.0),
                  child: ListView.builder(
                    itemCount: qnaList!.length,
                    itemBuilder: (context, index) {
                      Qna item = qnaList![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/more/qna/info',
                              arguments: {'qnaId': item.id}).then((value) {
                            _initData();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: HexColor("#ffffff"),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.all(13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title,
                                      style: SettingStyle.TITLE_STYLE, overflow: TextOverflow.ellipsis,),
                                    Text(item.created_at!.substring(0, 16),
                                        style: SettingStyle.SUB_GREY_TEXT)
                                  ],
                                ),
                              ),
                              Spacer(),
                              ColorChip(
                                  chipText: item.has_answer ? '답변완료' : "답변대기",
                                  color: item.has_answer
                                      ? SettingStyle.MAIN_COLOR
                                      : SettingStyle.PRIMARY_COLOR,
                                  textColor: HexColor("#ffffff"))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ))
              : NoItems(),
        ],
      ),
    );
  }
}
