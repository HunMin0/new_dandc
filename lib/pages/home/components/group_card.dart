import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatefulWidget {
  final Group item;

  GroupCard({Key? key, required this.item})
    : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    // 즐겨찾기 버튼을 눌럿을때 상태변화
    isFavorite = !isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/group/info',
            arguments: {'groupId': widget.item.id});
      },
      child: Row(
        children: [
          Stack(
            children: [
              _CardBackground(),
              _CardData(),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }

  Container _CardData() {
    return Container(
      width: 180.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black],
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _CardDataText(),
    );
  }

  Padding _CardDataText() {
    final textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 15.0,
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.item.name,
            style: textStyle,
          ),
          SizedBox(
            height: 6.0,
          ),
          _ColumnTextLine(textStyle),
        ],
      ),
    );
  }

  Row _ColumnTextLine(TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 15.0,
              ),
            ),
            Text(
              widget.item.users_count.toString() + '명',
              style: textStyle.copyWith(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container _CardBackground() {
    ImageProvider? backgroundImage;

    if (widget.item.has_group_image != null && widget.item.has_group_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(widget.item.has_group_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
    }

    return Container(
      width: 180.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
