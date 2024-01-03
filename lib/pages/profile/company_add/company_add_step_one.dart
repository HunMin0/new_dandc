import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/material.dart';

class CompanyAddStepOne extends StatefulWidget {
  const CompanyAddStepOne({super.key});

  @override
  State<CompanyAddStepOne> createState() => _CompanyAddStepOneState();
}

class _CompanyAddStepOneState extends State<CompanyAddStepOne> {

  void _showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('주소검색'),
            content: Text('주소모달 내용'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isProcessable = false;

    return DefaultNextLayout(
      titleName: '업체등록',
      isProcessable: isProcessable,
      bottomBar: false,
      prevOnPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      nextOnPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CompanyAddStepOne(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('업체명을 입력 해주세요',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
          SizedBox(
            height: 40.0,
          ),
          Column(
            children: [
              JoinTextFormField(
                label: '업체명',
                hintText: '업체명을 입력해주세요',
                onChanged: (String value) {
                  setState(() {});
                },
              ),
              SizedBox(height: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text('주소',),
                  ),

                  GestureDetector(
                    onTap: (){
                      _showPopup(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 46.0,
                      decoration: BoxDecoration(
                        color: INPUT_BG_COLOR,
                        border: Border.all(width: 1.0,color: INPUT_BORDER_COLOR,),
                      ),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('여기를 눌러 주소 검색', style: TextStyle(color: BODY_TEXT_COLOR),),
                                Icon(Icons.search, color: Color(0xFFABABAB),)
                              ],
                            ),
                          )),
                    ),
                  ),

                  JoinTextFormField(
                    label: '상세주소',
                    enabled: false,
                    hintText: '상세주소를 입력 해주세요',
                    helperText: '주소가 올바르지 않으면 주소검색을 다시 진행 해주세요',
                    onChanged: (String value) {
                      setState(() {});
                    },
                  ),

                ],
              ),


            ],
          ),
        ],
      ),
    );
  }
}
