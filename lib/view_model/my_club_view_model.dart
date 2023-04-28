import 'dart:developer';
import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/club_tournamentmodel.dart';
import 'package:offpitch_app/models/players_model.dart';
import 'package:offpitch_app/repository/club_repository.dart';

class MyClubViewModel extends ChangeNotifier {
  final _myRepo = ClubRepository();
  int count = 0;
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  File? _images;
  BoxBorder? border;
  String? docUrl;
  String? _docName;

  get images => _images;
  get docName => _docName;

// get All club=====================
  ApiResponse<ClubTournamentModel> apiResponse = ApiResponse.loading();

  setMyClubdetails(ApiResponse<ClubTournamentModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future getMyClub() async {
    setMyClubdetails(ApiResponse.loading());
    _myRepo.getAllClubWithAccessTokem().then((value) {
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

  getAllPlayers() async {
    setAllPlayerslist(ApiResponse.loading());
    _myRepo.getAllPlayerWithAccessToken().then(
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

  setImages(File? image) {
    _images = image;
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

  getProfileFromGallery() async {
    final XFile? img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    File? images;
    if (img != null) {
      images = File(img.path);
      setBorderError(null);
      setImages(images);
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

  // doc picker from user files picker
  getGovtRegfiles() async {
    final FilePickerResult? doc = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);

    if (doc != null) {
      PlatformFile file = doc.files.first;
      setDocName(file.name);
      File files = File(file.path!);

      CloudinaryResponse response = await cloudinary.upload(
        file: files.path,
        fileBytes: files.readAsBytesSync(),
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


  

  

  

  MyClubViewModel() {
    getMyClub();
    getAllPlayers();
  }
}
