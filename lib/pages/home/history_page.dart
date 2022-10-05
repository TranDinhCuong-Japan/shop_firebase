import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/controller/history_controller.dart';
import 'package:shop_firebase/utils/app_color.dart';
import 'package:shop_firebase/utils/dimensison.dart';
import 'package:shop_firebase/widgets/big_text_widget.dart';
import 'package:shop_firebase/widgets/small_text_widget.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shop_firebase/widgets/title_and_detail.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    // Get.find<HistoryController>().getAllHistory();
    Get.find<HistoryController>().getHistory();
    TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigTextWidget(name: "History",color: Colors.white,fontSize: Dimensisons.size30,)),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensisons.size20, left: Dimensisons.size20, right: Dimensisons.size20,bottom: Dimensisons.size10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: Dimensisons.size310,
                  child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          _textController.text="";
                          Get.find<HistoryController>().getHistory();
                        },
                          child: Icon(Icons.clear)),
                      hintText: "Enter date",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );
                      if(pickedDate != null ){
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        _textController.text = formattedDate;
                        Get.find<HistoryController>().search(_textController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
                child: GetBuilder<HistoryController>(
                    builder: (history) {
                      return history.isLoader?Container(
                        padding: EdgeInsets.only(top: Dimensisons.size20,left: Dimensisons.size20, right: Dimensisons.size20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: history.historyList.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              margin: EdgeInsets.only(bottom: Dimensisons.size10),
                              padding: EdgeInsets.only(left: Dimensisons.size20, right: Dimensisons.size20,),
                              width: double.maxFinite,
                              height: Dimensisons.size150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(Dimensisons.size20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFe8e8e8),
                                        blurRadius: Dimensisons.size5,
                                        offset: Offset(0,5)
                                    )
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigTextWidget(name: history.historyList[index].date.toString(),fontSize: Dimensisons.size30,),
                                  TitleAndDetail(title: "user", detail: history.historyList[index].name.toString()),
                                  TitleAndDetail(title: "Start", detail: history.historyList[index].startTime.toString()),
                                  TitleAndDetail(title: "End", detail: history.historyList[index].endTime.toString()),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                          :Center(
                          child:Container(
                            padding: EdgeInsets.only(top: Dimensisons.size50),
                            child: BigTextWidget(name: "Do not data!",color: AppColors.mainColor,),
                          )
                      )
                      ;
                    }
                ),
              ),
        ],
      )
    );
  }
}
