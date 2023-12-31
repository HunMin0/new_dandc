import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/pages/group/register/register_index.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupIndex extends StatelessWidget {
  const GroupIndex({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.5 - 25;

    final textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold
    );

    return DefaultLogoLayout(
      titleName: '그룹 찾아보기',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '그룹에 가입해서\n네트워킹에 참여하세요.',
            style: textStyle,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const GroupRegisterIndex(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child : Container(
                  height: screenWidth, // 버튼의 세로 크기
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: HexColor('F5F6FA'),
                    borderRadius: BorderRadius.circular(10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/search.png', // 이미지의 경로
                        height: 24.0, // 이미지의 높이
                        width: 24.0, // 이미지의 너비
                      ),
                      const SizedBox(height: 8.0), // 이미지와 버튼 사이의 간격 조절
                      const Text(
                        '그룹 찾기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),

                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => const GroupRegisterIndex(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child : Container(
                  height: screenWidth, // 버튼의 세로 크기
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: HexColor('F5F6FA'),
                    borderRadius: BorderRadius.circular(10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/search.png', // 이미지의 경로
                        height: 24.0, // 이미지의 높이
                        width: 24.0, // 이미지의 너비
                      ),
                      const SizedBox(height: 8.0), // 이미지와 버튼 사이의 간격 조절
                      const Text(
                        '그룹 만들기',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
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
