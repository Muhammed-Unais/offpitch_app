import 'dart:developer';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/models/create_tournament_model.dart';
import 'package:offpitch_app/repository/create_tournament_repository.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';

class CreateTournamentViewModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  File? _images;
  BoxBorder? border;
  bool? ischeck = false;
  bool? isCheckTourType1 = false;
  bool? isCheckTourType2 = false;
  bool? isCheckTourType3 = false;

  get images => _images;

  //  nameTexteditincontroller
  final TextEditingController dateController = TextEditingController();

//  EmailTexteditincontroller
  final TextEditingController locationController = TextEditingController();

//  phoneTexteditincontroller
  final TextEditingController titleTorurnamentController =
      TextEditingController();

//  descriptionTexteditincontroller
  final TextEditingController descriptionController = TextEditingController();

//  aboutTexteditincontroller
  final TextEditingController aboutController = TextEditingController();

  //  InstructionTexteditincontroller
  final TextEditingController instructionController = TextEditingController();

//  Max No ofRegistrationTexteditincontroller
  final TextEditingController noOfRegistrationController =
      TextEditingController();

//  LastDateeditincontroller
  final TextEditingController lastDateTorurnamentController =
      TextEditingController();

//  MinNoOfPlayersTexteditincontroller
  final TextEditingController minOfPlayersController = TextEditingController();

//  MaxNoOfPlayersTexteditincontroller
  final TextEditingController maxOfPlayersController = TextEditingController();

//  amountTexteditincontroller
  final TextEditingController amountController = TextEditingController();

// nameFocusNode
  final FocusNode dateFoucsNode = FocusNode();

// EmaiFocusNode
  final FocusNode locationFoucsNode = FocusNode();

// PhoneFocusNode
  final FocusNode titleFoucusNode = FocusNode();

// descriptionFocusNode
  final FocusNode descriptionFoucusNode = FocusNode();

// descriptionFocusNode
  final FocusNode aboutFoucusNode = FocusNode();

// nameFocusNode
  final FocusNode instructionFoucsNode = FocusNode();

// EmaiFocusNode
  final FocusNode maxNoOfRegFoucsNode = FocusNode();

// PhoneFocusNode
  final FocusNode lastDateRegusNode = FocusNode();

// descriptionFocusNode
  final FocusNode minOfPlayersFoucusNode = FocusNode();

// descriptionFocusNode
  final FocusNode maxOfPlayersFoucusNode = FocusNode();

// descriptionFocusNode
  final FocusNode amountFoucusNode = FocusNode();

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

  setAmountCheck(bool? value) {
    ischeck = value;
    notifyListeners();
  }

  setIsCheckTourTypeOne(bool? value) {
    isCheckTourType1 = value;
    if (isCheckTourType1!) {
      isCheckTourType2 = !isCheckTourType1!;
      isCheckTourType3 = !isCheckTourType1!;
    }
    notifyListeners();
  }

  setIsCheckTourTypeTwo(bool? value) {
    isCheckTourType2 = value;
    if (isCheckTourType2!) {
      isCheckTourType1 = !isCheckTourType2!;
      isCheckTourType3 = !isCheckTourType2!;
    }
    notifyListeners();
  }

  setIsCheckTourTypeThree(bool? value) {
    isCheckTourType3 = value;
    if (isCheckTourType3!) {
      isCheckTourType1 = !isCheckTourType3!;
      isCheckTourType2 = !isCheckTourType3!;
    }
    notifyListeners();
  }

// imagePicker from user gallery
  getImageFromGallery() async {
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

  // date picker from textfield
  datePickerinTextfield(context, {isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      if (isStartDate) {
        dateController.text = formattedDate;
      } else {
        lastDateTorurnamentController.text = formattedDate;
      }
    } else {}
  }

  String? tournmentType() {
    if (isCheckTourType1!) {
      return "t1";
    }
    if (isCheckTourType2!) {
      return "t2";
    }
    if (isCheckTourType3!) {
      return "t1";
    }
    return null;
  }

  final _myRepo = CreateTournamentRepository();

  submitButtonTourCreate(context) async {
    if (aboutController.text.isEmpty) {
      amountController.text = 0.toString();
    }
    final value = CreateTournament(
      cover: imageUrl,
      startDate: dateController.text.trim(),
      location: locationController.text.trim(),
      title: titleTorurnamentController.text.trim(),
      shortDescription: descriptionController.text.trim(),
      description: aboutController.text.trim(),
      instruction: instructionController.text.trim(),
      noTeams: int.parse(noOfRegistrationController.text.trim()),
      minNoPlayers: int.parse(minOfPlayersController.text.trim()),
      maxNoPlayers: int.parse(maxOfPlayersController.text.trim()),
      ticket: Ticket(ticketIs: false, amount: 0, total: 0),
      registration: Registration(
        fee: Fee(
            feeIs: ischeck, amount: int.parse(amountController.text.trim())),
        lastDate: lastDateTorurnamentController.text.trim(),
      ),
      tournamentType: tournmentType(),
      step: 4,
    );

    _myRepo.putTournamentapi(value).then((value) {
      log(value.toString());
      Navigator.pushReplacementNamed(context, RoutesName.explore);
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
