import 'package:Deal_Connect/components/list_card.dart';
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
          itemCount: companyDataList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> verticalData = companyDataList[index];

            return GestureDetector(
              onTap: () {
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
    );
  }
}