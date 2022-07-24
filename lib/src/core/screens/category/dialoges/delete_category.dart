
import 'package:amval/src/data/repositories/category_api.dart';
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/presentation/logic/cubit/category/category_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/category/delete_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCategoryDialog extends StatefulWidget {
  CategoryResponse category;
  DeleteCategoryDialog({required this.category, Key? key}) : super(key: key);

  @override
  State<DeleteCategoryDialog> createState() => _DeleteCategoryDialogState();
}

class _DeleteCategoryDialogState extends State<DeleteCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("آیا میخواهید زیرمجموعه ${widget.category.name.toString()} حذف شود؟"),
      actions: [
        BlocProvider(
          create: (context) => DeleteCategoryCubit(repository: APICategory()),
          child: BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
            listener: (context, state) {
              if (state is DeleteCategoryFault){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("خطا در حذف زیرمجموعه")));
              }
              if (state is DeleteCategoryDeleted){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("زیرمجموعه با موفقیت حذف شد")));
                context.read<CategoryCubit>().getAllList();
              }
            },
            builder: (context, state) {
              if (state is DeleteCategoryInitial){
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
                          context.read<DeleteCategoryCubit>().deleteCategory(widget.category.id!.toInt());
                        },
                        child: const Text("بله")
                    ),
                  ],
                );
              }
              if (state is DeleteCategoryLoading){
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
