
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/data/repositories/unit_api.dart';
import 'package:amval/src/presentation/logic/cubit/unit/edit_unit_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/unit/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitEditDialog extends StatefulWidget {
  UnitResponse unit;
  UnitEditDialog({required this.unit, Key? key}) : super(key: key);

  @override
  State<UnitEditDialog> createState() => _UnitEditDialogState();
}

class _UnitEditDialogState extends State<UnitEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final newNameController = TextEditingController();

  @override
  void dispose() {
    newNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: newNameController,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: " نام جدید واحد ${widget.unit.name.toString()}",
            hintStyle: const TextStyle(fontSize: 12.0),
            fillColor: fieldColor,
            filled: true,
          ),
          validator: (text) {
            if (text!.isEmpty) {
              return 'لطفا نام جدید را وارد کنید';
            }
            return null;
          },
        ),
      ),
      actions: [
        BlocProvider(
          create: (context) => EditUnitCubit(repository: APIUnit()),
          child: BlocConsumer<EditUnitCubit, EditUnitState>(
            listener: (context, state) {
              if (state is EditUnitFault){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("خطا در ویرایش واحد")));
              }
              if (state is EditUnitEdited){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("واحد با موفقیت ویرایش شد")));
                context.read<UnitCubit>().getList();
              }
            },
            builder: (context, state) {
              if (state is EditUnitInitial){
                return TextButton(
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_formKey.currentState!.validate()) {
                        context.read<EditUnitCubit>().editUnit(widget.unit, newNameController.text);
                      }
                    },
                    child: const Text("ثبت"));
              }
              if (state is EditUnitLoading){
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


