
import 'package:amval/src/presentation/logic/cubit/assignment/assignment_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/instrument_cubit.dart';
import 'package:amval/src/presentation/widget/instrument_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Instrument extends StatefulWidget {
  const Instrument({Key? key}) : super(key: key);

  @override
  _InstrumentState createState() => _InstrumentState();
}

class _InstrumentState extends State<Instrument> {

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<InstrumentCubit, InstrumentState>(
  listener: (context, state) {
    if (state is InstrumentFault){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
  },
  child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.5, 5.0, 0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        context.read<InstrumentCubit>().searchBySerialNumber(searchController.text);
                      },
                    ),
                    icon: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    hintText: "جستوجو با شماره سریال",
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("  ابزارهای شرکت", style: TextStyle(fontSize: 20),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: ()async{
                            await context.read<InstrumentCubit>().getList();
                          },
                          icon: const Icon(Icons.refresh),
                        ),IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, "/add_instrument");
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
                BlocBuilder<InstrumentCubit, InstrumentState>(
                  builder: (context, state) {
                    if (state is InstrumentLoaded){
                      return Text('   تعداد ابزار یافت شده: ${state.instruments.length} ');
                    }
                    return const Text('تعداد ابزار یافت شده:...  ');
                  },
                ),
              ],
            ),
                const SizedBox(height: 2.5,),
                BlocBuilder<InstrumentCubit, InstrumentState>(
                builder: (context, state) {
                  if (state is InstrumentInitial){
                    context.read<InstrumentCubit>().getList();
                    return Center(
                      child: LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: 50),
                    );
                  }
                  if(state is InstrumentLoaded){
                    if (state.instruments.isNotEmpty){
                      return Expanded(
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 7.5, mainAxisSpacing: 5,mainAxisExtent: 300),
                            itemCount: state.instruments.length,
                            itemBuilder: (BuildContext context,index){
                              return InstrumentCard(
                                  instrument: state.instruments[index],
                                  onTap: (){
                                    BlocProvider.of<AssignmentCubit>(context).getAssignment(state.instruments[index].id!.toInt());
                                    Navigator.pushNamed(context, "/instrument_profile", arguments: state.instruments[index]);
                                  }
                              );
                            }
                        ),
                      );
                    }else{
                      return const Center(
                        child: Text("ابزاری جهت نمایش وجود ندارد"),
                      );
                    }
                  }

                  if(state is InstrumentLoading){
                    return Center(
                      child: LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: 50),
                    );
                  }

                  if(state is InstrumentFault){
                    return Center(
                      child: TextButton(
                          onPressed: (){
                            context.read<InstrumentCubit>().getList();
                          },
                          child: const Text("reload!")),
                    );
                  }

                  return Center(
                    child: LoadingAnimationWidget.threeRotatingDots(color: Colors.black, size: 50),
                  );
                }
                ),
          ],
        ),
      )
      ),
);
  }
}
