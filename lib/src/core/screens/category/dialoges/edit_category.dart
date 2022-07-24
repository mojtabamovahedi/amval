
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/presentation/logic/cubit/category/category_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/category/edit_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCategoryDialog extends StatefulWidget {
  CategoryResponse category;
  EditCategoryDialog({required this.category, Key? key}) : super(key: key);

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
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
            hintText: " نام جدید زیرمجموعه ${widget.category.name.toString()}",
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
          create: (context) => EditCategoryCubit(repository: APICategory()),
          child: BlocConsumer<EditCategoryCubit, EditCategoryState>(
            listener: (context, state) {
              if (state is EditCategoryFault){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("خطا در ویرایش واحد")));
              }
              if (state is EditCategoryEdited){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("واحد با موفقیت ویرایش شد")));
                context.read<CategoryCubit>().getAllList();
              }
            },
            builder: (context, state) {
              if (state is EditCategoryInitial){
                return TextButton(
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_formKey.currentState!.validate()) {
                        context.read<EditCategoryCubit>().editCategory(widget.category, newNameController.text);
                      }
                    },
                    child: const Text("ثبت"));
              }
              if (state is EditCategoryLoading){
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
