import 'package:amval/src/data/model/staff_response.dart';
import 'package:amval/src/data/repositories/staff_api.dart';
import 'package:amval/src/presentation/logic/cubit/staff/delete_staff_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/staff/staff_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteStaffDialog extends StatefulWidget {
  StaffResponse staff;
  DeleteStaffDialog({required this.staff, Key? key}) : super(key: key);

  @override
  State<DeleteStaffDialog> createState() => _DeleteStaffDialogState();
}

class _DeleteStaffDialogState extends State<DeleteStaffDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("آیا میخواهید کارمند ${widget.staff.firstName.toString()} ${widget.staff.lastName.toString()} حذف شود؟"),
      actions: [
        BlocProvider(
          create: (context) => DeleteStaffCubit(repository: APIStaff()),
          child: BlocConsumer<DeleteStaffCubit, DeleteStaffState>(
            listener: (context, state) {
              if (state is DeleteStaffFault){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("خطا در حذف زیرمجموعه")));
              }
              if (state is DeleteStaffDeleted){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("زیرمجموعه با موفقیت حذف شد")));
                context.read<StaffCubit>().getList();
              }
            },
            builder: (context, state) {
              if (state is DeleteStaffInitial){
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
                          context.read<DeleteStaffCubit>().deleteStaff(widget.staff.id!.toInt());
                        },
                        child: const Text("بله")
                    ),
                  ],
                );
              }
              if (state is DeleteStaffLoading){
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
