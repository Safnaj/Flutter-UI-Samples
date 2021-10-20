import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quizdeck/models/flash_card_model.dart';
import 'package:quizdeck/provider/flash_card_provider.dart';

import 'package:quizdeck/widgets/flash_card_widget.dart';

class AddFlashCardScreen extends StatefulWidget {
  AddFlashCardScreen({Key? key}) : super(key: key);
  static const String routeName = "add-flash-card-screen";

  @override
  _AddFlashCardScreenState createState() => _AddFlashCardScreenState();
}

class _AddFlashCardScreenState extends State<AddFlashCardScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _frontSide = TextEditingController();

  final _backSide = TextEditingController();
  File? _frontSideImage;
  File? _backSideImage;

  final StreamController<FlashCardModel> flashCard =
      StreamController<FlashCardModel>();
  @override
  void dispose() {
    super.dispose();
    flashCard.close();
    _frontSide.dispose();
    _backSide.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate =
        (ModalRoute.of(context)!.settings.arguments as Map)["isUpdate"];

    final data = (ModalRoute.of(context)!.settings.arguments as Map)["data"];
    if (isUpdate) {
      _frontSide.text = data.frontSide;
      _backSide.text = data.backSide;
      if (data.frontSideImage != null) {
        _frontSideImage = File(data.frontSideImage);
      }
      if (data.backSideImage != null) {
        _backSideImage = File(data.backSideImage);
      }
    }

    _frontSide.addListener(() {
      flashCard.sink.add(FlashCardModel(
          backSide: _backSide.text,
          deckId: isUpdate ? data.deckId : data.toString(),
          frontSideImage: _frontSideImage?.path,
          backSideImage: _backSideImage?.path,
          frontSide: _frontSide.text,
          id: isUpdate ? data.id : "1ch3"));
    });
    _backSide.addListener(() {
      flashCard.sink.add(FlashCardModel(
          backSide: _backSide.text,
          deckId: isUpdate ? data.deckId : data.toString(),
          frontSideImage: _frontSideImage?.path,
          backSideImage: _backSideImage?.path,
          frontSide: _frontSide.text,
          id: isUpdate ? data.id : "1ch3"));
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "${isUpdate ? 'Update Flash Card' : 'Add Flash Card'}",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                StreamBuilder(
                    initialData: isUpdate
                        ? data as FlashCardModel
                        : FlashCardModel(
                            backSide: "answer",
                            deckId: isUpdate ? data.deckId : data.toString(),
                            frontSide: "question",
                            id: "xbdfgr"),
                    stream: flashCard.stream,
                    builder: (ctx, AsyncSnapshot<FlashCardModel> snapshot) {
                      return FlashCardWidget(
                          layout: FlashCardLayout.LANDSCAPE,
                          flashCard: snapshot.data!);
                    }),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AddFlashCardTextField(
                          isEnd: false,
                          labelText: "Front Side",
                          onImageSelected: () async {
                            final XFile? imageFile = await ImagePicker()
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100);
                            final File? croppedFile =
                                await ImageCropper.cropImage(
                                    compressQuality: 100,
                                    sourcePath: imageFile!.path,
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square,
                                      CropAspectRatioPreset.ratio3x2,
                                      CropAspectRatioPreset.original,
                                      CropAspectRatioPreset.ratio4x3,
                                      CropAspectRatioPreset.ratio16x9
                                    ],
                                    androidUiSettings: AndroidUiSettings(
                                        toolbarTitle: 'Cropper',
                                        toolbarColor:
                                            Theme.of(context).accentColor,
                                        toolbarWidgetColor: Colors.white,
                                        initAspectRatio:
                                            CropAspectRatioPreset.original,
                                        lockAspectRatio: false),
                                    iosUiSettings: IOSUiSettings(
                                      minimumAspectRatio: 1.0,
                                    ));

                            final File obtainedFile =
                                croppedFile ?? File(imageFile.path);
                            _frontSideImage = obtainedFile;
                            flashCard.sink.add(FlashCardModel(
                                backSide: _backSide.text,
                                deckId:
                                    isUpdate ? data.deckId : data.toString(),
                                frontSideImage: _frontSideImage?.path,
                                backSideImage: _backSideImage?.path,
                                frontSide: _frontSide.text,
                                id: "sdfsdfsf"));
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return "Enter a Valid input";
                          },
                          hintText: "Front Side",
                          textEditingController: _frontSide),
                      AddFlashCardTextField(
                          labelText: "Back Side",
                          isEnd: true,
                          onImageSelected: () async {
                            final XFile? imageFile = await ImagePicker()
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100);
                            final File? croppedFile =
                                await ImageCropper.cropImage(
                                    compressQuality: 100,
                                    sourcePath: imageFile!.path,
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square,
                                      CropAspectRatioPreset.ratio3x2,
                                      CropAspectRatioPreset.original,
                                      CropAspectRatioPreset.ratio4x3,
                                      CropAspectRatioPreset.ratio16x9
                                    ],
                                    androidUiSettings: AndroidUiSettings(
                                        toolbarTitle: 'Cropper',
                                        toolbarColor:
                                            Theme.of(context).accentColor,
                                        toolbarWidgetColor: Colors.white,
                                        initAspectRatio:
                                            CropAspectRatioPreset.original,
                                        lockAspectRatio: false),
                                    iosUiSettings: IOSUiSettings(
                                      minimumAspectRatio: 1.0,
                                    ));

                            final File obtainedFile =
                                croppedFile ?? File(imageFile.path);
                            _backSideImage = obtainedFile;
                            flashCard.sink.add(FlashCardModel(
                                backSide: _backSide.text,
                                deckId:
                                    isUpdate ? data.deckId : data.toString(),
                                frontSideImage: _frontSideImage?.path,
                                backSideImage: _backSideImage?.path,
                                frontSide: _frontSide.text,
                                id: "sdfsdfsf"));
                          },
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              return null;
                            }
                            return "Enter a Valid input";
                          },
                          hintText: "Back Side",
                          textEditingController: _backSide),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(100),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!isUpdate) {
                          await context.read<FlashCardProvider>().addFlashCard(
                                frontSide: _frontSide.text,
                                backSide: _backSide.text,
                                frontSideImage: _frontSideImage?.path,
                                backSideImage: _backSideImage?.path,
                                deckId:
                                    isUpdate ? data.deckId : data.toString(),
                              );
                        } else {
                          await context
                              .read<FlashCardProvider>()
                              .updateFlashCard(
                                flashCard: FlashCardModel(
                                    backSide: _backSide.text,
                                    deckId: data.deckId,
                                    frontSide: _frontSide.text,
                                    frontSideImage: _frontSideImage?.path,
                                    backSideImage: _backSideImage?.path,
                                    id: data.id),
                              );
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.bold),
                        )),
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

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          borderRadius: BorderRadius.circular(15),
          color: Colors.orange,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AddFlashCardTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  final bool isEnd;
  final Function onImageSelected;

  final bool obscureText;
  final String? Function(String?) validator;
  final String? labelText;
  const AddFlashCardTextField({
    required this.isEnd,
    required this.validator,
    required this.onImageSelected,
    this.obscureText = false,
    required this.hintText,
    required this.labelText,
    required this.textEditingController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: TextFormField(
        maxLength: 100,
        validator: validator,
        obscureText: obscureText,
        controller: textEditingController,
        style: TextStyle(fontFamily: "roboto", fontWeight: FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          counterStyle: Theme.of(context).textTheme.bodyText1,
          suffixIcon: GestureDetector(
              onTap: () => onImageSelected(),
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).primaryColor,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 2),
          ),
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          hintStyle: Theme.of(context).textTheme.bodyText1,
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
