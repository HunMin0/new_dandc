import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_service_card.dart';
import 'package:Deal_Connect/db/service_data.dart';
import 'package:Deal_Connect/pages/business/business_history/business_history_index.dart';
import 'package:Deal_Connect/pages/business/business_service/business_service_create.dart';
import 'package:Deal_Connect/pages/business/business_service/business_service_info.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:Deal_Connect/pages/history/history_index.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BusinessDetailInfo extends StatefulWidget {
  const BusinessDetailInfo({super.key});

  @override
  State<BusinessDetailInfo> createState() => _BusinessDetailInfoState();
}

class _BusinessDetailInfoState extends State<BusinessDetailInfo> {
  final List<String> tagList = ['#테스트', '#테스트2', '#테스트3'];

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '청년 한다발 서초점',
        isNotInnerPadding: 'true',
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  expandedHeight: 615.0,
                  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.8 / 1,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/sample/main_sample01.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "청년한다발 서초점",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      splashRadius: 25.0,
                                      icon: Icon(
                                        Icons.share,
                                        size: 20,
                                      ),
                                      color: HexColor("#6d6d6d"),
                                    ),
                                  ],
                                ),
                                Text(
                                  "이쁜 꽃을 파는 집입니다.",
                                  style: TextStyle(
                                      fontSize: 16, color: HexColor("#5D5D5D")),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(builder: (context) => OtherProfileIndex()
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15.0,
                                            backgroundImage: AssetImage(
                                                'assets/images/sample/main_sample_avater2.jpg'),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "한동엽 대표",
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      color: HexColor("#222222"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 25,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/icons/partner_icon.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "파트너 132명",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                _buildTags(tagList),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    _reanderButton(
                                      btnName: '전화',
                                      onPressed: () {},
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    _reanderButton(
                                      btnName: '거래내역',
                                      onPressed: () {
                                        Navigator.push(context, CupertinoPageRoute(builder: (context) => BusinessHistoryIndex()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 10,
                            color: HexColor("#f5f6fa"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10.0),
                            child: Column(
                              children: [
                                _iconText(Icons.place, "서울특별시 서초구 반포동 19-1"),
                                SizedBox(
                                  height: 10,
                                ),
                                _iconText(Icons.desktop_windows_rounded,
                                    "https://www.test.com"),
                                SizedBox(
                                  height: 10,
                                ),
                                _iconText(
                                    Icons.watch_later, "평일 09:00 ~ 20:00"),
                                SizedBox(
                                  height: 10,
                                ),
                                _iconText(Icons.phone, "010-1234-6565"),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 10,
                            color: HexColor("#f5f6fa"),
                          ),
                        ],
                      ))),
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      "주요 서비스",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => BusinessServiceCreate()));
                      },
                      child: Text(
                        '추가하기',
                        style: TextStyle(
                          color: Color(0xff333333),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFf5f6fa),
                        foregroundColor: Color(0xFFf5f6fa),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 10,
                color: HexColor("#f5f6fa"),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: serviceDataList.isNotEmpty
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 한 줄에 2개의 아이템
                            crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                            mainAxisSpacing: 5.0, // 아이템 간의 세로 간격
                            childAspectRatio: 1.1 / 1,
                          ),
                          itemCount: serviceDataList.length, // 아이템 개수
                          itemBuilder: (context, index) {
                            Map<String, dynamic> serviceData =
                                serviceDataList[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => BusinessServiceInfo()));
                              },
                              child: Container(
                                child: ListServiceCard(),
                              ),
                            );
                          },
                        )
                      : const Text('등록된 데이터가 없습니다'),
                ),
              ),
            ],
          ),
        ));
  }

// 반복태그
  Widget _buildTags(List<String> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(tagList[i]),
        ));
      } else {
        break;
      }
    }
    return Row(children: tagWidgets);
  }

// 태그 공통
  Container _cardTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Row _iconText(IconData prefixIcon, String text) {
    return Row(
      children: [
        Icon(
          prefixIcon,
          color: HexColor("#ABABAB"),
          size: 18,
        ),
        SizedBox(
          width: 10,
        ),
        Text(text)
      ],
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
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Color(0xFFF5F6FA),
          foregroundColor: Color(0xFFF5F6FA),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
