import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';

class ProfilePartnerIndex extends StatefulWidget {
  const ProfilePartnerIndex({super.key});

  @override
  State<ProfilePartnerIndex> createState() => _ProfilePartnerIndexState();
}

class _ProfilePartnerIndexState extends State<ProfilePartnerIndex> {
  List<Partner>? partnerList = [];
  bool _isLoading = true;
  User? myUser; // 저장 된 내 정보

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
    getPartners().then((response) {
      if (response.status == 'success') {
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
    });
  }



  @override
  Widget build(BuildContext context) {
    if (_isLoading || partnerList == null) {
      return Loading();
    }
    return DefaultLogoLayout(
        titleName: '내 파트너',
        isNotInnerPadding: 'true',
        child: Column(
          children: [
            myUser != null && partnerList != null && partnerList!.isNotEmpty ? Expanded(
                child: Container(
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
        ));
  }
}

