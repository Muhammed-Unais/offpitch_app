import 'dart:io';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/features/create_tournament_view/model/create_tournament_model.dart';
import 'package:offpitch_app/features/create_tournament_view/repository/create_tournament_repository.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:provider/provider.dart';

class CreateTournamentViewModel extends ChangeNotifier {
  ImagePicker imagePicker = ImagePicker();
  String? imageUrl;
  File? _images;
  BoxBorder? _border;
  bool? ischeck = false;
  bool? isCheckTourType1 = false;
  bool? isCheckTourType2 = false;
  bool? isCheckTourType3 = false;
  bool? isLoading = false;

  BoxBorder? get border => _border;
  File? get images => _images;

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

  void setLoadingCreation(bool? value) {
    isLoading = value;
    notifyListeners();
  }

  final cloudinary = Cloudinary.signedConfig(
      apiKey: "946723352357176",
      apiSecret: "HUEBHwIULpeCa-5MsrZ0z7xrCsU",
      cloudName: "dvihywo6p");

  void setImages(File? image) {
    _images = image;
    notifyListeners();
  }

  void setBorderError(BoxBorder? boxBorder) {
    _border = boxBorder;
    notifyListeners();
  }

  void setAmountCheck(bool? value) {
    ischeck = value;
    notifyListeners();
  }

  void setIsCheckTourTypeOne(bool? value) {
    isCheckTourType1 = value;
    if (isCheckTourType1!) {
      isCheckTourType2 = !isCheckTourType1!;
      isCheckTourType3 = !isCheckTourType1!;
    }
    notifyListeners();
  }

  void setIsCheckTourTypeTwo(bool? value) {
    isCheckTourType2 = value;
    if (isCheckTourType2!) {
      isCheckTourType1 = !isCheckTourType2!;
      isCheckTourType3 = !isCheckTourType2!;
    }
    notifyListeners();
  }

  void setIsCheckTourTypeThree(bool? value) {
    isCheckTourType3 = value;
    if (isCheckTourType3!) {
      isCheckTourType1 = !isCheckTourType3!;
      isCheckTourType2 = !isCheckTourType3!;
    }
    notifyListeners();
  }

// imagePicker from user gallery
  Future<void> getImageFromGallery() async {
    final XFile? img = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (img != null) {
      var images = File(img.path);
      setBorderError(null);
      setImages(images);
      var response = await cloudinary.upload(
        file: images.path,
        fileBytes: images.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {},
      );
      if (response.isSuccessful) {
        imageUrl = response.secureUrl;
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
  Future<void> datePickerinTextfield(context, {isStartDate = true}) async {
    DateTime? pickedDate = await showDatePicker(
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

  CreateTournament tournamentCreationUserInPut() {
    return CreateTournament(
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
            feeIs: ischeck,
            amount: ischeck! ? int.parse(amountController.text.trim()) : 0),
        lastDate: lastDateTorurnamentController.text.trim(),
      ),
      tournamentType: tournmentType(),
      step: 4,
    );
  }

  Future<void> submitButtonTournamentCreate(BuildContext context) async {
    setLoadingCreation(true);

    var createTournamentModel = tournamentCreationUserInPut();
    _myRepo.putTournamentapi(createTournamentModel).then((value) async {
      Map<String, dynamic> values = value;

      Utils.showCustomFlushbar(context, values['message'], isError: false);

      context
          .read<ExploreViewViewModel>()
          .getExpAndSrchTournmts(query: 'filter=all', sortingQuery: "all");

      context
          .read<ExploreViewViewModel>()
          .getExpAndSrchTournmts(query: 'filter=all', sortingQuery: "upcoming");    

      context
          .read<UserHostRegTournamentViewModel>()
          .getAllUserHostedTournaments();

      setLoadingCreation(false);

      clearAlldata();
    }).onError((error, stackTrace) {
      setLoadingCreation(false);
      Utils.showCustomFlushbar(context, error.toString());
    });
  }

  void clearAlldata() {
    amountController.clear();
    maxOfPlayersController.clear();
    minOfPlayersController.clear();
    lastDateTorurnamentController.clear();
    noOfRegistrationController.clear();
    instructionController.clear();
    aboutController.clear();
    descriptionController.clear();
    titleTorurnamentController.clear();
    locationController.clear();
    dateController.clear();
    ischeck = false;
    isCheckTourType1 = false;
    isCheckTourType2 = false;
    isCheckTourType3 = false;
    _images = null;
    _border = null;
  }

  void disposeAllData() {
    amountController.dispose();
    maxOfPlayersController.dispose();
    minOfPlayersController.dispose();
    lastDateTorurnamentController.dispose();
    noOfRegistrationController.dispose();
    instructionController.dispose();
    aboutController.dispose();
    descriptionController.dispose();
    titleTorurnamentController.dispose();
    locationController.dispose();
    dateController.dispose();
    aboutFoucusNode.dispose();
    amountFoucusNode.dispose();
    maxOfPlayersFoucusNode.dispose();
    minOfPlayersFoucusNode.dispose();
    lastDateRegusNode.dispose();
    maxNoOfRegFoucsNode.dispose();
    instructionFoucsNode.dispose();
    descriptionFoucusNode.dispose();
    titleFoucusNode.dispose();
    locationFoucsNode.dispose();
    dateFoucsNode.dispose();
  }

  @override
  void dispose() {
    disposeAllData();
    super.dispose();
  }
}
