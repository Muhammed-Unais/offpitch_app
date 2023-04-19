import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offpitch_app/models/create_new_club_model.dart';
import 'package:offpitch_app/repository/create_club_repository.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary/cloudinary.dart';

class CreateNewClubViewModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();

  String? imageUrl;
  String? docUrl;

//  nameTexteditincontroller
  final TextEditingController nameController = TextEditingController();

//  EmailTexteditincontroller
  final TextEditingController emailController = TextEditingController();

//  phoneTexteditincontroller
  final TextEditingController phoneController = TextEditingController();

//  descriptionTexteditincontroller
  final TextEditingController descriptionController = TextEditingController();

// nameFocusNode
  final FocusNode nameFoucsNode = FocusNode();

// EmaiFocusNode
  final FocusNode emailFoucsNode = FocusNode();

// PhoneFocusNode
  final FocusNode phoneFoucusNode = FocusNode();

// descriptionFocusNode
  final FocusNode descriptionFoucusNode = FocusNode();

  final cloudinary = Cloudinary.signedConfig(
      apiKey: "946723352357176",
      apiSecret: "HUEBHwIULpeCa-5MsrZ0z7xrCsU",
      cloudName: "dvihywo6p");

// imagePicker from user gallery
  getImageFromGallery() async {
    final img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    File images = File(img!.path);
    CloudinaryResponse response = await cloudinary.upload(
      file: images.path,
      fileBytes: images.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      progressCallback: (count, total) {
        log('$count/$total');
      },
    );
    if (response.isSuccessful) {
      imageUrl = response.secureUrl;
    }
  }

// doc picker from user files picker
  getGovtRegfiles() async {
    final FilePickerResult? doc = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);

    if (doc != null) {
      PlatformFile file = doc.files.first;
      File docs = File(file.path!);

      CloudinaryResponse response = await cloudinary.upload(
        file: docs.path,
        fileBytes: docs.readAsBytesSync(),
        resourceType: CloudinaryResourceType.auto,
        progressCallback: (count, total) {
          log('$count/$total');
        },
      );
      if (response.isSuccessful) {
        docUrl = response.secureUrl;
      }
    }
  }

  final _myrepo = CreateClubRepository();

  postClubCreate() async {
    if (imageUrl != null && docUrl != null) {
      log("success");
      final value = CreateClubModel(
          doc: docUrl!,
          profile: imageUrl!,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          description: descriptionController.text.trim(),
          phone: phoneController.text.trim());

      _myrepo.postClubapi(value).then((value) {
        log(value.toString());
      }).onError((error, stackTrace) {
        error.toString();
      });
    }
  }

  saveButtonFunc(context) async {
    final userViewModel = Provider.of<UserViewModel>(context,listen: false);
    final authToken = await userViewModel.getUser();
    if (authToken == null || authToken == "") {
      navigateTologin(context);
      return;
    }
    postClubCreate();
  }

  navigateTologin(context) {
    Navigator.pushNamed(context, "login_screen");
  }
}
