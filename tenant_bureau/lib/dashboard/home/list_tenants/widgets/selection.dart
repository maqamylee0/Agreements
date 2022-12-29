import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Select extends StatefulWidget {
  const Select({Key? key, required this.selections, required this.selected,  }) : super(key: key);
  final List<String> selections;
  final  String selected ;
  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  late String selected;
  @override
  void initState() {
    super.initState();
   selected = widget.selected;

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
              child: Row(
                children: [
                  Radio<String>(

                      value: widget.selections[index],
                      groupValue: selected,
                      onChanged: (s){
                      setState(() {
                      selected = s!;

                    });
                  }),
                  Text('${widget.selections[index]}',style: TextStyle(color:Colors.brown,fontWeight: FontWeight.w600))
                ],
              ),
            );
          }

      ),
    );
  }
}
