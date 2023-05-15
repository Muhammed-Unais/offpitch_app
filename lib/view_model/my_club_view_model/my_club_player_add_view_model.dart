import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/models/add_players_model.dart';
import 'package:offpitch_app/repository/add_players_repository.dart';
import 'package:offpitch_app/utils/utils.dart';

class MyClubPlayerAddViewModel with ChangeNotifier {
  // posted To backend======
  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  // this imageBorder for ui==========
  BoxBorder? border;

  // posted To backend======
  String? docUrl;

  // this for ui==========
  String? _docName;

  // this PDFBorder for ui==========
  BoxBorder? pdfborder;

  ImagePicker imagePicker = ImagePicker();

  String? get docName => _docName;

  bool _plyerAddSaveAndContinue = false;
  bool get plyerAddSaveAndContinue => _plyerAddSaveAndContinue;

  // Add Player textEditing controller and focuesNodes============================

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerDob = TextEditingController();

  FocusNode focusNodeName = FocusNode();

  FocusNode focusNodeDob = FocusNode();

  showDatePickerforDate(context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 01, 01),
      firstDate: DateTime(1983),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controllerDob.text = formattedDate;
    }
  }

  final cloudinary = Cloudinary.signedConfig(
    apiKey: "946723352357176",
    apiSecret: "HUEBHwIULpeCa-5MsrZ0z7xrCsU",
    cloudName: "dvihywo6p",
  );

  setSaveButtonLoading(bool isLoading) {
    _plyerAddSaveAndContinue = isLoading;
    notifyListeners();
  }

  setBorderError(BoxBorder? boxBorder) {
    border = boxBorder;
    notifyListeners();
  }

  setDocName(String docname) {
    _docName = docname;
    notifyListeners();
  }

  setDocBorderError(BoxBorder? border) {
    pdfborder = border;
    notifyListeners();
  }

// Taken image from gallery===========================
  getProfileFromGallery() async {
    final XFile? img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    // Xfile coverted to File=================
    File? porfileImage;
    if (img != null) {
      porfileImage = File(img.path);
      setBorderError(null);

      CloudinaryResponse response = await cloudinary.upload(
        file: porfileImage.path,
        fileBytes: porfileImage.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {
          log('$count/$total');
        },
      );
      if (response.isSuccessful) {
        log("success");
        _imageUrl = response.secureUrl;
        notifyListeners();
        log(imageUrl.toString());
      }
    } else {
      setBorderError(
        Border.all(
          color: Colors.red,
          width: 1,
        ),
      );
    }
  }

  // doc picker from user files picker =====================
  getGovtRegfiles() async {
    final FilePickerResult? doc = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);

    // PlatformFile coverted to File=================
    File? userAgeProofDoc;
    if (doc != null) {
      PlatformFile file = doc.files.first;
      setDocName(file.name);
      setDocBorderError(null);
      userAgeProofDoc = File(file.path!);

      CloudinaryResponse response = await cloudinary.upload(
        file: userAgeProofDoc.path,
        fileBytes: userAgeProofDoc.readAsBytesSync(),
        resourceType: CloudinaryResourceType.auto,
        progressCallback: (count, total) {
          log('$count/$total');
        },
      );
      if (response.isSuccessful) {
        docUrl = response.secureUrl;
      }
    } else {
      setDocBorderError(
        Border.all(
          color: Colors.red,
          width: 1,
        ),
      );
    }
  }

  clearAllData() {
    _imageUrl = null;
    _docName = null;
    controllerName.clear();
    controllerDob.clear();
  }

  // Plyers Adding Api==========================
  final _myaddPlayerRepo = AddPlayerRepository();
  postPlayers(context) async {
    if (_imageUrl != null && _docName != null) {
      final modelData = AddPlayersModel(
        profile: imageUrl,
        doc: docUrl,
        dateOfBirth: controllerDob.text,
        name: controllerName.text,
      );
      setSaveButtonLoading(true);
      // Post Players================================
      _myaddPlayerRepo.postPlayers(modelData).then((value) async {
        setSaveButtonLoading(false);
        clearAllData();

        Map<String, dynamic> sucssesMessage = value;
        Navigator.pop(context);
        Utils.showCustomFlushbar(context, sucssesMessage['message'],
            isError: false);
      }).onError((error, stackTrace) {
        Utils.showCustomFlushbar(context, error.toString());
        setSaveButtonLoading(false);
        log(error.toString());
      });
    }
  }

  clearAllDataLogout() {
    pdfborder = null;
    _docName = null;
    docUrl = null;
    border = null;
    _imageUrl = null;
  }
}
