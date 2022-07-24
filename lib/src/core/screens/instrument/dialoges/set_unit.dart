import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_unit_add_instrument_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetUnitDialog extends StatefulWidget {
  const SetUnitDialog({Key? key}) : super(key: key);

  @override
  _SetUnitDialogState createState() => _SetUnitDialogState();
}

class _SetUnitDialogState extends State<SetUnitDialog> {

  UnitResponse unitSelected = UnitResponse();
  @override
  Widget build(BuildContext context) {
    return BlocListener<SetUnitAddInstrumentCubit, SetUnitAddInstrumentState>(
      listener: (context, state) {
        /// empty !?
      },
      child: AlertDialog(
        content: BlocBuilder<SetUnitAddInstrumentCubit,SetUnitAddInstrumentState>(
            builder:  (context, state){
              if (state is SetUnitAddInstrumentInitial){
                context.read<SetUnitAddInstrumentCubit>().getUnit();
              }
              if (state is SetUnitAddInstrumentLoading){
                return const Center(child: CircularProgressIndicator(),);
              }

              if (state is SetUnitAddInstrumentLoaded){
                unitSelected = state.unit!;
                return ListView.builder(
                    itemCount: state.units.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        tileColor: index.isOdd? Colors.blueGrey[100]: Colors.white,
                        title: Text(state.units[index].name.toString()),
                        leading: Radio(
                            value: state.units[index],
                            groupValue: unitSelected,
                            onChanged: (value){
                              debugPrint("#=> value is $value");
                              context.read<SetUnitAddInstrumentCubit>().setUnit(state.units,state.units[index]);
                              Navigator.pop(context);
                            }
                        ),
                      );
                    }
                );
              }

              if (state is SetUnitAddInstrumentFault){
                return Center(
                  child: Column(
                    children: [
                      Text(state.message, style: const TextStyle(fontSize: 25),),
                      TextButton(onPressed: () {
                        context.read<SetUnitAddInstrumentCubit>().reload();
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

