import 'package:Deal_Connect/pages/profile/partner_attend/partner_attend_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUserButton extends StatelessWidget {
  const ProfileUserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         _reanderButton(btnName: '프로필 공유하기', onPressed: (){},),
        SizedBox(
          width: 10.0,
        ),
        _reanderButton(btnName: '파트너 신청 확인하기', onPressed: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context) => PartnerAttendIndex()));
        },),
      ],
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
