import 'dart:io';


import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/core/screens/instrument/dialoges/set_unit.dart';
import 'package:amval/src/data/model/category_response.dart';
import 'package:amval/src/data/model/unit_response.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/add_instrument_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_capture_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_category_add_instrument_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_unit_add_instrument_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'dialoges/set_category.dart';

class AddInstrument extends StatefulWidget {
  const AddInstrument({Key? key}) : super(key: key);

  @override
  _AddInstrumentState createState() => _AddInstrumentState();
}

class _AddInstrumentState extends State<AddInstrument> {



  UnitResponse unit = UnitResponse(name: "انتخاب واحد", id: 0,company: 1);
  CategoryResponse category = CategoryResponse(name: "انتخاب دسته بندی", company: 1, parent: null);
  final _formKey = GlobalKey<FormState>();

  // controllers of TextFormField
  final _instrumentNameController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _staffController = TextEditingController();

  // some final height
  final double heightSpace = 17.0;
  final double heightField = 45.0;

  @override
  void dispose() {
    _instrumentNameController.dispose();
    _serialNumberController.dispose();
    _descriptionController.dispose();
    _staffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
  listeners: [
    BlocListener<AddInstrumentCubit, AddInstrumentState>(
  listener: (context, state) {
    if (state is AddInstrumentSuccess){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),duration: durationForSuccessMessage));
    }

    if (state is AddInstrumentFailure){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),duration: durationForErrorMessage));
    }
  },
),
    BlocListener<SetUnitAddInstrumentCubit, SetUnitAddInstrumentState>(
      listener: (context, state) {
        if (state is SetUnitAddInstrumentSetUnit){
          unit = state.unit;
        }
      },
    ),
    BlocListener<SetCategoryAddInstrumentCubit, SetCategoryAddInstrumentState>(
      listener: (context, state) {
        if (state is SetCategoryAddInstrumentSetCategory){
          category = state.category;
        }
      },
    ),
  ],
  child: Scaffold(
      appBar: AppBar(
        title: const Text('افزودن وسیله'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16,),
                Row(
                  children: [

                    const SizedBox(width: 12,),

                    SizedBox(
                      width: ((MediaQuery.of(context).size.width)/2)-20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // name of instrument
                          TextFormField(
                            controller: _instrumentNameController,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('نام محصول'),
                              hintText: "نام محصول خود را وارد کنید",
                              hintStyle: TextStyle(fontSize: 12.0),
                              fillColor: fieldColor, filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              errorStyle: TextStyle(fontSize: 0,),
                            ),
                            validator: (text) {
                              if (text!.isEmpty){
                                return "";
                              }return null;
                            },
                          ),
                          SizedBox(height: heightSpace,),

                          // serial number of instrument
                          TextFormField(
                            controller: _serialNumberController,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('شماره سریال'),
                              hintText: "شماره سریال را وارد کنید",
                              hintStyle: TextStyle(fontSize: 12.0),
                                fillColor: fieldColor, filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              errorStyle: TextStyle(fontSize: 0,),
                            ),
                            validator: (text) {
                              if (text!.isEmpty){
                                return "";
                              }return null;
                            },
                          ),
                          SizedBox(height: heightSpace,),

                          // id of staff
                          TextFormField(
                            controller: _staffController,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('شماره کارمند'),
                              hintText: "شماره کارمند را وارد کنید",
                              hintStyle: TextStyle(fontSize: 12.0),
                              fillColor: fieldColor, filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20),
                              errorStyle: TextStyle(fontSize: 0,),
                            ),
                            validator: (text) {
                              if (text!.isEmpty){
                                return "";
                              }return null;
                            },
                          ),
                          SizedBox(height: heightSpace,),

                          // category of instrument
                            BlocBuilder<SetCategoryAddInstrumentCubit,
                                SetCategoryAddInstrumentState>(
                              builder: (context, state) {
                                return Container(
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              const SetCategoryDialog());
                                    },
                                    child: Text(
                                      category.name.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  color: buttonColor,
                                );
                              },
                            ),
                            SizedBox(
                              height: heightSpace,
                            ),

                            // unit of instrument
                            BlocBuilder<SetUnitAddInstrumentCubit,
                                SetUnitAddInstrumentState>(
                              builder: (context, state) {
                                return Container(
                                  child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              const SetUnitDialog());
                                    },
                                    child: Text(
                                      unit.name.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  color: buttonColor,
                                );
                              },
                            ),
                            SizedBox(height: heightSpace,),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10,),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          BlocBuilder<SetCaptureCubit, bool>(
                            builder: (context, state) {
                              return Container(
                                width: ((MediaQuery.of(context).size.width)/2)-20,
                                height: 200,
                                child: (state)
                                    ? GestureDetector(
                                        child: Image.file(
                                          File(capturePath),
                                          errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace){
                                            return const Center(
                                                child: Text(
                                                    'photo is here',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    )));
                                          },
                                        ),
                                  onTap: (){
                                    showDialog(context: context, builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Image.file(File(capturePath)),
                                        contentPadding: const EdgeInsets.all(3),
                                        backgroundColor: Colors.black,
                                      );
                                    });},
                                      )
                                    : Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.no_photography, color: Color.fromRGBO(196, 194, 193, 1),),
                                            Text("no photo here", style: TextStyle(color: Color.fromRGBO(196, 194, 193, 1)),)
                                          ],
                                        )
                                ),
                                color: const Color.fromRGBO(243, 243, 243, 1),
                              );
                            },
                          ),
                          SizedBox(height: heightSpace,),
                        TextButton(
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.pushNamed(context, "/camera");
                              },
                            child: Container(
                              width: 80,
                              height: 35,
                              color: buttonColor,
                              child: const Center(child: Text("دوربین", style: TextStyle(color: Colors.white),),),
                            )
                        )
                      ],
                    ),

                    const SizedBox(width: 12,),
                  ],
                ),

                const SizedBox(height: 10,),

                SizedBox(
                  width: (MediaQuery.of(context).size.width)-35,
                  child: TextField(
                    style: const TextStyle(
                      height: 3.0,
                    ),
                    controller: _descriptionController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.multiline,
                    minLines: 1, maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("توضیحات اضافی"),
                      fillColor: fieldColor, filled: true,
                      isDense: true,
                    ),
                  ),
                ),

                const SizedBox(height: 5.0,),
                BlocBuilder<AddInstrumentCubit, AddInstrumentState>(
                  builder: (context, state) {
                    return TextButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formKey.currentState!.validate()) {
                            if (capturePath.isNotEmpty && unit.id != 0 && category.id != 0){
                              File image = File(capturePath);
                              FormData data =FormData.fromMap({
                                "name" : _instrumentNameController.text,
                                "image" : MultipartFile.fromBytes(await image.readAsBytes(), filename: (image.path.split('/').last)),
                                "serial_code" : _serialNumberController.text,
                                "category" : category.id,
                                "company" : 1,
                                "staffs" : _staffController.text,
                                "unit" : unit.id,
                                "state" : "سالم"
                              });
                              context.read<AddInstrumentCubit>().create(data);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: const Text("اطلاعات ناقص است"),duration: durationForErrorMessage));
                          }
                        },
                        child: Container(
                          width: 80,
                          height: 35,
                          color: buttonColor,
                          child: Center(
                            child: state is AddInstrumentLoading
                                ? LoadingAnimationWidget.waveDots(color: Colors.white, size: 25.0)
                                :  const Text(
                              "ارسال",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ));
                  },)
              ],
            ),
          )
      ),
    ),
);
  }
}

