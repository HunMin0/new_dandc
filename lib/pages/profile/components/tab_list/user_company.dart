import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_line_business_card.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_index.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:flutter/material.dart';

class UserCompany extends StatelessWidget {
  const UserCompany({
  super.key,
  required this.companyDataList,
  });

  final List<Map<String, dynamic>> companyDataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14.0,
          left: 14.0,
          right: 14.0,
        ),
        child: ListView.builder(
          itemCount: companyDataList.length +1,
          itemBuilder: (context, index) {
            
            if (index < companyDataList.length) {
              Map<String, dynamic> verticalData = companyDataList[index];

              return GestureDetector(
                onTap: () {
                  print('클릭했다~');
                },
                child: ListLineBusinessCard(
                  bgImagePath: verticalData['bgImagePath'],
                  companyName: verticalData['companyName'],
                  tagList: verticalData['tagList'],
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TabBarButton(
                          btnTitle: '내 업체 추가하기', onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyCreateIndex()));
                      }),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),

    );
  }
}