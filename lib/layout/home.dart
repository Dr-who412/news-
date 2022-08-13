import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/modules/cubit/newscubit.dart';
import 'package:untitled2/modules/cubit/states.dart';

class Home extends StatelessWidget {
  var searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.title[cubit.currentIndex],
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontSize: 22, color: Theme.of(context).primaryColor),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeIndex(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_outlined), label: "news"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: "archive"),
            ],
          ),
          body: cubit.screen[cubit.currentIndex],
        );
      },
    );
  }
}
