import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompanyAddStepTwo extends StatefulWidget {
  const CompanyAddStepTwo({super.key});

  @override
  State<CompanyAddStepTwo> createState() => _CompanyAddStepTwoState();
}

class _CompanyAddStepTwoState extends State<CompanyAddStepTwo> {
  bool isProcessable = false;
  bool hasHoliday = true;
  // 휴무일
  String closedData = '';

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

    final clearBottomSheetButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: Color(0xFFABABAB),
      backgroundColor: Color(0xFF75A8E4),
      side: BorderSide(
        color: Colors.white,
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
                // if (hasHoliday == true) {
                //   '영업시간을 선택해주세요'
                //   }else {
                //   '휴무일이 있나요?'
                //   }

                (hasHoliday == true && closedData != null)
                    ? '영업시간을 선택해주세요'
                    : (!hasHoliday ? '영업시간을 선택해주세요' : '휴무일이 있나요?'),
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
                    JoinTextFormField(
                        label: '휴무일을 입력해주세요',
                        hintText: '예) 공휴일 휴무, 월요일 마다 휴무',
                        onChanged: (String value) {
                          closedData = value;
                        }),
                  SizedBox(
                    height: 10.0,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text('영업시간을 선택해주세요'),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  style: closedData.isNotEmpty
                                  ? clearBottomSheetButtonStyle
                                  : bottomSheetButtonStyle,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.white,
                                        showDragHandle: true,
                                        context: context,
                                        builder: (_) {
                                          return _BuildDateTime(
                                            onTimeSelected: (DateTime startTime, DateTime endTime){
                                              setState(() {
                                                String formattedStartTime = "${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}";
                                                String formattedEndTime = "${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}";
                                                closedData =
                                                '영업시간: $formattedStartTime ~ $formattedEndTime';
                                              });
                                            },
                                          );
                                        });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: closedData.isNotEmpty ? Colors.white : Color(0xFF75A8E4),
                                        size: 20.0,
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        closedData.isNotEmpty
                                        ? closedData
                                        : '여기를 눌러서 시간선택',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w700,
                                            color: closedData.isNotEmpty ? Colors.white : Color(0xFF75A8E4)),
                                      ),
                                    ],
                                  ))),
                        ],
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '주말/공휴일 시간도 동일 한가요?',
                            style: TextStyle(fontSize: 13.0),
                          ),
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
                                        '항상 같아요',
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
                                        '다를때가 있어요',
                                        style: TextStyle(fontSize: 13.0),
                                      ))),
                            ],
                          ),
                          JoinTextFormField(
                              label: '휴무일을 입력해주세요',
                              hintText: '예) 공휴일 휴무, 월요일 마다 휴무',
                              onChanged: (String value) {
                                closedData = value;
                              }),
                        ],
                      )

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





class _BuildDateTime extends StatefulWidget {
  final Function(DateTime, DateTime) onTimeSelected;

  const _BuildDateTime({
    required this.onTimeSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<_BuildDateTime> createState() => _BuildDateState();
}

class _BuildDateState extends State<_BuildDateTime> {
  DateTime initialDateTime1 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
  DateTime initialDateTime2 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 0);

  @override
  Widget build(BuildContext context) {
    initialDateTime1 = initialDateTime1.subtract(Duration(
      minutes: initialDateTime1.minute % 30,
    ));
    initialDateTime2 = initialDateTime2.subtract(Duration(
      minutes: initialDateTime2.minute % 30,
    ));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Column(
          children: [
            Text('영업시간 선택', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700,),),
            Divider(height: 30.0, color: Color(0xFFdddddd),),
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(initialDateTime1, (DateTime newTime) {
                    setState(() {
                      initialDateTime1 = newTime;
                    });
                    widget.onTimeSelected(initialDateTime1, initialDateTime2);
                  }),
                ),
                Text('~', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),),
                Expanded(
                  child: _buildDatePicker(initialDateTime2, (DateTime newTime) {
                    setState(() {
                      initialDateTime2 = newTime;
                    });
                    widget.onTimeSelected(initialDateTime1, initialDateTime2);
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                  widget.onTimeSelected(initialDateTime1, initialDateTime2);
                  Navigator.pop(context);
                }, child: Text('확인'))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(DateTime initialDateTime, Function(DateTime) onChanged) {
    return Container(
      height: 200.0,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: initialDateTime,
        minuteInterval: 30, // 30분 간격
        use24hFormat: true, // 24시간 형식 사용
        onDateTimeChanged: onChanged,

      ),
    );
  }
}
