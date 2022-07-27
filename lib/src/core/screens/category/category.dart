
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/category/category_cubit.dart';
import 'package:amval/src/presentation/widget/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dialoges/add_category.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

String address = "/";

class _CategoryState extends State<Category> {


  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        // empty
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5.5, 5.5, 5.5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.black,),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<CategoryCubit>().searchCategory(searchController.text);
                    },
                  ),
                  icon: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  hintText: "جستوجو با نام",
                  fillColor: Colors.white70,
                  filled: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("  زیر مجموعه های شرکت", style: TextStyle(fontSize: 20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: ()async{
                          address = "/";
                          await context.read<CategoryCubit>().getCategories(null);
                        },
                        icon: const Icon(Icons.refresh),
                      ),IconButton(
                        onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => const AddCategoryDialog());
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoaded){
                    return Text('   ریزمجموعه های یافت شده: ${replaceFarsiNumber(state.categories.length.toString())} ');
                  }
                  return const Text('   زیرمجموعه های یافت شده:...');
                },
              ),

              BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state){
                if (state is CategoryLoaded){
                  return Text("    $address");
                }
                return const Text("");
              }),
              BlocBuilder<CategoryCubit,CategoryState>(
                  builder: (context, state){
                    if (state is CategoryInitial){
                      address = "/";
                      context.read<CategoryCubit>().getCategories(null);
                    }

                    if (state is CategoryLoading){
                      return Center(
                        child: LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: 50),
                      );
                    }

                    if (state is CategoryLoaded){
                      if (state.categories.isNotEmpty){
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2.5),
                            child: ListView.separated(
                              itemCount: state.categories.length,
                              itemBuilder: (context, index){
                                return CategoryCard(category: state.categories[index]);
                              },
                              separatorBuilder: (context, input) => const SizedBox(height: 3.5,),
                            ),
                          ),
                        );
                      }else{
                        return const Center(child: Text("موردی جهت نمایش وجود ندارد"),);
                      }
                    }

                    if (state is CategoryFault){
                      return const Center(child: Text("خطا"),);
                    }

                    return Center(
                      child: LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: 50),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

