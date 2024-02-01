import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_line_business_card.dart';
import 'package:Deal_Connect/components/post_list_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/post_data.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:Deal_Connect/pages/profile/company_add/company_add_index.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_button.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_condition.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_info.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'partner_attend/partner_attend_index.dart';

// 프로필
class OtherProfileIndex extends StatefulWidget {
  const OtherProfileIndex({Key? key}) : super(key: key);

  @override
  State<OtherProfileIndex> createState() => _OtherProfileIndexState();
}

class _OtherProfileIndexState extends State<OtherProfileIndex> {

  @override
  void initState() {
    super.initState();
    // tab컨트롤러 초기화
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      titleName: "프로필 상세",
      isNotInnerPadding: "true",
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 240.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ProfileUserInfo(
                        userName: '홍길동',
                        userInfo: '다양한 소프트웨어 개발을 통해 서비스',
                        imgPath: 'main_sample01',
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      ProfileUserCondition(
                        partner: 123,
                        company: 3,
                        history: '10k',
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          _reanderButton(btnName: '프로필 공유하기', onPressed: (){},),
                          SizedBox(
                            width: 10.0,
                          ),
                          _reanderButton(btnName: '파트너 신청', onPressed: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context) => PartnerAttendIndex()));
                          },),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Color(0xFFF5F6FA),
                thickness: 10.0,
              ),
            ),
          ];
        },
        body: Container(
          color: Color(0xFFf5f6f8),
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: SizedBox(
            child: companyDataList.isNotEmpty
                ? CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        Map<String, dynamic> verticalData =
                        companyDataList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => BusinessDetailInfo()
                              ),
                            );
                          },
                          child: ListLineBusinessCard(
                            bgImagePath: verticalData['bgImagePath'],
                            companyName: verticalData['companyName'],
                            tagList: verticalData['tagList'],
                          ),
                        );
                      }, childCount: companyDataList.length),
                ),
              ],
            )
                : NotUserRegistered(isTabType: true),
          ),
        ),
      ),
    );
  }
}


class _reanderButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const _reanderButton({
    required this.btnName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Color(0xFFF5F6FA),
          foregroundColor: Color(0xFFF5F6FA),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
