
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/assignment_response.dart';
import 'package:amval/src/data/model/instrument_response.dart';
import 'package:amval/src/presentation/logic/cubit/assignment/assignment_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/assignment/is_expanded_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument/set_capture_cubit.dart';
import 'package:amval/src/presentation/logic/cubit/instrument_pieces/instrument_pieces_cubit.dart';
import 'package:amval/src/presentation/widget/piece_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

class InstrumentProfile extends StatefulWidget {
  final InstrumentResponse instrument;

  const InstrumentProfile({required this.instrument, Key? key})
      : super(key: key);

  @override
  _InstrumentProfileState createState() => _InstrumentProfileState();
}

class _InstrumentProfileState extends State<InstrumentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.instrument.name.toString()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Center(
                            child: Text(
                          "سریال: ${replaceFarsiNumber(widget.instrument.serialCode.toString())}",
                          style: const TextStyle(fontSize: 20.0, color: Colors.white),
                        )),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.5, horizontal: 3),
                        color: containerColor,
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Container(
                        child: Center(
                            child: Text(
                          "زیرمجموعه: ${replaceFarsiNumber(widget.instrument.categoryName.toString())}",
                          style: const TextStyle(fontSize: 15.0, color: Colors.white),
                        )),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.5, horizontal: 3),
                        color: containerColor,
                      ),
                      const SizedBox(
                        height: 2.5,
                      ),
                      Container(
                        child: Center(
                            child: Text(
                          "واحد: ${replaceFarsiNumber(widget.instrument.unitName.toString())}",
                          style: const TextStyle(fontSize: 15.0, color: Colors.white),
                        )),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.5, horizontal: 3),
                        color: containerColor,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network("$baseUrl/${widget.instrument.image.toString()}",
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                              if(loadingProgress == null){
                                return child;
                              }
                              return Container(
                                color: Colors.yellow,
                                height: 100.0,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => Container(
                                  height: 100.0,
                                  color: const Color.fromRGBO(243, 243, 243, 1),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children:  [
                                        Icon(
                                          Icons.error,
                                          color: Colors.red[200],
                                        ),
                                        Text(
                                          "خطا در دریافت",
                                          style: TextStyle(color: Colors.red[200]),
                                        )
                                      ],
                                    ),
                                  ),
                                )),

                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0,),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 40.0,
              color: containerColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      flex:3,
                      child: Text(
                        ' مالک فعلی: ${widget.instrument.staffName.toString()}',
                        style: const TextStyle(fontSize: 15.0, color: Colors.white),)
                  ),
                  Flexible(
                      flex:1,
                      child: TextButton(
                          onPressed: (){
                            BlocProvider.of<InstrumentPiecesCubit>(context).emit(InstrumentPiecesInitial());
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: const Text("قطعات:"),
                                    content: PieceDialog(id: widget.instrument.id!.toInt()),
                                  );
                                }
                            );
                          },
                          child:Container(
                              child: const Center(child: Text("قطعات",style: TextStyle(color: Color.fromRGBO(0, 25, 112, 1)),)),
                              color: const Color.fromRGBO(223, 223, 245, 1),
                              padding: const EdgeInsets.all(1.5)
                          ))
                  ),
                  Flexible(
                      flex:1,
                      child: TextButton(
                          onPressed: (){
                            BlocProvider.of<SetCaptureCubit>(context).removeCapture();
                            Navigator.pushNamed(context, "/assignment", arguments: widget.instrument);
                          },
                          child:Container(
                            child: const Center(child: Text("واگذاری",style: TextStyle(color: Color.fromRGBO(0, 25, 112, 1)),)),
                            color: const Color.fromRGBO(223, 223, 245, 1),
                            padding: const EdgeInsets.all(1.5)
                          ),),)
                ],
              ) ,
            ),
            const SizedBox(height: 5.0,),
            BlocConsumer<AssignmentCubit, AssignmentState>(
              builder: (context, state) {
                if (state is AssignmentInitial) {
                  context
                      .read<AssignmentCubit>()
                      .getAssignment(widget.instrument.id!.toInt());
                }

                if (state is AssignmentLoading) {
                  return Center(
                    child: LoadingAnimationWidget.threeRotatingDots(
                        color: Colors.white, size: 50),
                  );
                }

                if (state is AssignmentLoaded) {
                  if (state.assignments.isEmpty){
                    return const Center(
                      child: Text("برای این ابزار تاکنون جابه جایی ثبت نشده"),
                    );
                  }else{
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await context.read<AssignmentCubit>().refresh(widget.instrument.id!.toInt());
                        },
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.assignments.length,
                          itemBuilder: (context, index) {
                            AssignmentResponse indexAssignment = state.assignments[index];
                            return BlocProvider(
                              create: (context) => IsExpandedCubit(),
                              child: BlocBuilder<IsExpandedCubit, bool>(
                                builder: (context, state) {
                                  return ExpansionPanelList(
                                    animationDuration:
                                    const Duration(milliseconds: 500),
                                    children: [
                                      ExpansionPanel(
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return ListTile(
                                            title: Text(' تحویل گیرنده: ${indexAssignment.receiverPersonName.toString()}'),
                                            subtitle: Text(indexAssignment.date!.toPersianDate()),
                                          );
                                        },
                                        body: Container(
                                            child: Text(' تحویل دهنده: ${indexAssignment.deliverPersonName.toString()}'),
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2.0) ,
                                        ),
                                        isExpanded: state,
                                      )
                                    ],
                                    expansionCallback: (panelIndex, isExpanded) {
                                      context.read<IsExpandedCubit>().changeExpanded(!state);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, input) => const SizedBox(height: 3.5,),
                        ),
                      ),
                    );
                  }
                }
                if (state is AssignmentFault) {
                  return Center(
                    child: TextButton(
                      child: const Text('بارگذاری مجدد'),
                      onPressed: () {
                        context
                            .read<AssignmentCubit>()
                            .getAssignment(widget.instrument.id!.toInt());
                      },
                    ),
                  );
                }
                return Center(
                  child: TextButton(
                    child: const Text('بارگذاری مجدد!!'),
                    onPressed: () {
                      context
                          .read<AssignmentCubit>()
                          .getAssignment(widget.instrument.id!.toInt());
                    },
                  ),
                );
              },
              listener: (context, state) {
                if (state is AssignmentFault) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
                if (state is AssignmentInitial) {}
              },
            )
          ],
        ),
      ),
    );
  }
}

class PieceDialog extends StatefulWidget {
  int id;
  PieceDialog({required this.id, Key? key}) : super(key: key);

  @override
  _PieceDialogState createState() => _PieceDialogState();
}

class _PieceDialogState extends State<PieceDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstrumentPiecesCubit, InstrumentPiecesState>(
        builder:(context, state){
          if (state is InstrumentPiecesInitial){
            context.read<InstrumentPiecesCubit>().getList(widget.id);
          }
          if (state is InstrumentPiecesLoading){
            return const LinearProgressIndicator();
          }
          if (state is InstrumentPiecesLoaded){
            if (state.InstrumentPieces.isEmpty){
              return const Text('هیچ ابزاری ثبت نشده است!');
            }else{
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 170, crossAxisSpacing: 2.5, mainAxisSpacing: 2.5),
                  shrinkWrap: true,
                  itemCount: state.InstrumentPieces.length,
                  itemBuilder: (BuildContext context, index){
                    return PieceWidget(piece: state.InstrumentPieces[index]);
                  }

              );
            }
          }
          if (state is InstrumentPiecesFault){
            return Center(
              child: TextButton(
                  onPressed: (){
                    context.read<InstrumentPiecesCubit>().getList(widget.id);
                  },
                  child: const Text('تلاش مجدد')),
            );
          }
          return const LinearProgressIndicator();
        }
    );

  }
}

