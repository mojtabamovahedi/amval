
import 'package:amval/src/config/storage/constants.dart';
import 'package:amval/src/core/screens/category/dialoges/delete_category.dart';
import 'package:amval/src/core/screens/category/dialoges/edit_category.dart';
import 'package:amval/src/data/model/category_response.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  CategoryResponse category;
  CategoryCard({required this.category, Key? key}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 2, 3, 0),
      width: MediaQuery.of(context).size.width*0.95,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.blueGrey[300],
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(242, 242, 251, 1),
                Color.fromRGBO(223, 223, 245, 1),
              ])
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(" ${replaceFarsiNumber(widget.category.id.toString())}) ${widget.category.name}", style: const TextStyle(fontSize: 17),),
              Text(" ${widget.category.parentName.toString()}", style: const TextStyle(fontSize: 13, color: Colors.black45),)
            ],
          ),
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => EditCategoryDialog(category: widget.category));
                  },
                  icon: const Icon(Icons.edit)
              ),
              IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => DeleteCategoryDialog(category: widget.category));
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
