import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/core/screens/unit/dialoges/add_unit.dart';
import 'package:amval/src/presentation/logic/cubit/unit/unit_cubit.dart';
import 'package:amval/src/presentation/widget/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Unit extends StatefulWidget {
  const Unit({Key? key}) : super(key: key);

  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UnitCubit, UnitState>(
  listener: (context, state) {
    /// empty ?!
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
                    context.read<UnitCubit>().searchUnit(searchController.text);
                  },
                ),
                icon: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                hintText: "جستوجو بانام",
                fillColor: Colors.white70,
                filled: true,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("  واحدهای شرکت", style: TextStyle(fontSize: 20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: ()async{
                        await context.read<UnitCubit>().getList();
                      },
                      icon: const Icon(Icons.refresh),
                    ),IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => const AddUnitDialog());
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
            BlocBuilder<UnitCubit, UnitState>(
              builder: (context, state) {
                if (state is UnitLoaded){
                  return Text('   تعداد واحد یافت شده: ${replaceFarsiNumber(state.unitResponse.length.toString())} ');
                }
                return const Text('   تعداد واحد یافت شده:...');
              },
            ),

              BlocBuilder<UnitCubit,UnitState>(
                builder: (context, state){
                  if (state is UnitInitial){
                    context.read<UnitCubit>().getList();
                  }

                  if (state is UnitLoading){
                    return Center(
                      child: LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: 50),
                    );
                  }

                  if (state is UnitLoaded){
                    if (state.unitResponse.isNotEmpty){
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2.5),
                          child: ListView.separated(
                            itemCount: state.unitResponse.length,
                            itemBuilder: (context, index){
                              return UnitCard(unit: state.unitResponse[index]);
                            },
                            separatorBuilder: (context, input) => const SizedBox(height: 3.5,),
                          ),
                        ),
                      );
                    }else{
                      return const Center(child: Text("موردی جهت نمایش یافت نشد"),);
                    }
                  }

                  if (state is UnitFault){
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

