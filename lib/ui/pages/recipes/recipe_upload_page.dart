import 'package:cookozy_mobile/shared/theme.dart';
import 'package:cookozy_mobile/ui/pages/main_page.dart';
import 'package:cookozy_mobile/ui/widgets/custom_button_widget.dart';
import 'package:cookozy_mobile/ui/widgets/top_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/recipe_service.dart';
import '../../widgets/custom_textformfield.dart';

class RecipeUploadPage extends StatefulWidget {
  final String userId;

  const RecipeUploadPage({
    super.key,
    required this.userId,
  });
  @override
  _RecipeUploadPageState createState() => _RecipeUploadPageState();
}

class _RecipeUploadPageState extends State<RecipeUploadPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  List<TextEditingController> stepsControllers = [TextEditingController()];
  String? selectedCategory;
  String? selectedLevel;
  File? _image;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final recipeService = RecipeService();
        final response = await recipeService.postRecipe(
          titleController.text,
          descriptionController.text,
          ingredientsController.text,
          stepsControllers.map((controller) => controller.text).join('\r\n'),
          selectedCategory!,
          selectedLevel!,
          widget.userId,
          _image!,
        );

        if (response != null && response != 'Failed to upload image') {
          print('Recipe submitted successfully');
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Recipe submitted successfully!')));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                userId: widget.userId,
              ),
            ),
          );
        } else {
          throw Exception('Failed to submit recipe');
        }
      } catch (error) {
        print('Error submitting recipe: $error');
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error submitting recipe. Please try again later.')));
      }
    }
  }

  void _addStep() {
    setState(() {
      stepsControllers.add(TextEditingController());
    });
  }

  void _removeStep(int index) {
    setState(() {
      if (stepsControllers.length > 1) {
        stepsControllers.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kWhiteColor,
          body: Stack(
            children: [
              TopSectionWidget(
                title: "Upload Resep",
                back: true,
              ),
              Container(
                margin: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            CustomTextFormField(
                              title: 'Judul Resep',
                              hintText: 'Masukkan judul resep',
                              controller: titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan judul resep';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            CustomTextFormField(
                              title: 'Deskripsi Resep',
                              hintText: 'Masukkan deskripsi resep',
                              controller: descriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan deskripsi resep';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: ingredientsController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    "Tuliskan bahan-bahan yang anda gunakan",
                                hintStyle: mediumTextStyle,
                              ),
                              maxLines: 5,
                            ),
                            SizedBox(height: 15),
                            ...stepsControllers.map((controller) {
                              int index = stepsControllers.indexOf(controller);
                              return Container(
                                margin: const EdgeInsets.only(top: 7),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        title: 'Langkah ${index + 1}',
                                        hintText: 'Masukkan langkah',
                                        controller: controller,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukkan langkah';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () => _removeStep(index),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: _addStep,
                              child: Text('Tambah Langkah'),
                            ),
                            SizedBox(height: 15),
                            DropdownButtonFormField<String>(
                              value: selectedCategory,
                              hint: Text('Kategori'),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Pilih kategori';
                                }
                                return null;
                              },
                              items: ['Sarapan', 'Makan Siang', 'Makan Malam']
                                  .map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 15),
                            DropdownButtonFormField<String>(
                              value: selectedLevel,
                              hint: Text('Tingkat Kesulitan'),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedLevel = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Pilih tingkat kesulitan';
                                }
                                return null;
                              },
                              items:
                                  ['Mudah', 'Menengah', 'Sulit'].map((level) {
                                return DropdownMenuItem(
                                  value: level,
                                  child: Text(level),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _image == null
                                          ? 'Unggah Gambar'
                                          : 'Gambar Dipilih',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _image == null
                                            ? Colors.grey
                                            : kBlackColor,
                                      ),
                                    ),
                                    Icon(Icons.photo_library,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                            if (_image != null)
                              Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.file(_image!,
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover),
                              ),
                            SizedBox(height: 16),
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : CustomButtonWidget(
                                    title: "Submit",
                                    color: kSecondaryColor,
                                    onTap: _submitForm,
                                    titleColor: kWhiteColor,
                                  ),
                            SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
