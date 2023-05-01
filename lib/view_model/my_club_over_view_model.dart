import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/add_players_model.dart';
import 'package:offpitch_app/models/club_tournamentmodel.dart';
import 'package:offpitch_app/models/players_model.dart';
import 'package:offpitch_app/repository/add_players_repository.dart';
import 'package:offpitch_app/repository/club_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClubViewModel extends ChangeNotifier {
  final _myRepo = ClubRepository();
  int count = 0;
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  File? _profileImagesforUi;
  BoxBorder? border;
  String? docUrl;
  String? _docName;
  File? porfileImage;
  File? userAgeProofDoc;

  get images => _profileImagesforUi;
  get docName => _docName;

// get All club=====================
  ApiResponse<ClubTournamentModel> apiResponse = ApiResponse.loading();

  setMyClubdetails(ApiResponse<ClubTournamentModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future getMyClub() async {

    setMyClubdetails(ApiResponse.loading());
    _myRepo.getAllClubWithAccessTokem().then((value) async {

      // stored my club id in local storage===============
      final sp = await SharedPreferences.getInstance();
      final String myClubId = value.data!.id!;
      sp.setString('myClubId', myClubId);

      setMyClubdetails(ApiResponse.completed(value));

    }).onError((error, stackTrace) {
      setMyClubdetails(ApiResponse.error(error.toString()));
    });
  }

// get all players====================
  ApiResponse<PlayersModel> getPlayerapiResponse = ApiResponse.loading();

  setAllPlayerslist(ApiResponse<PlayersModel> response) {
    getPlayerapiResponse = response;
    notifyListeners();
  }

  Future getAllPlayers() async {
    setAllPlayerslist(ApiResponse.loading());
    await _myRepo.getAllPlayerWithAccessToken().then(
      (value) {
        log("suscess");
        setAllPlayerslist(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
        setAllPlayerslist(ApiResponse.error(error.toString()));
      },
    );
  }

// Add Player textEditing controller and focuesNodes

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
      cloudName: "dvihywo6p");

  setProfileImages(File? image) {
    _profileImagesforUi = image;
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

// Taken image from gallery===========================
  getProfileFromGallery() async {
    final XFile? img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (img != null) {
      porfileImage = File(img.path);
      setBorderError(null);
      setProfileImages(porfileImage);
      CloudinaryResponse response = await cloudinary.upload(
        file: images.path,
        fileBytes: images.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {
          log('$count/$total');
        },
      );
      if (response.isSuccessful) {
        log("success");
        imageUrl = response.secureUrl;
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

    if (doc != null) {
      PlatformFile file = doc.files.first;
      setDocName(file.name);
      userAgeProofDoc = File(file.path!);

      CloudinaryResponse response = await cloudinary.upload(
        file: userAgeProofDoc!.path,
        fileBytes: userAgeProofDoc!.readAsBytesSync(),
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

  clearAllData() {
    _profileImagesforUi = null;
    _docName = null;
    controllerName.clear();
    controllerDob.clear();
  }

  final _myaddPlayerRepo = AddPlayerRepository();

  postPlayers(context) async {
    if (imageUrl != null && _docName != null) {
      final modelData = AddPlayersModel(
          profile: imageUrl,
          doc: _docName,
          dateOfBirth: controllerDob.text,
          name: controllerName.text);
      _myaddPlayerRepo.postPlayers(modelData).then((value) async {
        log(value.toString());
        clearAllData();
        await getAllPlayers();
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        log(error.toString());
      });
    }
  }

  MyClubViewModel() {
    getMyClub();
    getAllPlayers();
  }
}
