import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled2/modules/cubit/newscubit.dart';
import 'package:untitled2/modules/cubit/states.dart';
import '../shared/componant/componants.dart';
import '../shared/componant/constance.dart';

class News extends StatelessWidget {
  var searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return SafeArea(
          left: true,
          right: true,
          top: true,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                  child: TextFormField(
                    controller: searchcontroller,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Search can't be empty";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      cubit.getSearch(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: Text(
                        "Search",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                      prefix: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 2,
                          // color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Country",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              DropdownButton(
                                  dropdownColor: Colors.white,
                                  menuMaxHeight: 400,
                                  value: cubit.currentCountry,
                                  underline: Divider(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        fontSize: 12,
                                        color: prim,
                                      ),
                                  items: cubit.countries.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text(
                                          "      $items          ",
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    searchcontroller.clear();
                                    cubit.changeCountry(value);
                                    value == cubit.currentCountry
                                        ? cubit.getNews()
                                        : print(value);
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Category",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              DropdownButton(
                                  dropdownColor: Colors.white,
                                  value: cubit.currentCategory,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(fontSize: 12, color: prim),
                                  underline: Divider(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  items: cubit.categorys.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          items,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    cubit.onclose();
                                    searchcontroller.clear();
                                    cubit.changeCategory(value);
                                    value == cubit.currentCategory
                                        ? cubit.getNews()
                                        : print(value);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                coditionalList(
                    context: this, list: cubit.newsArticle, state: state),
              ],
            ),
          ),
        );
      },
    );
  }
}
