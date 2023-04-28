import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offpitch_app/models/create_new_club_model.dart';
import 'package:offpitch_app/repository/create_club_repository.dart';
import 'package:offpitch_app/view_model/my_club_view_model.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary/cloudinary.dart';

class CreateNewClubViewModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();

  String? imageUrl;
  String? docUrl;
  String? clubImage;

  bool isCreate = true;

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

  setOptions(bool isCreates) {
    isCreate = isCreates;
    notifyListeners();
  }

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

      CloudinaryResponse response = await cloudinary.upload(
        file: file.path,
        fileBytes: file.bytes,
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

  Future<bool> postClubCreate(context) async {
    bool just = false;
    if (imageUrl != null || docUrl != null) {
      log("success");
      final value = CreateClubModel(
          doc: isCreate ? docUrl! : null,
          profile: imageUrl!,
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          description: descriptionController.text.trim(),
          phone: phoneController.text.trim());

      await _myrepo.postClubapi(value).then((value) async{
        log("kkkkk");
        just = true;
        log(value.toString());
        await Provider.of<MyClubViewModel>(context, listen: false).getMyClub();
        isCreate ? Navigator.pop(context) : null;
      }).onError((error, stackTrace) {
        log("fhhhh");
        just = false;
        error.toString();
      });
    }
    return just;
  }

  saveButtonFunc(context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final authToken = await userViewModel.getUser();
    if (authToken == null || authToken == "") {
      await navigateTologin(context);
      return;
    }
    postClubCreate(context);
  }

  Future navigateTologin(context) async {
    await Navigator.pushNamed(context, "login_screen");
  }

  editValueAssaignFunc(context) async {
    final userViewModel = Provider.of<MyClubViewModel>(context, listen: false);
    clubImage = userViewModel.apiResponse.data!.data!.profile;
    nameController.text = userViewModel.apiResponse.data!.data!.name!;
    emailController.text = userViewModel.apiResponse.data!.data!.email!;
    phoneController.text =
        userViewModel.apiResponse.data!.data!.phone.toString();
    descriptionController.text =
        userViewModel.apiResponse.data!.data!.description!;
    notifyListeners();
  }

  updateFunc(context) async {
    log("hhhhh");
    final isSuccess = await postClubCreate(context);
    log(isSuccess.toString());
    if (isSuccess) {
      await Provider.of<MyClubViewModel>(context, listen: false).getMyClub();
      Navigator.pop(context);
    }
  }
}
