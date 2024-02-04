import 'package:Deal_Connect/pages/group/group_board/group_board_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _reanderButton(btnName: '글쓰기', onPressed: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context) => GroupBoardCreate()));
        },),
        SizedBox(
          width: 10.0,
        ),
        SizedBox(width: 10.0,),
        _iconButton(btnIcons: Icons.person_add, onPressed: (){
          showModalBottomSheet(
            backgroundColor: Colors.white,
            showDragHandle: false,
            context: context,
            builder: (_) {
              return Container(
                width: double.infinity,
                height: 90,
                padding: EdgeInsets.only(top: 20.0),
                color: HexColor("FFFFFF"),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.messenger),
                              SizedBox(height: 5,),
                              Text("문자")
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.messenger),
                              SizedBox(height: 5,),
                              Text("카카오")
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.messenger),
                              SizedBox(height: 5,),
                              Text("뭐시기")
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.messenger),
                              SizedBox(height: 5,),
                              Text("문자")
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        },),
      ],
    );
  }
}

class _iconButton extends StatelessWidget {
  final IconData btnIcons;
  final VoidCallback onPressed;

  const _iconButton({
    required this.btnIcons,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(
          size: 20.0,
          btnIcons,
          color: Colors.black87,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Color(0xFFF5F6FA),
          foregroundColor: Color(0xFFF5F6FA),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}


class _reanderButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const _reanderButton({
    required this.btnName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Color(0xFFF5F6FA),
          foregroundColor: Color(0xFFF5F6FA),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
