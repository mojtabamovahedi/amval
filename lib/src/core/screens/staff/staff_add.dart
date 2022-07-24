
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/presentation/logic/cubit/staff/add_staff_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddStaff extends StatefulWidget {
  const AddStaff({Key? key}) : super(key: key);

  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nationalIDController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final double heightSpace = 17.0;


  @override
  void dispose() {
    _phoneNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nationalIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddStaffCubit, AddStaffState>(
  listener: (context, state) {
    if (state is AddStaffSuccess){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),duration: durationForSuccessMessage));
    }
    if (state is AddStaffFailure){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),duration: durationForErrorMessage));
    }
  },
  child: Scaffold(
      appBar: AppBar(
        title: const Text("افزودن کارمند"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: ((MediaQuery.of(context).size.width)/100)*80,
              child: Column(
                children: [
                  SizedBox(height: heightSpace,),

                  // first name of new staff
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

                  // phone number of new staff
                  TextFormField(
                    controller: _phoneNumberController,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('شماره تماس'),
                      hintText: "شماره تماس را وارد کنید",
                      hintStyle: TextStyle(fontSize: 12.0),
                      fillColor: fieldColor, filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    validator: (text) {
                      if (text!.isEmpty){
                        return "شماره تماس نباید خالی باشد";
                      }return null;
                    },
                  ),
                  const SizedBox(height: 35,),

                    Container(
                      width: 120,
                      height: 50,
                      color: buttonColor,
                      child: BlocBuilder<AddStaffCubit, AddStaffState>(
                        builder: (context, state) {
                          return state is AddStaffLoading
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
                                      context.read<AddStaffCubit>().addStaff(
                                          _firstNameController.text,
                                          _lastNameController.text,
                                          double.parse(_nationalIDController.text),
                                          _phoneNumberController.text);
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
        ),
      ),
    ),
);
  }
}
