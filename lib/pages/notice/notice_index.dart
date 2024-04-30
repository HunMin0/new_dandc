import 'package:Deal_Connect/api/push_message.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_notice_card.dart';
import 'package:Deal_Connect/model/push_message.dart';
import 'package:flutter/cupertino.dart';


class NoticeIndex extends StatefulWidget {
  const NoticeIndex({super.key});

  @override
  State<NoticeIndex> createState() => _NoticeIndexState();
}

class _NoticeIndexState extends State<NoticeIndex> {
  List<PushMessage> pushMessageList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getPushMessages()
        .then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<PushMessage>? resData =
        List<PushMessage>.from(iterable.map((e) => PushMessage.fromJSON(e)));

        setState(() {
          this.pushMessageList = resData;
          _isLoading = false;
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '알림',
        isNotInnerPadding: 'true',
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        _initData();
                      },
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            PushMessage item = pushMessageList[index];
                
                            return GestureDetector(
                              onTap: () {
                                if (item.route != null) {
                                  Navigator.pushNamed(
                                    context, item.route!, arguments: { item.key : int.parse(item.keyValue!) });
                                }
                              },
                              child: ListNoticeCard(item: item),
                            );
                          }, childCount: pushMessageList.length),
                    ),
                  ],
                ),
              )
              // Expanded(
              //   child: ListView.builder(
              //       itemCount: noticeData.length,
              //       itemBuilder: (context, index) {
              //         final data = noticeData[index];
              //         return GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               CupertinoPageRoute(builder: (context) => OtherProfileIndex()
              //               ),
              //             );
              //           },
              //           child: ListNoticeCard(
              //             title: data['title'],
              //             created_at: data['created_at'],
              //             profile_img: data['profile_img'],
              //           ),
              //         );
              //       }),
              // ),
            ],
          ),
        ),
    );
  }
}
