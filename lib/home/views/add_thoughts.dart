import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../db/db_helper.dart';
import '../../widgets/text_widgets.dart';
import '../controller/date_controller.dart';
import '../viewmodel/calling_function.dart';

class AddThought extends StatefulWidget {
  const AddThought({Key? key}) : super(key: key);

  @override
  State<AddThought> createState() => _AddThoughtState();
}

class _AddThoughtState extends State<AddThought> {
  TextEditingController dateCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();

  final DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      constraints: BoxConstraints(
        maxHeight: size.height * 0.5,
      ),
      width: size.width,
      // height: 250,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            text17("Add your thought"),
            const Divider(),
            Obx(
              () => TextFormField(
                onTap: () {
                  dateController.selectDate(context);
                },
                readOnly: true,
                controller: dateCont
                  ..text = dateController.dateSelect.toString(),
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: (){
                    dateController.selectDate(context);
                  }, icon: const Icon(Icons.calendar_month)),
                    labelText: "Select Date", hintText: "Select Date"),
              ),
            ),
            TextFormField(
              controller: titleCont,
              decoration: const InputDecoration(
                  labelText: "Title", hintText: "Enter Title"),
            ),
            TextFormField(
              controller: descriptionCont,
              decoration: const InputDecoration(
                  labelText: "Thought", hintText: "Enter your thoughts",
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              saveThought(dateController.dateSelect.toString(),titleCont.text,descriptionCont.text);
              getUsers();
            }, child: const Text("Submit"),),
          ],
        ),
      ),
    );
  }
  void saveThought(String date,String title,String description) async {
      final User user = User(date: date, title: title, description: description);
      // Insert the user into the database.
      await insertUser(user);
      dateController.dateSelect.value="";
      titleCont.clear();
      descriptionCont.clear();
      Get.back();
      fetchUser();
  }
}
