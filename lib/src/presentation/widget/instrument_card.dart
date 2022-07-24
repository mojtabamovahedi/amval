
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/data/model/instrument_response.dart';
import 'package:flutter/material.dart';

class InstrumentCard extends StatelessWidget {
  final InstrumentResponse instrument;
  final void Function()? onTap;

  const InstrumentCard({required this.instrument, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width-50)/2;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255,255,255,1),
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(	242, 242, 251,1),
              Color.fromRGBO(255,255,255,1),
              Color.fromRGBO(223, 223, 245, 1),
          ])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  "$baseUrl${instrument.image.toString()}",
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
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) =>
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: width,
                  height: 220,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  [
                        Icon(Icons.error, size: 50,color: Colors.red[200],),
                        const SizedBox(height: 5.0,),
                        Text("خطا در دریافت", style: TextStyle(color: Colors.red[200]),),
                      ],
                    ),
                  ),
                ),
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(instrument.name.toString(), style: const TextStyle(fontSize: 17.5),),
                  const SizedBox(width: 3.5,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(replaceFarsiNumber(instrument.serialCode.toString()), style: const TextStyle(fontSize: 12.0),),
                  const SizedBox(width: 3.5,),
                ],
              ),
            ],
        ),
      ),
      onTap: onTap,
    );
  }
}


