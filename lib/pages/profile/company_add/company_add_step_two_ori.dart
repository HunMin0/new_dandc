import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/material.dart';

class CompanyAddStepTwo extends StatefulWidget {
  const CompanyAddStepTwo({super.key});

  @override
  State<CompanyAddStepTwo> createState() => _CompanyAddStepTwoState();
}

class _CompanyAddStepTwoState extends State<CompanyAddStepTwo> {
  bool isProcessable = false;
  bool hasHoliday = false;
  bool weekHoliday = false;

  @override
  Widget build(BuildContext context) {
    final hasHolidayButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: hasHoliday == true ? Colors.white : Color(0xFFABABAB),
      backgroundColor: hasHoliday == true ? Color(0xFF75A8E4) : Colors.white,
      side: BorderSide(
        color: hasHoliday == true ? Color(0xFF75A8E4) : Color(0xFFD9D9D9),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );

    final noHolidayButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: hasHoliday == false ? Colors.white : Color(0xFFABABAB),
      backgroundColor: hasHoliday == false ? Color(0xFF75A8E4) : Colors.white,
      side: BorderSide(
        color: hasHoliday == false ? Color(0xFF75A8E4) : Color(0xFFD9D9D9),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );

    final weekHolidayButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: weekHoliday == true ? Colors.white : Color(0xFFABABAB),
      backgroundColor: weekHoliday == true ? Color(0xFF75A8E4) : Colors.white,
      side: BorderSide(
        color: weekHoliday == true ? Color(0xFF75A8E4) : Color(0xFFD9D9D9),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );

    final noWeekHolidayButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: weekHoliday == false ? Colors.white : Color(0xFFABABAB),
      backgroundColor: weekHoliday == false ? Color(0xFF75A8E4) : Colors.white,
      side: BorderSide(
        color: weekHoliday == false ? Color(0xFF75A8E4) : Color(0xFFD9D9D9),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );

    final bottomSheetButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Color(0xFFABABAB),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: Color(0xFF75A8E4),
        width: 1.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      fixedSize: Size.fromHeight(50.0),
      elevation: 0,
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultNextLayout(
        titleName: '업체등록',
        isProcessable: isProcessable,
        bottomBar: true,
        prevTitle: '취소',
        nextTitle: '다음',
        prevOnPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        nextOnPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CompanyAddStepTwo(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '휴무일이 있나요?',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: hasHolidayButtonStyle,
                              onPressed: () {
                                setState(() {
                                  hasHoliday = true;
                                });
                              },
                              child: Text(
                                '휴무일 있어요',
                                style: TextStyle(fontSize: 13.0),
                              ))),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: noHolidayButtonStyle,
                              onPressed: () {
                                setState(() {
                                  hasHoliday = false;
                                });
                              },
                              child: Text(
                                '휴무일 없어요',
                                style: TextStyle(fontSize: 13.0),
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (hasHoliday)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('휴무일 형태선택'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: weekHolidayButtonStyle,
                                    onPressed: () {
                                      setState(() {
                                        weekHoliday = true;
                                      });
                                    },
                                    child: Text(
                                      '월간 휴무일',
                                      style: TextStyle(fontSize: 13.0),
                                    ))),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                                child: ElevatedButton(
                                    style: noWeekHolidayButtonStyle,
                                    onPressed: () {
                                      setState(() {
                                        weekHoliday = false;
                                      });
                                    },
                                    child: Text(
                                      '주간 휴무일',
                                      style: TextStyle(fontSize: 13.0),
                                    ))),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('휴무일을 선택해주세요'),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    style: bottomSheetButtonStyle,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.white,
                                          showDragHandle: true,
                                          context: context,
                                          builder: (_) {
                                            return _buildHoliday();
                                          });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: Color(0xFF75A8E4),
                                          size: 20.0,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          '여기를 눌러서 선택',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Color(0xFF75A8E4)),
                                        ),
                                      ],
                                    ))),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildHoliday extends StatefulWidget {
  const _buildHoliday({
    super.key,
  });

  @override
  State<_buildHoliday> createState() => _buildHolidayState();
}

class _buildHolidayState extends State<_buildHoliday> {
  List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  List<bool> selectedDays = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Container(
          height: 400.0,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: '휴무일 설정 ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        )),
                    TextSpan(
                        text: '(중복선택 가능)',
                        style: TextStyle(
                          color: Color(0xFFABABAB),
                          fontSize: 14.0,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),

              for (int i = 0; i < daysOfWeek.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDays[i] = !selectedDays[i];
                    });
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              daysOfWeek[i],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: 18.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.0,
                              ),
                              color: selectedDays[i]
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                            child: selectedDays[i]
                                ? Icon(
                              Icons.check,
                              size: 18.0,
                              color: Colors.white,
                            )
                                : null,
                          ),
                        ],
                      ),

                      Divider(height: 20,),


                    ],
                  ),
                ),




            ],
          ),
        ),
      ),
    );
  }
}