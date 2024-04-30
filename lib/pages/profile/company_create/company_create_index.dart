import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/categories.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/category.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompanyCreateIndex extends StatefulWidget {
  const CompanyCreateIndex({super.key});

  @override
  State<CompanyCreateIndex> createState() => _CompanyCreateIndexState();
}

class _CompanyCreateIndexState extends State<CompanyCreateIndex> {
  int selectedIdx = -1;
  bool isProcessable = false;
  String selectedSectorName = "";
  String? storeName;
  List<Category>? categories;
  UserBusiness? userBusiness;
  int? userBusinessId;
  bool _isLoading = true;

  var args;

  @override
  void initState() {
    _initGetCategories();
    _initData();
    super.initState();
  }

  void _initData() async {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            userBusinessId = args['userBusinessId'];
            storeName = args['storeName'];
          });
        }
        if (userBusinessId != null) {
          await getUserBusiness(userBusinessId!).then((response) {
            if (response.status == 'success') {
              UserBusiness resultData = UserBusiness.fromJSON(response.data);
              if (resultData != null) {
                setState(() {
                  userBusiness = resultData;
                  if (userBusiness != null && userBusiness!.user_business_category_id != null) {
                    selectedIdx = userBusiness!.user_business_category_id;
                    selectedSectorName = userBusiness!.has_category!.name;
                    isProcessable = true;
                  }
                });
              }
            } else {
              Fluttertoast.showToast(
                  msg: '업체 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  _initGetCategories() {
    getCategories().then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Category> list =
        List<Category>.from(iterable.map((e) => Category.fromJSON(e)));

        setState(() {
          categories = list;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    return DefaultNextLayout(
      titleName: storeName ?? '업체등록',
      isProcessable: isProcessable,
      bottomBar: true,
      prevTitle: '취소',
      nextTitle: '다음',
      prevOnPressed: () {
        Navigator.of(context).pop();
      },
      nextOnPressed: () {
        Navigator.pushNamed(context, '/profile/company/create/photo',
            arguments: {'userBusinessCategoryId': selectedIdx, 'userBusiness': userBusiness});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectedSectorName.isEmpty
              ? Text(
                  '업종을 선택해주세요',
                  style: textStyle,
                )
              : RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '선택하신 업종은 ',
                      style: textStyle.copyWith(),
                    ),
                    TextSpan(
                      text: selectedSectorName,
                      style: textStyle.copyWith(
                        color: Color(0xFF75A8E4),
                      ),
                    ),
                    TextSpan(
                      text: '업 입니다.',
                      style: textStyle,
                    ),
                  ]),
                ),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
    );
  }

  GridView _buildGridView() {
    return GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        children: categories != null
            ? categories!.map((item) {
                Widget thumbnailImage = Image.asset(
                  'assets/images/no-image.png',
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                );

                if (item.has_category_icon_image != null) {
                  thumbnailImage = CachedNetworkImage(
                    imageUrl:
                        Utils.getImageFilePath(item.has_category_icon_image!),
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selectedIdx == item.id) {
                        // 이미 선택된 아이템을 다시 탭하면 선택 해제
                        selectedIdx = -1;
                        selectedSectorName = "";
                        isProcessable = false;
                      } else {
                        // 새로운 아이템 선택
                        selectedIdx = item.id;
                        selectedSectorName = item.name;
                        isProcessable = true;
                      }
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 6.0),
                        width: 70.0,
                        height: 70.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: thumbnailImage,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          item.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            height: 1.1,
                            fontSize: 12.0,
                              color: selectedIdx == item.id
                                  ? Color(0xFF75A8E4)
                                  : Colors.black),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList()
            : []);
  }
}
