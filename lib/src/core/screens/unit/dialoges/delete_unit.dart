
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:amval/src/presentation/logic/cubit/unit/delete_unit_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/unit/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitDeleteDialog extends StatefulWidget {
  UnitResponse unit;
  UnitDeleteDialog({required this.unit, Key? key}) : super(key: key);

  @override
  State<UnitDeleteDialog> createState() => _UnitDeleteDialogState();
}

class _UnitDeleteDialogState extends State<UnitDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("آیا میخواهید واحد ${widget.unit.name.toString()} حذف شود؟"),
      actions: [
        BlocProvider(
          create: (context) => DeleteUnitCubit(repository: APIUnit()),
          child: BlocConsumer<DeleteUnitCubit, DeleteUnitState>(
            listener: (context, state) {
              if (state is DeleteUnitFault){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("خطا در حذف واحد")));
              }
              if (state is DeleteUnitDeleted){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("واحد با موفقیت حذف شد")));
                context.read<UnitCubit>().getList();
              }
            },
            builder: (context, state) {
              if (state is DeleteUnitInitial){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("خیر")
                    ),
                    TextButton(
                        onPressed: (){
                          context.read<DeleteUnitCubit>().deleteUnit(widget.unit.id!.toInt());
                        },
                        child: const Text("بله")
                    ),
                  ],
                );
              }
              if (state is DeleteUnitLoading){
                return const LinearProgressIndicator();
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
