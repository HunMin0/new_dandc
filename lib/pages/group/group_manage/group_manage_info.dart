import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupManageInfo extends StatefulWidget {
  const GroupManageInfo({super.key});

  @override
  State<GroupManageInfo> createState() => _GroupManageInfoState();
}

class _GroupManageInfoState extends State<GroupManageInfo> {
  Group? groupData;
  bool _isLoading = true;
  int? groupId;
  String? groupName;

  var args;

  @override
  void initState() {
    super.initState();
    _initData();
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
            groupId = args['groupId'];
          });
        }

        if (groupId != null) {
          await getGroup(groupId!).then((response) {
            if (response.status == 'success') {
              Group resultData = Group.fromJSON(response.data);
              setState(() {
                groupData = resultData;
              });
            } else {
              Fluttertoast.showToast(
                  msg: '그룹 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    ImageProvider groupMainImage;
    if (groupData != null && groupData!.has_group_image != null) {
      groupMainImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(groupData!.has_group_image!),
      );
    } else {
      groupMainImage = AssetImage('assets/images/no-image.png');
    }


    if (_isLoading || groupData == null) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultLogoLayout(
        titleName: '서초구 고깃집 사장모임',
        child: Container(
          child: Text('test'),
        )
    );
  }
}
