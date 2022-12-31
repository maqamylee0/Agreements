import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/models/tenant.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/tenant_list.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/widgets/selection.dart';

import '../../../../rating/model/rate_model.dart';
import '../../../../services/auth.dart';

class BottomRate extends StatefulWidget {
  const BottomRate({Key? key, required this.tenant}) : super(key: key);
 final TenantModel tenant;
  @override
  State<BottomRate> createState() => _BottomRateState();
}

class _BottomRateState extends State<BottomRate> {
  int _currentStep = 0;
  late int selected;
  List<String> selections = ['Bad','Fair','Good'];
  List<String> selections2 = ['No','Yes'];

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController commentsController = TextEditingController();
  List<String> sections = ['Neighbourliness','Utilities','Rent','House Maintenance'];
  RateModel rateModel = RateModel();
  Auth auth = Auth();

  @override
  void initState() {
    super.initState();
    selected = 0;
    rateModel.neighbourliness=0;
    rateModel.utility =0;
    rateModel.rent = 0;
    rateModel.maintenamnce =0;
    rateModel.condition = 0;
  }


  @override
  Widget build(BuildContext context) {
    tapped(int step){
      setState(() => _currentStep = step);
    }

    continued(){
      _currentStep < 4 ?
      setState(() {
        selected = 0;
        _currentStep += 1;}) : null;
    }
    cancel(){
      _currentStep > 0 ?
      setState(() => _currentStep -= 1) : null;
    }
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
       // height: MediaQuery.of(context).size.height*0.7,
        color: Colors.grey,
        child: SingleChildScrollView(
          child:



          Container(
            padding: EdgeInsets.all(20),
            child: Column(

              children: [

                Form(
                  key: formKey,
                  child: Container(

                    child: Stepper(

                      physics: ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: continued,
                      onStepCancel: cancel,
                      steps: <Step>[


                        Step(
                          title: new Text('${sections[0]}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                          content: Column(
                            children: <Widget>[
                             Container(
                               child: Column(
                                 children: [
                                   Text("How was the tenant's behaviour with the neighbours?",style: TextStyle(fontWeight: FontWeight.w600)),
                                   Select(selections: selections,selected: selected,onChanged: (s){
                                   setState(() {
                                     selected = s!;
                                     if (kDebugMode) {
                                       print(s);
                                     }
                                     rateModel.neighbourliness = s;
                                   });
                                   },)
                                 ],
                               ),
                             )

                              ,
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: new Text('${sections[1]}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("Payment of water bills ,electricity bills ?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections,selected: selected, onChanged: (s){
                                     setState(() {
                                       selected = s!;
                                       if (kDebugMode) {
                                         print(s);
                                       }
                                       rateModel.utility = s;
                                     });
                                    },)
                                  ],
                                ),
                              )

                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1 ?
                          StepState.complete : StepState.disabled,
                        ),

                        Step(
                          title: new Text('${sections[2]}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("Payment of rent?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections,selected: selected, onChanged: (s){
                                     setState(() {
                                       selected = s!;
                                       if (kDebugMode) {
                                         print(s);
                                       }
                                       rateModel.rent = s;
                                     });
                                    },)
                                  ],
                                ),
                              )

                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 2 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: new Text('${sections[3]}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("In what state did the tenant leave the house?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections,selected: selected, onChanged: (s){
                                      setState((){
                                        selected = s!;
                                        if (kDebugMode) {
                                          print(s);
                                        }
                                        rateModel.maintenamnce = s;
                                      });

                                    },)
                                  ],
                                ),
                              )
                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 3 ?
                          StepState.complete : StepState.disabled,
                        ),
                        Step(
                          title: new Text('Final condition',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("Would you take them in again?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections2,selected: selected, onChanged: (s){
                                      setState((){
                                        selected = s!;
                                        if (kDebugMode) {
                                          print(s);
                                        }
                                        rateModel.condition = s;
                                      });

                                    },)
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                    border:Border.all(color: Colors.brown)
                                ),
                                      child: TextFormField(
                                        maxLines: 5,
                                        keyboardType: TextInputType.text,
                                        controller: commentsController,
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,

                                        decoration: InputDecoration(
                                            labelText: 'Any Other Comments'),
                                        // onSaved: (String? value) {
                                        //   tenant.name = value;
                                        // },
                                      ),
                                    ),
                                    Text("Any other comments?",style: TextStyle(fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 4 ?
                          StepState.complete : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(

                        child: Text("Save",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),
                        onPressed: () async => {
                           rateModel.comments = commentsController.text,


                           await auth.sendRating(rateModel,widget.tenant,context),
                          // if (formKey.currentState!.validate()) {
                          //   formKey.currentState?.save(),
                          Navigator.pop(context),

                          // saveDetails(context);
                          // }else{

                          // print('valid');
                          // TenantModel tenant = TenantModel();


                          // print(tenant.name)

                          //   }

                          // auth.signIn(context, emailController.text, passwordController.text)
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(30),
                          primary: Colors.brown[700],
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(

                        child: Text("Cancel",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),
                        onPressed: () async => {
                          Navigator.pop(context),

                          // MaterialPageRoute(builder: (context) {
                          //   return TenantList();
                          // }),

                          // auth.signIn(context, emailController.text, passwordController.text)
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(30),
                          primary: Colors.brown[700],
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


        ),

      ),
    );
  }
}
