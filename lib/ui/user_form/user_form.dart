// ignore_for_file: invalid_return_type_for_catch_error
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shop_app/constants/my_colors.dart';
import '../../firebase/addUserFormToDB.dart';
import '../../utils/myButton.dart';
import '../../utils/myText_field.dart';
import 'components/age_field.dart';
import 'components/header.dart';
import 'components/name_field.dart';
import 'components/phone_field.dart';

class Userform extends StatefulWidget {
  const Userform({super.key});

  @override
  State<Userform> createState() => _UserformState();
}

class _UserformState extends State<Userform> {
  @override
  void initState() {
    _nameController.addListener(() {
      setState(() {});
    });
    _phoneController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: black));
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// header text + arrow_back
              Header(),
              Expanded(
                child: Container(
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(45).w,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// simple text
                          buildText(),
                          buildtext(),
                          SizedBox(
                            height: 15.h,
                          ),

                          /// user form
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  NameField(
                                      nameController: _nameController,
                                      nameNode: _nameNode),
                                  SizedBox(height: 25.h),
                                  PhoneField(
                                    controller: _phoneController,
                                    node: _phoneNode,
                                  ),
                                  SizedBox(height: 25.h),
                                  AgeField(
                                      ageController: _ageController,
                                      ageNode: _ageNode),
                                  SizedBox(height: 25.h),
                                  MyTextField(
                                    controller: _dobController,
                                    focusNode: _dobNode,
                                    label: 'Date of birth*',
                                    readOnly: true,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Field must not be empty!';
                                      }
                                      return null;
                                    },
                                    sufixIcon: IconButton(
                                      onPressed: () =>
                                          _selectDateFromPicker(context),
                                      icon: Icon(
                                        Icons.calendar_today_outlined,
                                        color: _dobNode.hasFocus ||
                                                _dobController.text.isNotEmpty
                                            ? kColor
                                            : Colors.grey[500],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25.h),
                                  TextFormField(
                                    focusNode: _genderNode,
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Field must not be empty!';
                                      }
                                      return null;
                                    },
                                    controller: _genderController,
                                    readOnly: true,
                                    style: TextStyle(color: white),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: _genderController.text.isNotEmpty
                                            ? kColor
                                            : Colors.grey,
                                      )),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color: kColor,
                                      )),
                                      prefixIcon: DropdownButton<String>(
                                        value: _selectedValue,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: _selectedValue == null
                                              ? Colors.grey
                                              : kColor,
                                        ),
                                        iconEnabledColor: _selectedValue == null
                                            ? Colors.grey
                                            : kColor,
                                        hint: Text(
                                          'Choose your gender*',
                                          style: GoogleFonts.actor(
                                            letterSpacing: 1.7.w,
                                          ),
                                        ),
                                        underline: SizedBox(),
                                        focusColor: kColor,
                                        items: gender.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: isTrue
                                                ? Text(
                                                    value,
                                                    style: GoogleFonts.actor(
                                                        letterSpacing: 1.7.w,
                                                        color: kColor),
                                                  )
                                                : Text(
                                                    value,
                                                    style: GoogleFonts.actor(
                                                        color: white),
                                                  ),
                                            onTap: () {
                                              setState(() {
                                                _selectedValue = value;
                                                isTrue = true;
                                                _genderController.text = value;
                                              });
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (_) {},
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 50.h,
                          ),

                          /// submit button
                          MyButton(
                            title: 'SUBMIT',
                            color: kColor,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addUserFormToDb(
                                  nameController: _nameController,
                                  phoneController: _phoneController,
                                  ageController: _ageController,
                                  dobController: _dobController,
                                  genderControler: _genderController,
                                  context: context,
                                );
                                isTrue = false;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// variables

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _ageNode = FocusNode();
  FocusNode _dobNode = FocusNode();
  FocusNode _genderNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  var color;
  bool isTrue = true;

  var _selectedValue;
  List<String> gender = ["Male", "Female", "Other"];

  /// methods

  Text buildtext() {
    return Text(
      "We will not share your information with anyone.",
      style: GoogleFonts.actor(
        fontSize: 14.sp,
        color: Color(0xFFBBBBBB),
      ),
    );
  }

  Text buildText() {
    return Text(
      "Submit the form to continue.",
      style: GoogleFonts.actor(fontSize: 22.sp, color: kColor),
    );
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }
}
