import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suraj_test/home/viewmodel/calling_function.dart';
import 'package:suraj_test/home/views/add_thoughts.dart';
import 'controller/date_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DateController dateController = Get.put(DateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("My Diary"),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (){
          Get.bottomSheet(
              const AddThought(),
            isScrollControlled: true,
          );
        }, child: Icon(Icons.add),),
      body:Obx(() {
        return  ListView.builder(
            itemCount: thoughtsList.length,
            itemBuilder: (context,index){
              final thought = thoughtsList[index];
              print(thought);
              return SizedBox(
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date - ${thought['date']}"),
                        Text("Title - ${thought['title']}",style: TextStyle(color: Colors.black87,),),
                        Text("Discription - ${thought['description']}"),
                      ],
                    ),
                  ),
                ),
              );
            });
      })
    );
  }
}
