import 'package:Deal_Connect/components/image_builder.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupBoardInfo extends StatefulWidget {
  final int id;

  const GroupBoardInfo({required this.id, Key? key}) : super(key: key);

  @override
  State<GroupBoardInfo> createState() => _GroupBoardInfoState();
}

class _GroupBoardInfoState extends State<GroupBoardInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
      titleName: '서초구 고기집 사장모임',
      nextTitle: '수정',
      prevTitle: '삭제',
      isCancel: true,
      isProcessable: true,
      bottomBar: true,
      nextOnPressed: (){Navigator.pop(context);},
      prevOnPressed: (){},
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("연초 모임을 어디서 갖는게 좋을까요??", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),  ),
                SizedBox(height: 15,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/sample/main_sample05.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '우스헤라',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                            Text(
                              '2024-01-01 16:30:25',
                              style: TextStyle(color: HexColor("#aaaaaa"), fontSize: 11.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_red_eye_sharp, color: Colors.grey, size: 18.0,),
                        SizedBox(width: 3.0),
                        Text('10', style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Column(
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/images/sample/main_sample01.jpg'),
                  ),
                ),
                SizedBox(height: 10,),
                Text('이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.이번 모임은 고깃집 어떠세요!? 홍길동님이 운영하시는 집이 아주 괜찮습니다.')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
