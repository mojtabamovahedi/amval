
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/core/screens/unit/dialoges/delete_unit.dart';
import 'package:amval/src/core/screens/unit/dialoges/edit_unit.dart';
import 'package:amval/src/data/model/unit_response.dart';
import 'package:flutter/material.dart';

class UnitCard extends StatefulWidget {
  UnitResponse unit;
  UnitCard({required this.unit, Key? key}) : super(key: key);

  @override
  State<UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<UnitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 2, 3, 0),
      width: MediaQuery.of(context).size.width,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: const Color.fromRGBO(255,255,255,1),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(242, 242, 251, 1),
                Color.fromRGBO(223, 223, 245, 1),
              ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(" ${replaceFarsiNumber(widget.unit.id.toString())}) ${widget.unit.name}", style: const TextStyle(fontSize: 17, color: Colors.black),),
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => UnitEditDialog(unit: widget.unit));
                  },
                  icon: const Icon(Icons.edit)
              ),
              IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => UnitDeleteDialog(unit: widget.unit));
                  },
                  icon: const Icon(Icons.delete)
              ),
            ],
          )
        ],
      ),
    );
  }
}




