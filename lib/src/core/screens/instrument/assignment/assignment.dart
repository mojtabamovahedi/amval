import 'dart:io';
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/instrument_response.dart';
import 'package:amval/src/presentation/logic/cubit/assignment/assignment_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/assignment/create_assignment_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_capture_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/staff/retrieve_staff_cubit.dart';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

import 'package:loading_animation_widget/loading_animation_widget.dart';

class Assignment extends StatefulWidget {
  InstrumentResponse instrument;
  Assignment({required this.instrument, Key? key}) : super(key: key);

  @override
  _AssignmentState createState() => _AssignmentState();
}

class _AssignmentState extends State<Assignment> {
  final TextEditingController _idController = TextEditingController();
  String receiverID = "";
  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("واگذاری ${widget.instrument.name}"),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RetrieveStaffCubit, RetrieveStaffState>(
            listener: (context, state) {
              if (state is RetrieveStaffFaultStaff) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
          BlocListener<SetCaptureCubit, bool>(
            listener: (context, state) {
              // empty
            },
          ),
          BlocListener<CreateAssignmentCubit, CreateAssignmentState>(
            listener: (context, state) {
              if (state is CreateAssignmentFault) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is CreateAssignmentSuccess){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                BlocProvider.of<AssignmentCubit>(context).getAssignment(widget.instrument.id!.toInt()); /// refreshing assignment of instrument
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 2.5,),

                assignmentContainer("نام ابزار:", widget.instrument.name.toString()),
                const SizedBox(height: 2.5,),

                assignmentContainer("شماره سریال:",widget.instrument.serialCode.toString()),
                const SizedBox(height: 2.5,),

                assignmentContainer("تحویل دهنده:",widget.instrument.staffName.toString()),
                const SizedBox(height: 5.5,),

                Container(
                  color: containerColor,
                  padding: const EdgeInsets.fromLTRB(1, 0, 2, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2.0, 0, 2.0),
                            child: TextField(
                              controller: _idController,
                              textAlign: TextAlign.end,
                              keyboardType: TextInputType.number,
                              minLines: 1, maxLines: 5,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("شماره تحویل گیرنده", style: TextStyle(fontSize: 10),),
                                fillColor: fieldColor, filled: true,
                                isDense: true,
                              ),
                            ),
                          ),
                          flex: 2,
                      ),
                      Flexible(
                        flex: 1,
                          child: BlocBuilder<RetrieveStaffCubit, RetrieveStaffState>(
                            builder: (context, state) {
                              if (state is RetrieveStaffLoading){
                                return const Center(child: CircularProgressIndicator(),);
                              }else{
                                return TextButton(
                                    onPressed: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if (_idController.text.isNotEmpty){
                                        context.read<RetrieveStaffCubit>().getStaff(int.parse(_idController.text));
                                        receiverID = _idController.text;
                                      }

                                    },
                                    child: Transform(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(2.5),
                                          ),
                                          padding: const EdgeInsets.all(1.5),
                                          child: const Icon(Icons.search, color: Colors.black,)
                                      ),
                                      transform: Matrix4.rotationY(math.pi),
                                      alignment: Alignment.center,
                                    ));
                              }
                            },
                          ),
                        )
                    ],
                  ),
                ),
                const SizedBox(height: 2.5,),

                BlocBuilder<RetrieveStaffCubit, RetrieveStaffState>(
                    builder: (context, state) {
                      if (state is RetrieveStaffGetStaff){
                        return assignmentContainer("تحویل گیرنده", "${state.staff.firstName.toString()} ${state.staff.lastName.toString()}");
                      }else{
                        return assignmentContainer("تحویل گیرنده", "---");
                      }

                    }
                ),
              ],
            ),
          ),

          Flexible(
              flex:1,
              child: Column(
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
                  const SizedBox(height: 3.5,),
                  TextButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pushNamed(context, "/camera");
                      },
                      child: Container(
                        width: 80,
                        height: 35,
                        color: containerColor,
                        child: const Center(child: Text("دوربین", style: TextStyle(color: Colors.white),),),
                      )
                  )
                ],
              ),
          )
        ],
            ),
        BlocBuilder<CreateAssignmentCubit, CreateAssignmentState>(
                builder: (context, state) {
                  final DateTime now = DateTime.now();
                  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
                  return TextButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (receiverID.isNotEmpty && capturePath.isNotEmpty){
                        File image = File(capturePath);
                        FormData data =FormData.fromMap({
                          "deliver_person" : widget.instrument.staffs!.toInt(),
                          "picture" : MultipartFile.fromBytes(await image.readAsBytes(), filename: (image.path.split('/').last)),
                          "receiver_person" : _idController.text,
                          "instrument" : widget.instrument.id!.toInt(),
                          "date" : formatter.format(now),
                        });
                        context.read<CreateAssignmentCubit>().create(data);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("اطلاعات ناقص است")));
                      }

                    },
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: containerColor,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: state is CreateAssignmentLoading
                          ? Center(
                              child: LoadingAnimationWidget.waveDots(
                                  color: Colors.white, size: 25))
                          : const Center(
                              child: Text(
                                "انتقال",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                    ),
                  );
                },
              ),
      ],
    ),
  ),
),
    );
  }
}

Widget assignmentContainer(String name, String info){
  return Container(
    padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
    color: containerColor,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 17.5)
            ),
          ],
        ),
        const SizedBox(height: 1.5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                info,
                style: const TextStyle(color: Colors.white, fontSize: 17.5),
            ),
          ],
        )
      ],
    ),
  );
}
