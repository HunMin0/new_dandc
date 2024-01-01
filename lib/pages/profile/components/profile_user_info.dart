import 'package:flutter/material.dart';

class ProfileUserInfo extends StatelessWidget {
  final String userName;
  final String userInfo;
  final String imgPath;

  const ProfileUserInfo({
    required this.userName,
    required this.userInfo,
    required this.imgPath,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 34.0,
          backgroundImage: AssetImage('assets/images/sample/${imgPath}.jpg'),
        ),
        SizedBox(
          width: 18.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 2.0,
              ),
              Text(userInfo),
            ],
          ),
        )
      ],
    );
  }
}
