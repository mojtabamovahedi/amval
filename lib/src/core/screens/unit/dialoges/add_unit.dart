
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/unit/create_unit_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/unit/unit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _formKey = GlobalKey<FormState>();


class AddUnitDialog extends StatefulWidget {
  const AddUnitDialog({Key? key}) : super(key: key);

  @override
  _AddUnitDialogState createState() => _AddUnitDialogState();
}


class _AddUnitDialogState extends State<AddUnitDialog> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateUnitCubit, CreateUnitState>(
      listener: (context, state) {
        if (state is CreateUnitSuccess) {
          _nameController.clear();
          Navigator.pop(context);
          BlocProvider.of<UnitCubit>(context).getList();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message),duration: durationForSuccessMessage));
        }
        if (state is CreateUnitFailure) {
          _nameController.clear();
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message),duration: durationForErrorMessage));
        }
      },
      child: Form(
        key: _formKey,
        child: AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: TextFormField(
              textAlign: TextAlign.right,
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text("نام واحد جدید"),
                hintText: "نام واحد جدید را اینجا وارد کنید",
                hintStyle: TextStyle(fontSize: 12.0),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (name) {
                if (name!.isEmpty) {
                  return "فیلد مورد نظر نباید خالی باشد";
                }
                return null;
              },
            ),
          ),
          actions: [
            BlocBuilder<CreateUnitCubit, CreateUnitState>(
              builder: (context, state) {
                return state is CreateUnitLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                          _nameController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("خروج")
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await context
                                .read<CreateUnitCubit>()
                                .pressedAddUnit(_nameController.text);
                          }
                        },
                        child: const Text("ثبت")),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
