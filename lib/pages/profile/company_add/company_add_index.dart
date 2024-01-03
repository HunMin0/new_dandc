import 'package:Deal_Connect/components/const/sector_type.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/pages/profile/company_add/company_add_album.dart';
import 'package:flutter/material.dart';

class CompanyAddIndex extends StatefulWidget {
  const CompanyAddIndex({super.key});

  @override
  State<CompanyAddIndex> createState() => _CompanyAddIndexState();
}

class _CompanyAddIndexState extends State<CompanyAddIndex> {
  int selectedIdx = -1;
  bool isProcessable = false;
  String selectedSectorName = "";

  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
      titleName: '업체등록',
      isProcessable: isProcessable,
      bottomBar: true,
      prevTitle: '취소',
      nextTitle: '다음',
      prevOnPressed: () {
        Navigator.of(context).pop();
      },
      nextOnPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => CompanyAddAlbum(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectedSectorName.isEmpty
              ? Text('업종을 선택해주세요',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ))
              : RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '선택하신 업종은 ',
                      style: TextStyle(color: Colors.black, fontSize: 17.0,
                        fontWeight: FontWeight.w600,),
                    ),
                    TextSpan(
                      text: selectedSectorName,
                      style: TextStyle(color: Color(0xFF75A8E4), fontSize: 17.0,
                        fontWeight: FontWeight.w600,),
                    ),
                    TextSpan(
                      text: '업 입니다.',
                      style: TextStyle(color: Colors.black, fontSize: 17.0,
                        fontWeight: FontWeight.w600,),
                    ),
                  ]),
                ),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              children: List.generate(sectorTypeList.length, (index) {
                String imagePath = sectorTypeList[index]['imagePath']!;
                String sectorName = sectorTypeList[index]['sectorName']!;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedIdx == index) {
                        // 이미 선택된 아이템을 다시 탭하면 선택 해제
                        selectedIdx = -1;
                        selectedSectorName = "";
                        isProcessable = false;
                      } else {
                        // 새로운 아이템 선택
                        selectedIdx = index;
                        selectedSectorName = sectorName;
                        isProcessable = true;
                      }
                    });
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 6.0),
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/sample/$imagePath.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          sectorName,
                          style: TextStyle(
                              color: selectedIdx == index
                                  ? Color(0xFF75A8E4)
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
