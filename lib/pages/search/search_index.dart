import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/db/group_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/home/components/group_card.dart';
import 'package:Deal_Connect/pages/search/components/partner_card.dart';
import 'package:Deal_Connect/pages/search/components/search_keyword_item.dart';
import 'package:Deal_Connect/pages/search/search_partner_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchIndex extends StatefulWidget {
  String? searchKeyword;

  // super()를 사용하여 부모 클래스의 생성자 호출
  SearchIndex({
    this.searchKeyword = '',
    Key? key,
  }) : super(key: key);

  @override
  State<SearchIndex> createState() => _SearchIndexState();
}

class _SearchIndexState extends State<SearchIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultSearchLayout(
      isNotInnerPadding: 'true',
      onSubmit: (keyword) {
        setState(() {
          widget.searchKeyword = keyword;
        });
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: widget.searchKeyword != '' ?
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "검색결과",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(
                  color: HexColor("#F5F6FA"),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      itemCount: verticalDataList.length,
                      itemBuilder: (context, index){
                        Map<String, dynamic> verticalData = verticalDataList[index];

                        return GestureDetector(
                          onTap: (){
                            print('클릭했다~');
                          },
                          child: ListCard(
                            avaterImagePath: verticalData['avaterImagePath'],
                            bgImagePath: verticalData['bgImagePath'],
                            companyName: verticalData['companyName'],
                            userName: verticalData['userName'],
                            tagList: verticalData['tagList'],
                            newMark: verticalData['newMark'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "최근 검색 파트너",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _HorizontalList(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 10,
                  color: HexColor("#F5F6FA"),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "최근 검색어",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _VerticalList()
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}


class _VerticalList extends StatelessWidget {
  _VerticalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 500,
        child: ListView.builder(
            itemCount: groupDataList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> groupData = groupDataList[index];
              return Container(
                child: SearchKeywordItem(),
              );
            }
        )
    );
  }
}

class _HorizontalList extends StatelessWidget {
  _HorizontalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: groupDataList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> groupData = groupDataList[index];

          return GestureDetector(
            onTap: () {
              print('클릭됨');
            },
            child: PartnerCard(
              imagePath: groupData['imagePath'],
              name: groupData['title'],
              markets: groupData['category'],
            ),
          );
        },
      ),
    );
  }
}
