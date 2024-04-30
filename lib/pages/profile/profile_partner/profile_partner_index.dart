import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePartnerIndex extends StatefulWidget {
  const ProfilePartnerIndex({super.key});

  @override
  State<ProfilePartnerIndex> createState() => _ProfilePartnerIndexState();
}

class _ProfilePartnerIndexState extends State<ProfilePartnerIndex> {
  List<Partner>? partnerList = [];
  bool _isLoading = true;
  User? myUser; // 저장 된 내 정보
  int? userId;

  var args;

  @override
  void initState() {
    super.initState();
    _initMyUser();
    _initData();
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) => myUser = value);
  }

  void _initData() {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            userId = args['userId'];
          });
        }

        if (userId != null) {
          var response = await getPartners(queryMap: { 'user_id': userId });
          if (response.status == 'success' && mounted) {
            Iterable iterable = response.data;
            List<Partner>? partnerListData = List<Partner>.from(
                iterable.map((e) => Partner.fromJSON(e)));
            setState(() {
              if (partnerListData != null) {
                partnerList = partnerListData;
              }
              _isLoading = false;
            });
          }
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || partnerList == null) {
      return Loading();
    }
    return DefaultLogoLayout(
        titleName: '파트너',
        isNotInnerPadding: 'true',
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _isLoading = true;
            });
            _initData();
          },
          child: Column(
            children: [
              myUser != null && partnerList != null && partnerList!.isNotEmpty ? Expanded(
                  child: Container(
                    padding: EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFf5f6f8),
                    ),
                    child: ListView.builder(
                      itemCount: partnerList!.length,
                      itemBuilder: (context, index) {
                        Partner item = partnerList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/profile/partner/info',
                                arguments: {
                                  'userId': item.has_user!.id
                                }).then((value) {
                              _initData();
                            });
                          },
                          child:
                          ListPartnerCard(
                            item: item.has_user,
                            onDeletePressed: () {},
                            onApprovePressed: () {},
                            hasButton: false,),
                        );
                      },
                    ),
                  )
              ) : NoItems(),
            ],
          ),
        ));
  }
}

