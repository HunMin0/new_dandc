import 'package:Deal_Connect/components/layout/default_layout.dart';
import 'package:flutter/material.dart';

// 프로필
class ProfileIndex extends StatelessWidget {
  const ProfileIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 34.0,
                backgroundImage:
                    AssetImage('assets/images/sample/main_sample01.jpg'),
              ),
              SizedBox(
                width: 18.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '홍길동',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text('다양한 소프트웨어 개발을 통해 서비스'),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildUserTab(
                  '123',
                  '파트너',
                ),
                _buildTabLine(),
                _buildUserTab(
                  '3',
                  '업체',
                ),
                _buildTabLine(),
                _buildUserTab(
                  '10k',
                  '거래내역',
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('프로필 편집', style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF5F6FA),
                    foregroundColor: Color(0xFFF5F6FA),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildUserTab(String tabData, String tabTitle) {
  final tabDataStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );
  final tabTitleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );

  return Column(
    children: [
      Text(
        tabData,
        style: tabDataStyle,
      ),
      Text(
        tabTitle,
        style: tabTitleStyle,
      ),
    ],
  );
}

Widget _buildTabLine() {
  return Container(
    width: 1.0,
    height: double.infinity,
    color: const Color(0xFFD9D9D9),
  );
}
