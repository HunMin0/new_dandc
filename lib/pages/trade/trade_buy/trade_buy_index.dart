import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 사업장찾기
class TradeBuyIndex extends StatefulWidget {
  const TradeBuyIndex({
    Key? key,
  }) : super(key: key);

  @override
  State<TradeBuyIndex> createState() => _TradeBuyIndexState();
}

class _TradeBuyIndexState extends State<TradeBuyIndex> {
  String? searchKeyword = '';
  List<UserBusiness>? userBusinessList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getUserBusinesses(
        queryMap: {'do_not_include_mine': true, 'partner_has_store': true, 'keyword': searchKeyword})
        .then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<UserBusiness>? userBusinessList = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          if (userBusinessList != null) {
            this.userBusinessList = userBusinessList;
          }
          this._isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }


    return DefaultSearchLayout(
        isNotInnerPadding: 'true',
        onSubmit: (keyword) {
          setState(() {
            searchKeyword = keyword;
            _initData();
          });
        },
        child: Container(
          color: Color(0xFFf5f6f8),
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: userBusinessList != null && userBusinessList!.isNotEmpty
              ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 한 줄에 2개의 아이템
              crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
              mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
              childAspectRatio: 1 / 1.4,
            ),
            itemCount: userBusinessList!.length, // 아이템 개수
            itemBuilder: (context, index) {
              UserBusiness item = userBusinessList![index];
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/trade/buy/create',
                        arguments: {"userBusinessId": item.id});
                  },
                  child: ListBusinessCard(item: item)
              );
            },
          )
              : NoItems(),
        ),
    );
  }
}
