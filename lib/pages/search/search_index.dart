import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/search_sample_date.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/pages/search/components/partner_card.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchIndex extends StatefulWidget {
  const SearchIndex({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchIndex> createState() => _SearchIndexState();
}

class _SearchIndexState extends State<SearchIndex> {
  String searchKeyword = '';
  List<String>? searchKeywords = [];
  List<String>? searchPartners = [];
  bool _isLoading = true;
  List<Partner>? partnerList = [];

  @override
  void initState() {
    _initGetSearchKeyword();
    _initGetSearchPartner();
    super.initState();
  }

  void _initGetSearchKeyword() {
    SharedPrefUtils.getSearchKeyword().then((value) {
      setState(() {
        searchKeywords = value;
      });
    });
  }

  void _initGetSearchPartner() {
    SharedPrefUtils.getSearchPartner().then((value) {
      setState(() {
        searchPartners = value;
      });
    });
  }

  void _searchPartner() async {
    String trimStr = searchKeyword.trimLeft().trimRight();

    if (trimStr.isNotEmpty) {
      getPartners(queryMap: { 'keyword': searchKeyword }).then((response) {
        if (response.status == 'success') {
          Iterable iterable = response.data;
          List<Partner>? partnerListData = List<Partner>.from(
              iterable.map((e) => Partner.fromJSON(e)));
          setState(() {
            partnerList = partnerListData;
            _isLoading = false;
          });
        }
      });

      SharedPrefUtils.addSearchKeyword(trimStr).then((value) {
        SharedPrefUtils.getSearchKeyword().then((value) {
          setState(() {
            searchKeywords = value;
          });
        });
      });
    } else {
      Fluttertoast.showToast(msg: '검색어를 입력해주세요.');
      setState(() {
        searchKeyword = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultSearchLayout(
      isNotInnerPadding: 'true',
      onSubmit: (keyword) {
        setState(() {
          searchKeyword = keyword;
        });
        _searchPartner();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: (partnerList != null && partnerList!.isNotEmpty) ?
            Column(
              children: [
                Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: SettingStyle.GREY_COLOR,
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
                ),
              ],
            )
            : (searchKeyword == '') ? CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "최근 검색 파트너",
                          style: SettingStyle.TITLE_STYLE,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 140.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: searchSampleDataList.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> sampleData =
                                  searchSampleDataList[index];

                              return GestureDetector(
                                onTap: () {
                                  print('클릭됨');
                                },
                                child: PartnerCard(
                                  imagePath: sampleData['imagePath'],
                                  name: sampleData['name'],
                                  markets: sampleData['markets'],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(13.0),
                child: Row(
                  children: [
                    const Text(
                      "최근 검색어",
                      style: SettingStyle.TITLE_STYLE,
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        SharedPrefUtils.clearSearchKeyword().then((value) {
                          _initGetSearchKeyword();
                        });
                      },
                      child: Text('최근 검색어 삭제',
                          style: SettingStyle.SMALL_TEXT_STYLE
                              .copyWith(color: SettingStyle.MAIN_COLOR)),
                    )
                  ],
                ),
              ),
            ),
            searchKeywords != null && searchKeywords!.isNotEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        String item = searchKeywords![index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              searchKeyword = item;
                            });
                            _searchPartner();
                          },
                          child: Row(
                            children: <Widget>[
                              const Icon(CupertinoIcons.search,
                                  color: SettingStyle.MAIN_COLOR),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    SharedPrefUtils.removeSearchKeyword(item)
                                        .then((value) {
                                      _initGetSearchKeyword();
                                    });
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.trash_fill,
                                    size: 20,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        );
                      },
                      childCount: searchKeywords?.length ?? 0,
                    )),
                  )
                : const SliverToBoxAdapter(
                    child: NoItems(),
                  )
          ],
        ) : const NoItems(),
      ),
    );
  }
}
