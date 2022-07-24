
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_category_add_instrument_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetCategoryDialog extends StatefulWidget {
  const SetCategoryDialog({Key? key}) : super(key: key);

  @override
  _SetCategoryDialogState createState() => _SetCategoryDialogState();
}

class _SetCategoryDialogState extends State<SetCategoryDialog> {
  CategoryResponse categorySelected = CategoryResponse();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SetCategoryAddInstrumentCubit, SetCategoryAddInstrumentState>(
      listener: (context, state) {
        /// empty !?
      },
      child: AlertDialog(
        content: BlocBuilder<SetCategoryAddInstrumentCubit,SetCategoryAddInstrumentState>(
            builder: (context, state){
              if (state is SetCategoryAddInstrumentInitial){
                context.read<SetCategoryAddInstrumentCubit>().getCategory();
              }
              if (state is SetCategoryAddInstrumentLoading){
                return const Center(child: CircularProgressIndicator(),);
              }

              if (state is SetCategoryAddInstrumentLoaded){
                categorySelected = state.category!;
                return ListView.builder(
                    itemCount: state.categories.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        tileColor: index.isEven? Colors.blueGrey[100]: Colors.white,
                        title: Text(state.categories[index].parentName.toString()),
                        leading: Radio(
                            value: state.categories[index],
                            groupValue: categorySelected,
                            onChanged: (value){
                              context.read<SetCategoryAddInstrumentCubit>().setCategory(state.categories, state.categories[index]);
                              Navigator.pop(context);
                            }
                        ),
                      );
                    }
                );
              }

              if (state is SetCategoryAddInstrumentFault){
                return Center(
                  child: Column(
                    children: [
                      Text(state.message, style: const TextStyle(fontSize: 25),),
                      TextButton(onPressed: () {
                        context.read<SetCategoryAddInstrumentCubit>().reload();
                      }, child: const Text("reload!"))
                    ],
                  ),
                );
              }

              return const LinearProgressIndicator();
            }
        ),
      ),
    );
  }
}
