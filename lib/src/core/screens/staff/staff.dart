
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/staff/staff_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Staff extends StatefulWidget {
  const Staff({Key? key}) : super(key: key);

  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<StaffCubit, StaffState>(
      listener: (context, state) {
        if (state is StaffFault){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5.5, 5.5, 5.5, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: searchController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.black,),
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      context.read<StaffCubit>().searchStaff(searchController.text);
                    },
                  ),
                  icon: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  hintText: "جستوجو با کدملی",
                  fillColor: Colors.white70,
                  filled: true,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("  کارمندان شرکت", style: TextStyle(fontSize: 20),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: ()async{
                          await context.read<StaffCubit>().getList();
                        },
                        icon: const Icon(Icons.refresh),
                      ),IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, "/add_staff");
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
              BlocBuilder<StaffCubit, StaffState>(
                builder: (context, state) {
                  if (state is StaffLoaded){
                    return Text('   تعداد کارمندان شرکت: ${replaceFarsiNumber(state.staffs.length.toString())} ');
                  }
                  return const Text('   تعداد کارمندان شرکت:...');
                },
              ),

              BlocBuilder<StaffCubit,StaffState>(
                  builder: (context, state){
                    if (state is StaffInitial){
                      context.read<StaffCubit>().getList();
                    }

                    if (state is StaffLoading){
                      return Center(
                        child: LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: 50),
                      );
                    }

                    if (state is StaffLoaded){
                      if (state.staffs.isNotEmpty){
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2.5),
                            child: ListView.separated(
                              itemCount: state.staffs.length,
                              itemBuilder: (context, index){
                                return Card(
                                  color: const Color.fromRGBO(223, 223, 245, 1),
                                  child: ListTile(
                                    title: Text("${state.staffs[index].id.toString()}) ${state.staffs[index].firstName} ${state.staffs[index].lastName}"),
                                    subtitle: Text("کد ملی: ${state.staffs[index].nationalId}"),
                                  ),
                                );
                              },
                              separatorBuilder: (context, input) => const SizedBox(height: 3.5,),
                            ),
                          ),
                        );
                      }else{
                        return const Center(child: Text("موردی جهت نمایش یافت نشد"),);
                      }
                    }

                    if (state is StaffFault){
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
