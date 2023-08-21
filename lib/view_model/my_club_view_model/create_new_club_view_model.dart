import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offpitch_app/models/create_new_club_model.dart';
import 'package:offpitch_app/repository/create_club_repository.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary/cloudinary.dart';

class CreateNewClubViewModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();

  MyClubViewModel myClubViewModel = MyClubViewModel();

  // imageUrl
  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  bool _isClubCreated = false;
  bool get isClubCreate => _isClubCreated;

  // Docment url
  String? _docUrl;

  // Doc name for ui
  String? _docName;
  String? get docname => _docName;

  // loading show in save and update button
  bool _updateIsLoding = false;
  bool get updateIsLoading => _updateIsLoding;

  BoxBorder? _imageErroBorder;
  BoxBorder? get imageErrorBorder => _imageErroBorder;

  BoxBorder? _docErroBorder;
  BoxBorder? get docErrorBorder => _docErroBorder;

  // create or update variable==========
  bool isCreate = true;

  // postClub successmessge===========
  Map<String, dynamic>? succesMessage;

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

// instance of repository
  final _myrepo = CreateClubRepository();

  void setOptions(bool isCreates) {
    isCreate = isCreates;
    notifyListeners();
  }

  void setUpdateisLoding(bool upadateisLoading) {
    _updateIsLoding = upadateisLoading;
    notifyListeners();
  }

  void setDocName(String? docName) {
    _docName = docName;
    notifyListeners();
  }

  void setImageErrorBorder(BoxBorder? border) {
    _imageErroBorder = border;
    notifyListeners();
  }

  void setDocErrorBorder(BoxBorder? border) {
    _docErroBorder = border;
    notifyListeners();
  }

  CreateClubModel setClubCreatingData() {
    final createClubModelData = CreateClubModel(
        doc: isCreate ? _docUrl : null,
        profile: _imageUrl,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        description: descriptionController.text.trim(),
        phone: phoneController.text.trim());
    return createClubModelData;
  }

  void setNavigationAndDisplayMessage(BuildContext context, dynamic values) {
    if (isCreate) {
      succesMessage = values;
      _isClubCreated = succesMessage?["success"];
      notifyListeners();
      Navigator.pushReplacementNamed(
        context,
        RoutesName.navigation,
      );
      Utils.showCustomFlushbar(context, succesMessage?['message'] ?? "",
          isError: false);
    }
  }

  final cloudinary = Cloudinary.signedConfig(
      apiKey: "946723352357176",
      apiSecret: "HUEBHwIULpeCa-5MsrZ0z7xrCsU",
      cloudName: "dvihywo6p");

// imagePicker from user gallery
  void getImageFromGallery() async {
    final img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (img != null) {
      File images = File(img.path);
      CloudinaryResponse response = await cloudinary.upload(
        file: images.path,
        fileBytes: images.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {
          log('$count/$total');
        },
      );
      if (response.isSuccessful) {
        _imageUrl = response.secureUrl;
        setImageErrorBorder(null);
        notifyListeners();
      }
    } else {
      setImageErrorBorder(
        Border.all(color: Colors.red),
      );
    }
  }

// doc picker from user files picker
  void getGovtRegfiles() async {
    final FilePickerResult? doc = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    File? clubGoveCert;
    if (doc != null) {
      PlatformFile file = doc.files.first;
      setDocName(file.name);
      setDocErrorBorder(null);
      clubGoveCert = File(file.path!);
      CloudinaryResponse response = await cloudinary.upload(
        file: clubGoveCert.path,
        fileBytes: clubGoveCert.readAsBytesSync(),
        resourceType: CloudinaryResourceType.auto,
        progressCallback: (count, total) {},
      );
      if (response.isSuccessful) {
        _docUrl = response.secureUrl;
        setDocErrorBorder(
          Border.all(color: Colors.red),
        );
        notifyListeners();
      }
    }
  }

  Future<bool> postClubCreate(context) async {
    setUpdateisLoding(true);
    bool isSuccuess = false;

    if (_imageUrl != null || _docUrl != null) {
      final createClubModelData = setClubCreatingData();

      await _myrepo.postClubapi(createClubModelData).then((value) async {
        isSuccuess = true;

        await myClubViewModel.getMyClub(context);
        
        setUpdateisLoding(false);

        setNavigationAndDisplayMessage(context, value);

      }).onError((error, stackTrace) {
        Utils.showCustomFlushbar(context, error.toString());
        setUpdateisLoding(false);
        isSuccuess = false;
      });
    }
    return isSuccuess;
  }

  Future<void> saveButtonFunc(context) async {
    final userViewModel = UserViewModel();
    final authToken = await userViewModel.getUser();

    if (authToken == null || authToken.isEmpty) {
      await navigateTologin(context);
      return;
    }
    await postClubCreate(context);
  }

  Future navigateTologin(context) async {
    await Navigator.pushNamed(context, RoutesName.login);
  }

  // Creating page using for Updating UI===========================
  void editValueAssaignFunc(context) async {
    final userViewModel = Provider.of<MyClubViewModel>(context, listen: false);
    _imageUrl = userViewModel.apiResponse.data!.data!.profile;
    nameController.text = userViewModel.apiResponse.data!.data!.name!;
    emailController.text = userViewModel.apiResponse.data!.data!.email!;
    phoneController.text =
        userViewModel.apiResponse.data!.data!.phone.toString();
    descriptionController.text =
        userViewModel.apiResponse.data!.data!.description!;

    notifyListeners();
  }

  Future<void> updateFunc(context) async {
    final isSuccess = await postClubCreate(context);
    if (isSuccess) {
      Utils.showCustomFlushbar(context, succesMessage?['message'],
          isError: false);
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);
    }
  }

  void clearAllDataLogout() {
    _imageUrl = null;
    _docUrl = null;
    succesMessage = null;
    _docErroBorder = null;
    _imageErroBorder = null;
    _docName = null;
  }
}
