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

/*
import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_button.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_condition.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_info.dart';
import 'package:Deal_Connect/pages/profile/components/profile_user_tab_bar.dart';
import 'package:flutter/material.dart';

// 프로필
class ProfileIndex extends StatefulWidget {
  const ProfileIndex({Key? key}) : super(key: key);

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultBasicLayout(
        child: DefaultTabController(
      length: 2,
      child: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
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

            ]),
          ),

          SliverAppBar(
            floating: true,
            pinned: true,
            bottom: TabBar(
              tabs: [
                Tab(text: '탭 1'),
                Tab(text: '탭 2'),
              ],
            ),
          ),

          SliverFillRemaining(
            child: TabBarView(
              children: [
                // 첫 번째 탭에 대한 내용
                Container(
                  height: 200,
                  color: Colors.red,
                ),
                // 두 번째 탭에 대한 내용
                Text('두 번째 탭 내용'),
              ],
            ),
          )

        ],
      ),
    ));
  }
}
 */

/*
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
 */
