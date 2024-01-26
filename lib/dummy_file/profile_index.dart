import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_button.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_condition.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_info.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_tab_bar.dart';
import 'package:flutter/material.dart';

// 프로필
class ProfileIndex extends StatelessWidget {
  const ProfileIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBasicLayout(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                              ProfileUserButton(),
                              SizedBox(
                                height: 24.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])),
            ];
          },
          body: ProfileUserTabBar(),
        ));
  }
}

