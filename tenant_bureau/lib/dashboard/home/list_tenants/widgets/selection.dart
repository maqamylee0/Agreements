import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/rating/model/rate_model.dart';

class Select extends StatefulWidget {

  const Select({Key? key, required this.selections, required this.selected, this.onChanged,   }) : super(key: key);
  final List<String> selections;
  final  int selected ;
  final Function(int?)? onChanged;
  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  // late int selected;


  @override
  void initState() {
    super.initState();
   // selected = 0;


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // height: MediaQuery.of(context).size.height*0.7,

      child: ListView.builder(
          itemCount: widget.selections.length,

          itemBuilder: (ctx , index){
            return Container(
              height: 30,
              child: Row(
                children: [
                  Radio<int>(

                      value: index,
                      groupValue: widget.selected,
                      onChanged: widget.onChanged,
                  ),
                  Text('${widget.selections[index]}',style: TextStyle(color:Colors.brown,fontWeight: FontWeight.w600))
                ],
              ),
            );
          }

      ),
    );
  }
}
