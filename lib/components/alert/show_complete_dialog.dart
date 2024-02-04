import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:flutter/material.dart';

class ShowCompleteDialog extends StatelessWidget {
  final VoidCallback onConfirmed;
  final String messageTitle;
  final String messageText;
  final String buttonText;

  const ShowCompleteDialog({
    Key? key,
    required this.onConfirmed,
    required this.messageText,
    required this.messageTitle,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.all(14.0),
      contentPadding: EdgeInsets.all(14.0),
      title: Text(
        messageTitle,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
      messageText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13.0),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onConfirmed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SettingStyle.MAIN_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
