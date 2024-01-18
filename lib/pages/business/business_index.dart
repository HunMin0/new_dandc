import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/layout/default_layout.dart';
import 'package:Deal_Connect/pages/business/components/business_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 사업장찾기
class BusinessIndex extends StatelessWidget {
  const BusinessIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBasicLayout(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                onSubmitted: (value) {
                                  print(value);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: HexColor("#F5F6FA"),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10), // 테두리를 둥글게 설정
                                    borderSide: BorderSide.none, // 바텀 border 없애기
                                  ),
                                  prefixIcon: Icon(Icons.search_rounded),
                                  hintText: '검색 키워드를 입력해주세요',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ])
            )
          ];
        },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: BusinessTabBar()),
            ],
          ),
        )
    );
  }
}
