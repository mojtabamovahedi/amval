
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/instrumentpieces_response.dart';
import 'package:flutter/material.dart';

class PieceWidget extends StatefulWidget {
  InstrumentPiecesResponse piece;
  PieceWidget({required this.piece, Key? key}) : super(key: key);

  @override
  _PieceWidgetState createState() => _PieceWidgetState();
}

class _PieceWidgetState extends State<PieceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      color: const Color.fromRGBO(223, 223, 245, 1),
      borderRadius: BorderRadius.circular(2.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 5,),
          Image.network(
              '$baseUrl${widget.piece.image}',
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                if(loadingProgress == null){
                  return child;
                }
                return Container(
                  color: Colors.yellow,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) => Container(
                height: 90.0,
                width: 90.0,
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
                    ]
                  ),
                ),
              )
          ),
          const SizedBox(height: 2,),
          Text(
            "${widget.piece.name}",
            style: const TextStyle(color: Colors.black, fontSize: 17),
            maxLines: 1,
          ),
          Text(
              replaceFarsiNumber(widget.piece.serialCode.toString()),
              style: const TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
