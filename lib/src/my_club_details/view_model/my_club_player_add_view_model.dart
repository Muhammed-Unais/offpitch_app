import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/src/my_club_details/model/add_players_model.dart';
import 'package:offpitch_app/src/my_club_details/repository/add_players_repository.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../../res/styles/app_theme.dart';
import 'my_club_over_view_model.dart';

class MyClubPlayerAddViewModel with ChangeNotifier {
  String? _imageUrl;

  BoxBorder? border;

  String? docUrl;

  String? _docName;

  BoxBorder? pdfborder;

  ImagePicker imagePicker = ImagePicker();

  File? _profileImageCover;

  File? get profileImageCover => _profileImageCover;

  String? get docName => _docName;

  bool _plyerAddSaveAndContinue = false;

  bool get plyerAddSaveAndContinue => _plyerAddSaveAndContinue;

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerDob = TextEditingController();

  FocusNode focusNodeName = FocusNode();

  FocusNode focusNodeDob = FocusNode();

  Future<void> showDatePickerforDate(context) async {
    final pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: const TextTheme(),
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
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

  var cloudinary = Cloudinary.signedConfig(
    apiKey: "946723352357176",
    apiSecret: "HUEBHwIULpeCa-5MsrZ0z7xrCsU",
    cloudName: "dvihywo6p",
  );

  void setSaveButtonLoading(bool isLoading) {
    _plyerAddSaveAndContinue = isLoading;
    notifyListeners();
  }

  void setBorderError(BoxBorder? boxBorder) {
    border = boxBorder;
    notifyListeners();
  }

  void setDocName(String docname) {
    _docName = docname;
    notifyListeners();
  }

  void setDocBorderError(BoxBorder? border) {
    pdfborder = border;
    notifyListeners();
  }

  Future<void> getProfileFromGallery() async {
    final XFile? img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (img != null) {
      _profileImageCover = File(img.path);
      setBorderError(null);

      CloudinaryResponse response = await cloudinary.upload(
        file: _profileImageCover?.path,
        fileBytes: _profileImageCover?.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {},
      );
      if (response.isSuccessful) {
        _imageUrl = response.secureUrl;
        notifyListeners();
      }
    } else {
      setBorderError(
        Border.all(color: Colors.red, width: 1),
      );
    }
  }

  Future<void> getGovtRegfiles() async {
    final FilePickerResult? doc = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
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
        progressCallback: (count, total) {},
      );
      if (response.isSuccessful) {
        docUrl = response.secureUrl;
      }
    } else {
      setDocBorderError(
        Border.all(color: Colors.red, width: 1),
      );
    }
  }

  final _myaddPlayerRepo = AddPlayerRepository();
  Future<void> postPlayers(BuildContext context) async {
    if (_imageUrl != null && _docName != null) {
      final modelData = AddPlayersModel(
        profile: _imageUrl,
        doc: docUrl,
        dateOfBirth: controllerDob.text,
        name: controllerName.text,
      );

      setSaveButtonLoading(true);

      _myaddPlayerRepo.postPlayers(modelData).then((value) async {
        setSaveButtonLoading(false);
        context.read<MyClubViewModel>().getAllPlayers();
        Navigator.pop(context);
        Utils.showCustomFlushbar(context, "New Player added", isError: false);
      }).onError((error, stackTrace) {
        Utils.showCustomFlushbar(context, error.toString());
        setSaveButtonLoading(false);
      });
    }
  }

  @override
  void dispose() {
    focusNodeDob.dispose();
    focusNodeName.dispose();
    controllerDob.dispose();
    controllerName.dispose();
    super.dispose();
  }
}
