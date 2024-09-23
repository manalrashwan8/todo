import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/task_provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/widgets/cards/task_card.dart';

import '../widgets/dialogs/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController taskTitleController = TextEditingController();
TextEditingController taskSubtitleController= TextEditingController();

@override
void initState(){
  Provider.of<TaskProvider>(context, listen: false).getTasks();
  super.initState();
}
  List<TaskModel> tasks = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, taskConsumer, _){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          showDialog(
            context: context,
             builder: (context){
              return AddTaskDialog(
                titleController: taskTitleController,
                 subTitleController: taskSubtitleController,
                  formKey: formKey, 
                  onTap: (){
                    Provider.of<TaskProvider>(context,listen: false)
                    .addTask(TaskModel(
                      title: taskTitleController.text,
                      subtitle: 
                      taskSubtitleController.text.isEmpty
                      ?null
                      : taskSubtitleController.text, 
                      createdAt: 
                      DateTime.now().toIso8601String(), isCompleted: false, subTitle: ''));
                      taskTitleController.clear();
                      taskSubtitleController.clear();
                      Navigator.pop(context);
                  });
             });
        }),
        appBar: AppBar(
          title: const Text("TODO"),
        ),
        body: DefaultTabController(
          length: 2, 
          child: Column(
            children: [
              const TabBar(
                isScrollable: false,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                
                tabs: [
                  Tab(
                    text: "Waiting",
                  ),
                  Tab(
                    text: "Completed",
                  )
                ]),
                Expanded(
                
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: taskConsumer.tasks.length,
                        itemBuilder: (context,index){
                          return taskConsumer.tasks[index].isCompleted
                          ? const SizedBox()
                          :TaskCard(
                            taskModel: taskConsumer.tasks[index], 
                            onTap: (){
                              Provider.of<TaskProvider>(context,
                              listen: false)
                              .switchValue(
                                taskConsumer.tasks[index]
                              );
                            });
                        },
                       ),
                       ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: taskConsumer.tasks.length,
                        itemBuilder: (context, index){
                          return !taskConsumer.tasks[index].isCompleted
                          ? const SizedBox()
                          : TaskCard(
                            taskModel: taskConsumer.tasks[index], 
                          onTap: (){
                            Provider.of<TaskProvider>(context,
                            listen: false)
                            .switchValue(
                              taskConsumer.tasks[index]);
                          });
                          
                        },
                        ),
                    ]),
                  ) 
            ],
          ),
      ));
  });
      }}