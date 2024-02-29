import 'package:Deal_Connect/api/board.dart';
import 'package:Deal_Connect/components/image_builder.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/board_file.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupBoardInfo extends StatefulWidget {
  const GroupBoardInfo({Key? key}) : super(key: key);

  @override
  State<GroupBoardInfo> createState() => _GroupBoardInfoState();
}

class _GroupBoardInfoState extends State<GroupBoardInfo> {
  int? boardWriteId;
  String? groupName;
  BoardWrite? boardWriteData;
  bool _isLoading = true;
  bool _isMine = false;
  User? myUser;

  var args;

  @override
  void initState() {
    super.initState();
    _initData();
    _initMyUser();
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) => myUser = value);
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
            boardWriteId = args['boardWriteId'];
            groupName = args['groupName'];
          });
        }

        if (boardWriteId != null) {
          await getBoardWrite(boardWriteId!).then((response) {
            if (response.status == 'success') {
              BoardWrite resultData = BoardWrite.fromJSON(response.data);
              setState(() {
                boardWriteData = resultData;
                if (boardWriteData != null && boardWriteData!.has_writer != null && myUser != null) {
                  if (boardWriteData!.has_writer!.id == myUser!.id) {
                    setState(() {
                      _isMine = true;
                    });
                  }
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: '게시물 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 462');
            }
          });

          _updateHits();
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _updateHits() async {
    await updateBoardWriteHits(boardWriteId!).then((response) {
      if (response.status == 'success') {
        BoardWrite resultData = BoardWrite.fromJSON(response.data);

      } else {
        Fluttertoast.showToast(
            msg: '조회수 업데이트 중 오류가 발생했습니다.\n오류코드: 463');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? avatarImage;

    if (
    boardWriteData != null &&
        boardWriteData!.has_writer != null &&
        boardWriteData!.has_writer!.has_user_profile != null &&
        boardWriteData!.has_writer!.has_user_profile!.has_profile_image !=
            null) {
      avatarImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            boardWriteData!.has_writer!.has_user_profile!.has_profile_image!),
      );
    } else {
      avatarImage = AssetImage('assets/images/no-image.png');
    }

    List<String> imgUrls = [];
    if (boardWriteData != null) {
      if (boardWriteData!.has_files != null && boardWriteData!.has_files!.isNotEmpty) {
        imgUrls.addAll(boardWriteData!.has_files!.map((e) => Utils.getImageFilePath(e.has_file!)));
      }
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultNextLayout(
      titleName: groupName,
      nextTitle: '수정',
      prevTitle: '삭제',
      isCancel: _isMine,
      isNext: _isMine,
      isProcessable: true,
      bottomBar: true,
      nextOnPressed: () {
        Navigator.pushNamed(
            context, '/group/board/edit',
            arguments: {
              'boardWriteId': boardWriteData!.id,
              'groupName': groupName
            }).then((value) {
          _initData();
        });
      },
      prevOnPressed: () {},
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  boardWriteData != null ? boardWriteData!.title : '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: avatarImage,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (boardWriteData != null && boardWriteData!.has_writer != null)
                            Text(
                              boardWriteData!.has_writer!.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                            Text(
                              boardWriteData != null ? boardWriteData!.created_at : '',
                              style: TextStyle(
                                  color: HexColor("#aaaaaa"), fontSize: 11.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_sharp,
                          color: Colors.grey,
                          size: 18.0,
                        ),
                        SizedBox(width: 3.0),
                        Text(boardWriteData != null ? boardWriteData!.hits.toString() : '0',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14.0)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                if (imgUrls.isNotEmpty)
                  Container(
                    child: Image(
                      image: CachedNetworkImageProvider(imgUrls[0]),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                Container(
                    width: double.infinity,
                    child: Text(boardWriteData != null ? boardWriteData!.content : '', textAlign: TextAlign.start,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
