import 'package:Deal_Connect/api/board.dart';
import 'package:Deal_Connect/api/board_write_comment.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/image_viewer.dart';
import 'package:Deal_Connect/components/layout/default_comment_layout.dart';
import 'package:Deal_Connect/components/list_comment_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/board_write_comment.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
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
  TextEditingController _commentController = TextEditingController();

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
                if (boardWriteData != null &&
                    boardWriteData!.has_writer != null &&
                    myUser != null) {
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
        Fluttertoast.showToast(msg: '조회수 업데이트 중 오류가 발생했습니다.\n오류코드: 463');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? avatarImage;
    ImageProvider? myAvatarImage;

    if (boardWriteData != null &&
        boardWriteData!.has_writer != null &&
        boardWriteData!.has_writer!.profile != null &&
        boardWriteData!.has_writer!.profile!.has_profile_image !=
            null) {
      avatarImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            boardWriteData!.has_writer!.profile!.has_profile_image!),
      );
    } else {
      avatarImage = const AssetImage('assets/images/no-image.png');
    }

    List<String> imgUrls = [];
    if (boardWriteData != null) {
      if (boardWriteData!.has_files != null &&
          boardWriteData!.has_files!.isNotEmpty) {
        imgUrls.addAll(boardWriteData!.has_files!
            .map((e) => Utils.getImageFilePath(e.has_file!)));
      }
    }

    if (myUser != null &&
        myUser!.profile != null &&
        myUser!.profile!.has_profile_image != null) {
      myAvatarImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(myUser!.profile!.has_profile_image!),
      );
    } else {
      myAvatarImage = const AssetImage('assets/images/no-image.png');
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }
    return DefaultCommentLayout(
      titleName: groupName,
      bottomWidget: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: myAvatarImage,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: SettingStyle.INPUT_STYLE.copyWith(
                    hintText: '댓글 내용을 입력해주세요.',
                    fillColor: HexColor("#f1f1f1"),
                    border: null,
                  ),
                )),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {
                _submitComment();
              },
              child: Text("게시",
                  style: SettingStyle.NORMAL_TEXT_STYLE
                      .copyWith(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
      avatarImageProvider: myAvatarImage,
      rightMoreBtn: _isMine,
      rightMoreAction: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          builder: (BuildContext bc) {
            return Container(
              margin: const EdgeInsets.only(bottom: 40.0),
              child: SafeArea(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        '수정하기',
                        style: SettingStyle.SUB_TITLE_STYLE,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/group/board/edit',
                            arguments: {
                              'boardWriteId': boardWriteData!.id,
                              'groupName': groupName
                            }).then((value) {
                          _initData();
                        });
                      },
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: HexColor('#dddddd'),
                    ),
                    ListTile(
                      title: Text(
                        '삭제하기',
                        style: SettingStyle.SUB_TITLE_STYLE
                            .copyWith(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        // 삭제 로직 처리
                        Navigator.pop(context); // 하단 시트 닫기
                        _deleteItem();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: avatarImage,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (boardWriteData != null &&
                                  boardWriteData!.has_writer != null)
                                Text(
                                  boardWriteData!.has_writer!.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              Text(
                                Utils.formatTimeAgoFromString(boardWriteData!.created_at),
                                style: TextStyle(
                                    color: HexColor("#aaaaaa"), fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.remove_red_eye_sharp,
                            color: Colors.grey,
                            size: 18.0,
                          ),
                          const SizedBox(width: 3.0),
                          Text(
                              boardWriteData != null
                                  ? boardWriteData!.hits.toString()
                                  : '0',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14.0)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                boardWriteData != null ? boardWriteData!.title : '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Text(
                        boardWriteData != null ? boardWriteData!.content : '',
                        textAlign: TextAlign.start,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  if (imgUrls.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageViewer(
                                    imageProvider: CachedNetworkImageProvider(
                                        imgUrls[0]))));
                      },
                      child: Container(
                        color: HexColor("#f1f1f1"),
                        width: double.infinity,
                        height: 250,
                        child: Image(
                          image: CachedNetworkImageProvider(imgUrls[0]),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(
                height: 1,
                thickness: 1,
                color: HexColor("#f1f1f1"),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\u{1F4AC} 댓글"),
                  SizedBox(
                    height: 10,
                  ),
                  if (boardWriteData != null && boardWriteData!.has_comments != null && boardWriteData!.has_comments!.isNotEmpty)
                    Column(
                      children: boardWriteData!.has_comments!.map((BoardWriteComment item) {
                        return ListCommentCard(item: item);
                      }).toList(),
                    )
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  _submitComment() async {
    CustomDialog.showProgressDialog(context);

    storeBoardWriteComment({
      'board_write_id': boardWriteId,
      'comment': _commentController.text
    }).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        setState(() {
          _commentController.text = '';
        });
        FocusScope.of(context).requestFocus(FocusNode());
        _initData();
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _deleteItem() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '정말 삭제하시겠습니까?',
        rightBtnText: '삭제',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _deleteSubmit();
        });
  }

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    deleteBoardWrite(boardWriteData!.id).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: '삭제 완료',
          messageText: '삭제가 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
