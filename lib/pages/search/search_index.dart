import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/pages/search/components/partner_card.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchIndex extends StatefulWidget {
  const SearchIndex({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchIndex> createState() => _SearchIndexState();
}

class _SearchIndexState extends State<SearchIndex> {
  List<String>? searchKeywords = [];
  List<String>? searchPartners;
  bool _isLoading = true;
  List<Partner>? searchPartnerList = [];
  List<Partner>? partnerList = [];
  TextEditingController? textController = TextEditingController();

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
        _initGetSearchPartners(value);
      });
    });
  }


  void _initGetSearchPartners(value) {
    if (value != null && value.isNotEmpty) {
      getPartners(queryMap: {'partners': value.toString()}).then((response) {
        if (response.status == 'success') {
          Iterable iterable = response.data;
          List<Partner>? partnerListData =
          List<Partner>.from(iterable.map((e) => Partner.fromJSON(e)));
          setState(() {
            searchPartnerList = partnerListData;
          });
        }
      });
    }
  }


  void _clearSearchPartner() {
    setState(() {
      searchPartnerList = null;
      searchPartners = null;
    });
  }


  void _searchPartner() async {
    String trimStr = textController!.text.trimLeft().trimRight();

    if (trimStr.isNotEmpty) {
      getPartners(queryMap: {'keyword': trimStr}).then((response) {
        if (response.status == 'success') {
          Iterable iterable = response.data;
          List<Partner>? partnerListData =
              List<Partner>.from(iterable.map((e) => Partner.fromJSON(e)));
          setState(() {
            partnerList = partnerListData;
            _isLoading = false;
          });

          List<String> partnerIds =
              partnerListData.map((partner) => partner.id.toString()).toList();
          partnerIds.toSet().toList().forEach((id) {
            SharedPrefUtils.addSearchPartner(id);
          });
        }
      });

      SharedPrefUtils.getSearchPartner().then((value) {
        setState(() {
          searchPartners = value;
        });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: SettingColors.primaryMeterialColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    onSubmitted: (value) {
                      _searchPartner();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor("#F5F6FA"),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // 테두리를 둥글게 설정
                        borderSide: BorderSide.none, // 바텀 border 없애기
                      ),
                      hintText: '검색 키워드를 입력해주세요',
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: HexColor("#666666")),
                    ))
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              _initGetSearchPartner();
            },
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: (partnerList != null && partnerList!.isNotEmpty)
                  ? Column(
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
                                      arguments: {'userId': item.has_user!.id});
                                },
                                child: ListPartnerCard(
                                  item: item.has_user,
                                  onDeletePressed: () {},
                                  onApprovePressed: () {},
                                  hasButton: false,
                                ),
                              );
                            },
                          ),
                        )),
                      ],
                    )
                  : (textController!.text == '')
                      ? CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "최근 검색 파트너",
                                              style: SettingStyle.TITLE_STYLE,
                                            ),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                SharedPrefUtils.clearSearchPartner()
                                                    .then((value) {
                                                  _clearSearchPartner();
                                                });
                                              },
                                              child: Text('최근 검색 파트너 삭제',
                                                  style: SettingStyle.SMALL_TEXT_STYLE
                                                      .copyWith(
                                                      color: SettingStyle.MAIN_COLOR)),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        searchPartnerList != null &&
                                                searchPartnerList!.isNotEmpty
                                            ? SizedBox(
                                                height: 145.0,
                                                child: ListView.builder(
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount:
                                                  searchPartnerList!.length,
                                                  itemBuilder: (context, index) {
                                                    Partner
                                                        item =
                                                    searchPartnerList![index];

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                            context, '/profile/partner/info',
                                                            arguments: {'userId': item.has_user!.id});
                                                      },
                                                      child: PartnerCard(item: item.has_user!),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.all(13.0),
                                                width: double.infinity,
                                                child: const Text(
                                                  '검색된 파트너가 없습니다.',
                                                  style: SettingStyle.NORMAL_TEXT_STYLE,
                                                  textAlign: TextAlign.center,
                                                )),
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
                                        SharedPrefUtils.clearSearchKeyword()
                                            .then((value) {
                                          _initGetSearchKeyword();
                                        });
                                      },
                                      child: Text('최근 검색어 삭제',
                                          style: SettingStyle.SMALL_TEXT_STYLE
                                              .copyWith(
                                                  color: SettingStyle.MAIN_COLOR)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            searchKeywords != null && searchKeywords!.isNotEmpty
                                ? SliverPadding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 13),
                                    sliver: SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        String item = searchKeywords![index];
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              textController!.text = item;
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
                                                    SharedPrefUtils
                                                            .removeSearchKeyword(
                                                                item)
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
                                    child: Text('등록된 검색어가 없습니다.',
                                        textAlign: TextAlign.center,
                                        style: SettingStyle.NORMAL_TEXT_STYLE),
                                  )
                          ],
                        )
                      : const NoItems(),
            ),
          ),
        ),
      ),
    );
  }
}
