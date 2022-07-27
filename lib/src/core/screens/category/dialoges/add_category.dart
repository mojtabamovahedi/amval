
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/category/category_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/category/create_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _formKey = GlobalKey<FormState>();


class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({Key? key}) : super(key: key);

  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _nameController = TextEditingController();
  final _parentController = TextEditingController();
  Color borderColor = Colors.blue;

  @override
  void dispose() {
    _nameController.dispose();
    _parentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateCategoryCubit, CreateCategoryState>(
      listener: (context, state) {
        if (state is CreateCategorySuccess) {
          _nameController.clear();
          _parentController.clear();
          Navigator.pop(context);
          BlocProvider.of<CategoryCubit>(context).getAllList();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message),duration: durationForSuccessMessage));
        }
        if (state is CreateCategoryFailure) {
          _nameController.clear();
          _parentController.clear();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText:"نام دسته جدید",
                            hintStyle: TextStyle(fontSize: 12.0),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                          validator: (name) {
                            if (name!.isEmpty) {
                              return "نام نباید خالی باشد.";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 4,
                        child: VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: borderColor,
                        ),
                      ),
                      Flexible(
                          flex:2,
                          child: TextField(
                            controller: _parentController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "شناسه",
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 3.0,),
                const Text(
                  'فیلد شناسه برای "دسته بندی مادر" میباشد و میتواند خالی باشد',
                  style: TextStyle(fontSize: 12.0, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            BlocBuilder<CreateCategoryCubit, CreateCategoryState>(
              builder: (context, state) {
                return state is CreateCategoryLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                          _nameController.clear();
                          _parentController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("خروج")
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await context
                                .read<CreateCategoryCubit>()
                                .createCategory(_nameController.text, (_parentController.text.isEmpty)? null : int.parse(_parentController.text));
                          }
                        },
                        child: const Text("ثبت")),
                  ],
                );
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,

        ),
      ),
    );
  }
}
