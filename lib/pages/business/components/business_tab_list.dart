import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:flutter/material.dart';

class BusinessTabList extends StatefulWidget {
  const BusinessTabList({super.key});

  @override
  State<BusinessTabList> createState() => _BusinessTabListState();
}

class _BusinessTabListState extends State<BusinessTabList> {
  @override
  void initState() {
    super.initState();
    print('22초기화');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: companyDataList.isNotEmpty
          ? GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 한 줄에 2개의 아이템
          crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
          mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
          childAspectRatio: 1 / 1.25,
        ),
        itemCount: companyDataList.length, // 아이템 개수
        itemBuilder: (context, index) {
          Map<String, dynamic> companyData = companyDataList[index];
          return GestureDetector(
            onTap: () {
              print('클릭했다~ ');
              Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessDetailInfo()));
            },
            child: Container(
              child: ListBusinessCard(
                bgImagePath: companyData['bgImagePath'],
                avaterImagePath: companyData['avaterImagePath'],
                companyName: companyData['companyName'],
                tagList : companyData['tagList'],
              ),
            ),
          );
        },
      ) : const Text('등록된 데이터가 없습니다'),
    );
  }
}
