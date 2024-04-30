import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_index.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/tabBarButton.dart';
import 'package:flutter/material.dart';

class NotUserRegistered extends StatelessWidget {
  final bool isTabType;

  const NotUserRegistered({
    required this.isTabType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyleTitle = TextStyle(
      color: Color(0xFF75A8E4),
      fontSize: 12.0,
      fontWeight: FontWeight.w700,
    );
    const textStyleMainTitle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
    );
    const textStyleSubTitle = TextStyle(
      fontSize: 13.0,
      color: Color(0xFF666666),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: const BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14.0,
          left: 14.0,
          right: 14.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: isTabType
                  ? Column(
                      children: [
                        Text(
                          '연결의 첫 시작',
                          style: SettingStyle.SUB_GREY_TEXT.copyWith(
                            color: Color(0xFF75A8E4)
                          ),
                        ),
                        const Text(
                          '내 업체 등록하기',
                          style: SettingStyle.TITLE_STYLE,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          '업체를 등록하고 다른 사장님들과\n파트너를 맺어보세요!',
                          textAlign: TextAlign.center,
                          style: SettingStyle.SUB_GREY_TEXT,
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        Image.asset(
                          'assets/images/icons/store_img.png',
                          height: 100.0,
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TabBarButton(
                                  btnTitle: '내 업체 등록하기', onPressed: () {
                                    Navigator.pushNamed(context, '/profile/company/create');
                              }),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const Text(
                          '소통의 첫 시작',
                          style: textStyleTitle,
                        ),
                        const Text(
                          '등록된 글이 없습니다',
                          style: textStyleMainTitle,
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        const Text(
                          '파트너를 맺고 다른 사장님들과\n이야기를 나눠보세요!',
                          textAlign: TextAlign.center,
                          style: textStyleSubTitle,
                        ),
                        Image.asset(
                          'assets/images/icons/partner_post.png',
                          height: 100.0,
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}