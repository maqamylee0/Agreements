import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/rating/model/rate_model.dart';

class Rated extends StatefulWidget {
  const Rated({Key? key,  required this.rate}) : super(key: key);
final RateModel rate;
  @override
  State<Rated> createState() => _RatedState();
}

class _RatedState extends State<Rated> {
  var sum;
  @override
  void initState() {
    super.initState();
    var utilility = widget.rate.utility;
    var maintenance = widget.rate.maintenamnce;
    var rent =  widget.rate.rent;
    var condition = widget.rate.condition;
    var neighbour = widget.rate.neighbourliness;
   sum  = utilility!+maintenance!+rent! + condition!+neighbour!;
  }
  @override
  Widget build(BuildContext context) {

    return Container(

      child : Card(

        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("${widget.rate.nameTenant}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rated By :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                    Text("${widget.rate.emailLandLord}"),


                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Neigbourliness: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.star_half,size: 22,),
                        SizedBox(width: 5,),
                        Text("${widget.rate.neighbourliness}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Utility: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.star_half,size: 22,),
                        SizedBox(width: 5,),
                        Text("${widget.rate.utility}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rent: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.star_half,size: 22,),
                        SizedBox(width: 5,),
                        Text("${widget.rate.rent}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Maintenance: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.star_half,size: 22,),
                            SizedBox(width: 5,),
                            Text("${widget.rate.maintenamnce}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Condition: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.star_half,size: 22,),
                            SizedBox(width: 5,),
                            Text("${widget.rate.condition }",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                          ],
                        ),
                      )
                    ],


              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total points: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.star_half,size: 22,),
                        SizedBox(width: 5,),
                        Text("${sum} /9 ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))
                      ],
                    ),
                  )
                ],


              ),
              Text("Comments",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
              Text("${widget.rate.comments}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.green))
            ],
          ),
        ),
      )
    );
  }
}
