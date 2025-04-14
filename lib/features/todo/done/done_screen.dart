import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swd4_s1/core/layout/todo/controller/cubit/cubit.dart';
import 'package:swd4_s1/core/layout/todo/controller/cubit/state.dart';
import 'package:swd4_s1/core/shared/widgets/todo_widget/build_item.dart';
import 'package:swd4_s1/core/shared/widgets/todo_widget/build_task_item.dart';


class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasks;
        return BuildItem(tasks: tasks);;
      },
    );

  }
}

