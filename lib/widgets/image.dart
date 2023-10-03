
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  final TextEditingController imageController;
  final String text;
  const ImagePick(
      {super.key, required this.imageController, required this.text});

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  @override
  Widget build(BuildContext context) {
    Future _pickImageCam() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600,
      );
      if (pickedFile != null) {
        return pickedFile.path;
      }
      return null;
    }

    Future _pickImageGal() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );
      if (pickedFile != null) {
        return pickedFile.path;
      }
      return null;
    }

    Widget? imgPicker(String? image) {
      if (image == null || image == '') {
        return DottedBorder(
          color: Colors.grey,
          dashPattern: const [7, 3],
          strokeWidth: 1.5,
          child: SizedBox(
            height: 100,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    Icons.camera_alt,
                    color: fromCssColor('#034DA3'),
                    size: 24,
                    semanticLabel: 'Take photo',
                  ),
                  Text(
                    'Aucune fichier télécharger',
                    style:
                        TextStyle(fontSize: 16, color: fromCssColor('#034DA3')),
                  ),
                  Text('Appuyer ici pour télécharger une image',
                      style: TextStyle(
                          fontSize: 13, color: fromCssColor('#034DA3')))
                ],
              ),
            ),
          ),
        );
      }
      return Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: fromCssColor('#034DA3')),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                color: fromCssColor('#034DA3'),
                size: 30,
              ),
              Text(
                'Fichier enregistrer',
                style: TextStyle(
                  color: fromCssColor('#034DA3'),
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      );
    }

    void showImagePicker(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Card(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5.2,
                  margin: const EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                        child: const Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Gallery",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                        onTap: () {
                          _pickImageGal().then((file) {
                            setState(() {
                              setState(() {
                                widget.imageController.text = file;
                              });
                            });
                          });
                          Navigator.pop(context);
                        },
                      )),
                      Expanded(
                          child: InkWell(
                        child: const SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 60.0,
                              ),
                              SizedBox(height: 12.0),
                              Text(
                                "Camera",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _pickImageCam().then((file) {
                            setState(() {
                              widget.imageController.text = file;
                            });
                            print(widget.imageController.text);
                          });
                          Navigator.pop(context);
                        },
                      ))
                    ],
                  )),
            );
          });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600]),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    showImagePicker(context);
                  },
                  child: imgPicker(widget.imageController.text)),
            ),
          ],
        ),
      ],
    );
  }
}
