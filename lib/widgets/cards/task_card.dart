import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart';
import 'package:todo/models/task_model.dart';

class TaskCard extends StatelessWidget{
  const TaskCard({super.key,required this.taskModel,required this.onTap});
  final TaskModel taskModel;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blue.withOpacity(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                  ),
                  Text(
                  taskModel.subTitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color :Colors.blueGrey),
                ),
                  Text (
                    taskModel.isCompleted
                    ? DateFormat("EEE-dd-MMM-yyyy")
                    .format(DateTime.parse(
                      taskModel.createdAt.toString()))
                      .replaceAll("-",",")
                      :format(taskModel.createdAt as DateTime),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.withOpacity(0.5)),
                  )
                ],
              ),
              Checkbox(value: taskModel.isCompleted, 
              onChanged: (check){
                onTap();
              },
              ),
            ],
            ),
           )),
        );
    
  }
}