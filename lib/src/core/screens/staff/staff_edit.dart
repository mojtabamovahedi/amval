import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/staff_response.dart';
import 'package:amval/src/presentation/logic/cubit/staff/edit_staff_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/staff/staff_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StaffEdit extends StatefulWidget {
  StaffResponse staff;
  StaffEdit({required this.staff, Key? key}) : super(key: key);

  @override
  State<StaffEdit> createState() => _StaffEditState();
}

class _StaffEditState extends State<StaffEdit> {

  late final _firstNameController;
  late final _lastNameController;
  late final _nationalIDController;
  late final _userNameController;

  final _formKey = GlobalKey<FormState>();
  final double heightSpace = 17.0;


  @override
  void dispose() {
    _nationalIDController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _firstNameController = TextEditingController(text: widget.staff.firstName.toString());
    _lastNameController = TextEditingController(text: widget.staff.lastName.toString());
    _nationalIDController = TextEditingController(text: widget.staff.nationalId.toString());
    _userNameController = TextEditingController(text: widget.staff.username.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditStaffCubit, EditStaffState>(
  listener: (context, state) {
    if (state is EditStaffFault){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
    }
    if (state is EditStaffSuccess){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("با موفقیت ویرایش شد.")));
      BlocProvider.of<StaffCubit>(context).getList();
      Navigator.pop(context);
    }
  },
  child: Scaffold(
      appBar: AppBar(
        title: const Text("ویرایش کارمند"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: (MediaQuery.of(context).size.width)*0.8,
              child: Column(
                children: [
                  SizedBox(height: heightSpace,),
                  TextFormField(
                    controller: _firstNameController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('نام'),
                      hintText: "نام را وارد کنید",
                      hintStyle: TextStyle(fontSize: 12.0),
                      fillColor: fieldColor, filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    validator: (text) {
                      if (text!.isEmpty){
                        return "نام نباید خالی باشد";
                      }return null;
                    },
                  ),
                  SizedBox(height: heightSpace,),

                  // last name of new staff
                  TextFormField(
                    controller: _lastNameController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('نام خانوادگی'),
                      hintText: "نام خانوادگی خود را وارد کنید",
                      hintStyle: TextStyle(fontSize: 12.0),
                      fillColor: fieldColor, filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    validator: (text) {
                      if (text!.isEmpty){
                        return "نام خانوادگی نباید خالی باشد";
                      }return null;
                    },
                  ),
                  SizedBox(height: heightSpace,),

                  // national id of new staff
                  TextFormField(
                    controller: _nationalIDController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('کد ملی'),
                      hintText: "کد ملی را وارد کنید",
                      hintStyle: TextStyle(fontSize: 12.0),
                      fillColor: fieldColor, filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    validator: (text) {
                      if (text!.isEmpty){
                        return "کد ملی نباید خالی باشد";
                      }return null;
                    },
                  ),
                  SizedBox(height: heightSpace,),

                  TextFormField(
                    controller: _userNameController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('نام کاربری'),
                      hintText: "نام کاربری را وارد کنید",
                      hintStyle: TextStyle(fontSize: 12.0),
                      fillColor: fieldColor, filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    validator: (text) {
                      if (text!.isEmpty){
                        return "نام کاربری نباید خالی باشد";
                      }return null;
                    },
                  ),
                  const SizedBox(height: 35,),

                  Container(
                    width: 120,
                    height: 50,
                    color: buttonColor,
                    child: BlocBuilder<EditStaffCubit, EditStaffState>(
                      builder: (context, state) {
                        return state is EditStaffLoading
                            ? Center(
                          child: LoadingAnimationWidget.waveDots(
                              color: Colors.white, size: 25.0),
                        )
                            : TextButton(
                          child: const Text(
                            "ثبت",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_formKey.currentState!.validate()) {
                              FormData data = FormData.fromMap({
                                "username":_userNameController.text,
                                "password":widget.staff.password,
                                "first_name":_firstNameController.text,
                                "last_name":_lastNameController.text,
                                "national_id":_nationalIDController.text,
                                "company":1,
                              });
                              context.read<EditStaffCubit>().editStaff(data, widget.staff.id!.toInt());
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    ),
);
  }
}
