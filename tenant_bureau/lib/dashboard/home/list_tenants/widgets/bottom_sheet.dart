import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/models/tenant.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/widgets/selection.dart';

class BottomRate extends StatefulWidget {
  const BottomRate({Key? key, required this.tenant}) : super(key: key);
 final TenantModel tenant;
  @override
  State<BottomRate> createState() => _BottomRateState();
}

class _BottomRateState extends State<BottomRate> {
  int _currentStep = 0;
  late String selected;
  List<String> selections = ['Good','Middle','Bad'];
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController commentsController = TextEditingController();


  @override
  void initState() {
    super.initState();
    selected = selections.first;
  }


  @override
  Widget build(BuildContext context) {
    tapped(int step){
      setState(() => _currentStep = step);
    }

    continued(){
      _currentStep < 4 ?
      setState(() => _currentStep += 1): null;
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
                SizedBox(
                  height: 50,
                ),
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
                          title: new Text('Neighbourliness',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                          content: Column(
                            children: <Widget>[
                             Container(
                               child: Column(
                                 children: [
                                   Text("How was the tenants behaviour with neighbours?",style: TextStyle(fontWeight: FontWeight.w600)),
                                   Select(selections: selections,selected: selected,)
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
                          title: new Text('Utilities',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("Payment of water bills ,electricity bills ?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections,selected: selected,)
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
                          title: new Text('Rent',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("Payment of rent?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections,selected: selected,)
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
                          title: new Text('House Maintenance',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600)),
                          content: Column(
                            children: <Widget>[

                              Container(
                                child: Column(
                                  children: [
                                    Text("How was the condition of the house?",style: TextStyle(fontWeight: FontWeight.w600)),
                                    Select(selections: selections,selected: selected,)
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
                                    Select(selections: selections,selected: selected,)
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
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
                ElevatedButton(

                  child: Text("Save",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                  onPressed: () => {
                    // if (formKey.currentState!.validate()) {
                    //   formKey.currentState?.save(),

                    // saveDetails(context);
                    Navigator.pop(context)
                    // }else{

                    // print('valid');
                    // TenantModel tenant = TenantModel();


                    // print(tenant.name)

                    //   }

                    // auth.signIn(context, emailController.text, passwordController.text)
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(60),
                    primary: Colors.brown[700],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),


        ),

      ),
    );
  }
}
