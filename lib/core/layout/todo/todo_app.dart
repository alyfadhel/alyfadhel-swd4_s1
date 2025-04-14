import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swd4_s1/core/layout/todo/controller/cubit/cubit.dart';
import 'package:swd4_s1/core/layout/todo/controller/cubit/state.dart';
import 'package:swd4_s1/core/shared/widgets/my_from_field.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataFromDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppInsertDataFromDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              titleSpacing: 20.0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.blue,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomShow) {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.insertDataFromDatabase(
                      title: cubit.titleController.text,
                      date: cubit.dateController.text,
                      time: cubit.timeController.text,
                    );
                    cubit.changeFabIcon(isShow: false, icon: Icons.edit);
                  }
                } else {
                  cubit.scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.grey[300],
                          child: Form(
                            key: cubit.formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyFromField(
                                  controller: cubit.titleController,
                                  type: TextInputType.text,
                                  prefix: Icons.title,
                                  text: 'title',
                                  radius: 10.0,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Title must be not empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                MyFromField(
                                  controller: cubit.dateController,
                                  type: TextInputType.datetime,
                                  prefix: Icons.calendar_today,
                                  text: 'date',
                                  radius: 10.0,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date must be not empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2025-12-31'),
                                    ).then((value) {
                                      if (value != null) {
                                        cubit.dateController.text =
                                            DateFormat.yMMMd().format(value);
                                        debugPrint(
                                          DateFormat.yMMMd().format(value),
                                        );
                                      }
                                    });
                                  },
                                ),
                                SizedBox(height: 20.0),
                                MyFromField(
                                  controller: cubit.timeController,
                                  type: TextInputType.datetime,
                                  prefix: Icons.watch_later_outlined,
                                  text: 'time',
                                  radius: 10.0,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Time must be not empty';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(FocusNode());
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      if (value != null) {
                                        if (context.mounted) {
                                          cubit.timeController.text = value
                                              .format(context);
                                        }
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                        cubit.changeFabIcon(isShow: false, icon: Icons.edit);
                      });
                  cubit.changeFabIcon(isShow: true, icon: Icons.add);
                }
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(cubit.fabIcon, color: Colors.white),
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
