import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/services/add_tenant_service.dart';

import 'models/tenant.dart';

class AddTenant extends StatefulWidget {
  const AddTenant({Key? key}) : super(key: key);

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  int _currentStep = 0;
  TenantModel tenant = TenantModel();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ninController = TextEditingController();
  TextEditingController phoneControlller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nextOfKinController = TextEditingController();
  TextEditingController emergencyPhoneController = TextEditingController();
  TextEditingController previousLandLordPhoneController = TextEditingController();
  TextEditingController currentEmployerPhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {


    tapped(int step){
      setState(() => _currentStep = step);
    }

    continued(){
      _currentStep < 3 ?
      setState(() => _currentStep += 1): null;
    }
    cancel(){
      _currentStep > 0 ?
      setState(() => _currentStep -= 1) : null;
    }


    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add Tenant"),
      ),

      body: SafeArea(
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
                                  title: new Text('Personal Information'),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: nameController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value)=>
                                        value == "" ? "Enter a name": null,
                                        decoration: InputDecoration(labelText: 'Full Name'),
                                        onSaved: (String? value) {
                                          tenant.name = value;
                                        },
                                      ),
                                      TextFormField(
                                        controller: ninController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value)=>
                                        value == '' ? "Enter a nin": null,
                                        decoration: InputDecoration(labelText: 'Nin'),
                                        onSaved: (String? value) {
                                          tenant.nin = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  isActive: _currentStep >= 0,
                                  state: _currentStep >= 0 ?
                                  StepState.complete : StepState.disabled,
                                ),
                                Step(
                                  title: new Text('Contact'),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: phoneControlller,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(labelText: 'Phone Number'),
                                        onSaved: (String? value) {
                                          tenant.phone = value;
                                        },
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (email)=>
                                        email != null && EmailValidator.validate(email) ?  null:"Enter valid Email",
                                        decoration: InputDecoration(labelText: 'Email Address'),
                                        onSaved: (String? value) {
                                          tenant.email = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  isActive: _currentStep >= 0,
                                  state: _currentStep >= 1 ?
                                  StepState.complete : StepState.disabled,
                                ),

                                Step(
                                  title: new Text('Emergency'),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: nextOfKinController,
                                        keyboardType: TextInputType.text,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value)=>
                                        value == '' ? "Enter a next of kin": null,
                                        decoration: InputDecoration(labelText: 'Next of Kin'),
                                        onSaved: (String? value) {
                                          tenant.nextOfKin = value;
                                        },
                                      ),
                                      TextFormField(
                                        controller: emergencyPhoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(labelText: 'Emergency Contact'),
                                        onSaved: (String? value) {
                                          tenant.emergencyPhone = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  isActive: _currentStep >= 0,
                                  state: _currentStep >= 2 ?
                                  StepState.complete : StepState.disabled,
                                ),
                                Step(
                                  title: new Text('About'),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: previousLandLordPhoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(labelText: 'Previous landlord Number'),
                                        onSaved: (String? value) {
                                          tenant.previousLandLordPhone = value;
                                        },
                                      ),
                                      TextFormField(
                                        controller: currentEmployerPhoneController,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(labelText: 'Current Employer Contact'),
                                        onSaved: (String? value) {
                                          tenant.currentEmployerPhone = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  isActive:_currentStep >= 0,
                                  state: _currentStep >= 3 ?
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
                            saveDetails(context)

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

  saveDetails(context) async {
    final prefs = await SharedPreferences.getInstance();
    var userid =  await prefs.getString('userid');
    tenant.landlordUid = userid;
    tenant.name = nameController.text;
    tenant.nin = ninController.text;
    tenant.phone= phoneControlller.text ;
    tenant.email = emailController.text;
    tenant.nextOfKin = nextOfKinController.text;
    tenant.emergencyPhone = emergencyPhoneController.text;
    tenant.previousLandLordPhone= previousLandLordPhoneController.text;
    tenant.currentEmployerPhone = currentEmployerPhoneController.text;

    print(tenant.name);
    print(nameController.value.text);
    print('hi');
    print(userid);

    AddTenantMethod addtenant = AddTenantMethod();
    addtenant.addTenants(context,tenant);

  }
}
