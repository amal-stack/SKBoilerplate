import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';

/// Maps backend question IDs to domain model [AssessmentQuestion] objects.
/// The backend returns questions as a flat array, but they are organized
/// across different screens in the UI with varying formats and groupings.
abstract final class QuestionnaireStore {
  // Basic Functionality Questions
  static const AssessmentQuestion makeReceiveCalls = AssessmentQuestion(
    id: 'Q1',
    text: 'Are you able to make and receive calls?',
  );

  static const AssessmentQuestion touchScreenWorking = AssessmentQuestion(
    id: 'Q2',
    text: 'Is the touch screen working?',
  );

  static const AssessmentQuestion screenOriginal = AssessmentQuestion(
    id: 'Q3',
    text: 'Is your phone\'s screen original?',
  );

  static const AssessmentQuestion deviceUnderWarranty = AssessmentQuestion(
    id: 'Q4',
    text: 'Is the device under warranty?',
  );

  static const AssessmentQuestion gstBillWithImei = AssessmentQuestion(
    id: 'Q5',
    text: 'Do you have a GST bill with the same IMEI?',
  );

  static const AssessmentQuestion esimsSupported = AssessmentQuestion(
    id: 'Q6',
    text: 'How many eSIMs are supported?',
  );

  // General Condition Categories
  static const AssessmentQuestion cracksOrScratchOnScreen = AssessmentQuestion(
    id: 'Q7',
    text: 'Cracks/scratch on device screen',
  );

  static const AssessmentQuestion displayDefects = AssessmentQuestion(
    id: 'Q8',
    text: 'Display defects (spots/lines)',
  );

  static const AssessmentQuestion scratchOrDentOnBody = AssessmentQuestion(
    id: 'Q9',
    text: 'Scratch/Dent on device body',
  );

  static const AssessmentQuestion devicePanelMissingOrBroken =
      AssessmentQuestion(id: 'Q10', text: 'Device panel missing/broken');

  // Screen Damage - Cracks
  static const AssessmentQuestion crackedScreenOrBrokenGlass =
      AssessmentQuestion(id: 'Q11', text: 'Cracked Screen or Broken Glass');

  static const AssessmentQuestion cracksOutsideDisplayArea = AssessmentQuestion(
    id: 'Q12',
    text: 'Cracks Outside the Display Area',
  );

  // Screen Damage - Scratches
  static const AssessmentQuestion multipleScreenScratches = AssessmentQuestion(
    id: 'Q13',
    text: 'Multiple Scratches (More than 2)',
  );

  static const AssessmentQuestion minorScreenScratches = AssessmentQuestion(
    id: 'Q14',
    text: 'Minor Scratches (1–2 on Screen)',
  );

  // Display Issues - Spots
  static const AssessmentQuestion largeOrHeavyVisibleSpots = AssessmentQuestion(
    id: 'Q15',
    text: 'Large or Heavy Visible Spots',
  );

  static const AssessmentQuestion threeOrMoreSmallSpots = AssessmentQuestion(
    id: 'Q16',
    text: 'Three or More Small Spots',
  );

  static const AssessmentQuestion oneOrTwoSmallSpots = AssessmentQuestion(
    id: 'Q17',
    text: 'One or Two Small Spots',
  );

  static const AssessmentQuestion noSpotsOnScreen = AssessmentQuestion(
    id: 'Q18',
    text: 'No Spots on Screen',
  );

  // Display Issues - Lines
  static const AssessmentQuestion visibleLinesOnScreen = AssessmentQuestion(
    id: 'Q19',
    text: 'Visible Lines on Screen',
  );

  static const AssessmentQuestion fadedDisplayEdges = AssessmentQuestion(
    id: 'Q20',
    text: 'Faded Display Edges',
  );

  static const AssessmentQuestion noLinesOnScreen = AssessmentQuestion(
    id: 'Q21',
    text: 'No Lines on Screen',
  );

  // Display Issues - Discoloration
  static const AssessmentQuestion severeDiscoloration = AssessmentQuestion(
    id: 'Q22',
    text: 'Severe Discoloration',
  );

  static const AssessmentQuestion minorDiscoloration = AssessmentQuestion(
    id: 'Q23',
    text: 'Minor Discoloration',
  );

  static const AssessmentQuestion noDiscoloration = AssessmentQuestion(
    id: 'Q24',
    text: 'No Discoloration',
  );

  // Body Damage - Scratches
  static const AssessmentQuestion moreThanTwoBodyScratches = AssessmentQuestion(
    id: 'Q25',
    text: 'More than 2 scratches',
  );

  static const AssessmentQuestion oneOrTwoBodyScratches = AssessmentQuestion(
    id: 'Q26',
    text: '1-2 scratches',
  );

  static const AssessmentQuestion noBodyScratches = AssessmentQuestion(
    id: 'Q27',
    text: 'No scratches',
  );

  // Body Damage - Dents
  static const AssessmentQuestion multipleDents = AssessmentQuestion(
    id: 'Q28',
    text: 'Multiple dents',
  );

  static const AssessmentQuestion oneOrTwoMinorDents = AssessmentQuestion(
    id: 'Q29',
    text: '1-2 minor dents',
  ); 

  static const AssessmentQuestion noDents = AssessmentQuestion(
    id: 'Q30',
    text: 'No dents',
  );

  // Panel Damage
  static const AssessmentQuestion crackedOrBrokenPanel = AssessmentQuestion(
    id: 'Q31',
    text: 'Cracked or Broken Side/Back Panel',
  );

  static const AssessmentQuestion sideOrBackPanelMissing = AssessmentQuestion(
    id: 'Q32',
    text: 'Side or Back Panel Missing',
  );

  static const AssessmentQuestion noDamageOnPanel = AssessmentQuestion(
    id: 'Q33',
    text: 'No Damage on Side/Back Panel',
  );

  // Frame Damage
  static const AssessmentQuestion bentOrCurvedFrame = AssessmentQuestion(
    id: 'Q34',
    text: 'Bent or Curved Frame',
  );

  static const AssessmentQuestion looseBetweenScreenAndBody =
      AssessmentQuestion(id: 'Q35', text: 'Loose Between Screen & Body');

  static const AssessmentQuestion frameIsStraight = AssessmentQuestion(
    id: 'Q36',
    text: 'Frame is Straight (Not Bent)',
  );

  // Hardware Issues - Cameras
  static const AssessmentQuestion frontCameraNotWorking = AssessmentQuestion(
    id: 'Q37',
    text: 'Front Camera is not working',
  );

  static const AssessmentQuestion rearCameraNotWorking = AssessmentQuestion(
    id: 'Q38',
    text: 'Rear Camera is not working',
  );

  // Hardware Issues - Buttons & Sensors
  static const AssessmentQuestion volumeButtonsUnresponsive =
      AssessmentQuestion(id: 'Q39', text: 'Volume Buttons are unresponsive');

  static const AssessmentQuestion fingerprintSensorNotWorking =
      AssessmentQuestion(id: 'Q40', text: 'Fingerprint sensor not working');

  static const AssessmentQuestion wifiNotConnecting = AssessmentQuestion(
    id: 'Q41',
    text: 'Wi-Fi not connecting',
  );

  static const AssessmentQuestion speakerMalfunctioning = AssessmentQuestion(
    id: 'Q42',
    text: 'Speaker malfunctioning',
  );

  static const AssessmentQuestion silentSwitchNotWorking = AssessmentQuestion(
    id: 'Q43',
    text: 'Silent switch not working',
  );

  static const AssessmentQuestion faceRecognitionNotWorking =
      AssessmentQuestion(
        id: 'Q44',
        text: 'Face recognition sensor not working',
      );

  static const AssessmentQuestion powerButtonUnresponsive = AssessmentQuestion(
    id: 'Q45',
    text: 'Power button unresponsive',
  );

  static const AssessmentQuestion chargingPortNotWorking = AssessmentQuestion(
    id: 'Q46',
    text: 'Charging port not working',
  );

  static const AssessmentQuestion audioReceiverFaulty = AssessmentQuestion(
    id: 'Q47',
    text: 'Audio receiver faulty',
  );

  static const AssessmentQuestion cameraGlassBroken = AssessmentQuestion(
    id: 'Q48',
    text: 'Camera glass broken',
  );

  static const AssessmentQuestion microphoneNotWorking = AssessmentQuestion(
    id: 'Q49',
    text: 'Microphone not working',
  );

  static const AssessmentQuestion bluetoothNotConnecting = AssessmentQuestion(
    id: 'Q50',
    text: 'Bluetooth not connecting',
  );

  static const AssessmentQuestion vibrationMotorNotWorking = AssessmentQuestion(
    id: 'Q51',
    text: 'Vibration motor not working',
  );

  static const AssessmentQuestion proximitySensorNotFunctioning =
      AssessmentQuestion(id: 'Q52', text: 'Proximity sensor not functioning');

  // Battery Health
  static const AssessmentQuestion batteryRequiresService = AssessmentQuestion(
    id: 'Q53',
    text: 'Battery requires service (health below 80%)',
  );

  static const AssessmentQuestion batteryHealth80To85 = AssessmentQuestion(
    id: 'Q54',
    text: 'Battery health at 80–85%',
  );

  // Accessories & Warranty
  static const AssessmentQuestion originalCharger = AssessmentQuestion(
    id: 'Q55',
    text: 'Original charger of device',
  );

  static const AssessmentQuestion originalBox = AssessmentQuestion(
    id: 'Q56',
    text: 'Original box of the phone',
  );

  static const AssessmentQuestion deviceUnderWarrantyDuplicate =
      AssessmentQuestion(id: 'Q57', text: 'Is your device under warranty?');

  static const Map<String, AssessmentQuestion> mapping = {
    'Q1': makeReceiveCalls,
    'Q2': touchScreenWorking,
    'Q3': screenOriginal,
    'Q4': deviceUnderWarranty,
    'Q5': gstBillWithImei,
    'Q6': esimsSupported,
    'Q7': cracksOrScratchOnScreen,
    'Q8': displayDefects,
    'Q9': scratchOrDentOnBody,
    'Q10': devicePanelMissingOrBroken,
    'Q11': crackedScreenOrBrokenGlass,
    'Q12': cracksOutsideDisplayArea,
    'Q13': multipleScreenScratches,
    'Q14': minorScreenScratches,
    'Q15': largeOrHeavyVisibleSpots,
    'Q16': threeOrMoreSmallSpots,
    'Q17': oneOrTwoSmallSpots,
    'Q18': noSpotsOnScreen,
    'Q19': visibleLinesOnScreen,
    'Q20': fadedDisplayEdges,
    'Q21': noLinesOnScreen,
    'Q22': severeDiscoloration,
    'Q23': minorDiscoloration,
    'Q24': noDiscoloration,
    'Q25': moreThanTwoBodyScratches,
    'Q26': oneOrTwoBodyScratches,
    'Q27': noBodyScratches,
    'Q28': multipleDents,
    'Q29': oneOrTwoMinorDents,
    'Q30': noDents,
    'Q31': crackedOrBrokenPanel,
    'Q32': sideOrBackPanelMissing,
    'Q33': noDamageOnPanel,
    'Q34': bentOrCurvedFrame,
    'Q35': looseBetweenScreenAndBody,
    'Q36': frameIsStraight,
    'Q37': frontCameraNotWorking,
    'Q38': rearCameraNotWorking,
    'Q39': volumeButtonsUnresponsive,
    'Q40': fingerprintSensorNotWorking,
    'Q41': wifiNotConnecting,
    'Q42': speakerMalfunctioning,
    'Q43': silentSwitchNotWorking,
    'Q44': faceRecognitionNotWorking,
    'Q45': powerButtonUnresponsive,
    'Q46': chargingPortNotWorking,
    'Q47': audioReceiverFaulty,
    'Q48': cameraGlassBroken,
    'Q49': microphoneNotWorking,
    'Q50': bluetoothNotConnecting,
    'Q51': vibrationMotorNotWorking,
    'Q52': proximitySensorNotFunctioning,
    'Q53': batteryRequiresService,
    'Q54': batteryHealth80To85,
    'Q55': originalCharger,
    'Q56': originalBox,
    'Q57': deviceUnderWarrantyDuplicate,
  };

  static AssessmentQuestion? questionById(String id) => mapping[id];

  static List<AssessmentQuestion> get allQuestions => const [
    makeReceiveCalls,
    touchScreenWorking,
    screenOriginal,
    deviceUnderWarranty,
    gstBillWithImei,
    esimsSupported,
    cracksOrScratchOnScreen,
    displayDefects,
    scratchOrDentOnBody,
    devicePanelMissingOrBroken,
    crackedScreenOrBrokenGlass,
    cracksOutsideDisplayArea,
    multipleScreenScratches,
    minorScreenScratches,
    largeOrHeavyVisibleSpots,
    threeOrMoreSmallSpots,
    oneOrTwoSmallSpots,
    noSpotsOnScreen,
    visibleLinesOnScreen,
    fadedDisplayEdges,
    noLinesOnScreen,
    severeDiscoloration,
    minorDiscoloration,
    noDiscoloration,
    moreThanTwoBodyScratches,
    oneOrTwoBodyScratches,
    noBodyScratches,
    multipleDents,
    oneOrTwoMinorDents,
    noDents,
    crackedOrBrokenPanel,
    sideOrBackPanelMissing,
    noDamageOnPanel,
    bentOrCurvedFrame,
    looseBetweenScreenAndBody,
    frameIsStraight,
    frontCameraNotWorking,
    rearCameraNotWorking,
    volumeButtonsUnresponsive,
    fingerprintSensorNotWorking,
    wifiNotConnecting,
    speakerMalfunctioning,
    silentSwitchNotWorking,
    faceRecognitionNotWorking,
    powerButtonUnresponsive,
    chargingPortNotWorking,
    audioReceiverFaulty,
    cameraGlassBroken,
    microphoneNotWorking,
    bluetoothNotConnecting,
    vibrationMotorNotWorking,
    proximitySensorNotFunctioning,
    batteryRequiresService,
    batteryHealth80To85,
    originalCharger,
    originalBox,
    deviceUnderWarrantyDuplicate,
  ];

  static List<AssessmentQuestion> get functionalityQuestions => const [
    makeReceiveCalls,
    touchScreenWorking,
    screenOriginal,
    deviceUnderWarranty,
    gstBillWithImei,
    esimsSupported,
  ];

  static List<AssessmentQuestion> get defectsSelectionQuestions => const [
    cracksOrScratchOnScreen,
    displayDefects,
    scratchOrDentOnBody,
    devicePanelMissingOrBroken,
  ];

  static List<AssessmentQuestion> get screenDefectsQuestions => const [
    crackedScreenOrBrokenGlass,
    cracksOutsideDisplayArea,
    multipleScreenScratches,
    minorScreenScratches,
  ];

  static List<AssessmentQuestion> get displayDefectsQuestions => const [
    largeOrHeavyVisibleSpots,
    threeOrMoreSmallSpots,
    oneOrTwoSmallSpots,
    noSpotsOnScreen,
    visibleLinesOnScreen,
    fadedDisplayEdges,
    noLinesOnScreen,
    severeDiscoloration,
    minorDiscoloration,
    noDiscoloration,
  ];

  static List<AssessmentQuestion> get bodyDefectsQuestions => const [
    moreThanTwoBodyScratches,
    oneOrTwoBodyScratches,
    noBodyScratches,
    multipleDents,
    oneOrTwoMinorDents,
    noDents,
  ];

  static List<AssessmentQuestion> get panelDefectsQuestions => const [
    crackedOrBrokenPanel,
    sideOrBackPanelMissing,
    noDamageOnPanel,
    bentOrCurvedFrame,
    looseBetweenScreenAndBody,
    frameIsStraight,
  ];

  static List<AssessmentQuestion> get additionalIssuesQuestions => const [
    frontCameraNotWorking,
    rearCameraNotWorking,
    volumeButtonsUnresponsive,
    fingerprintSensorNotWorking,
    wifiNotConnecting,
    speakerMalfunctioning,
    silentSwitchNotWorking,
    faceRecognitionNotWorking,
    powerButtonUnresponsive,
    chargingPortNotWorking,
    audioReceiverFaulty,
    cameraGlassBroken,
    microphoneNotWorking,
    bluetoothNotConnecting,
    vibrationMotorNotWorking,
    proximitySensorNotFunctioning,
    batteryRequiresService,
    batteryHealth80To85,
  ];

  static List<AssessmentQuestion> get accessoriesQuestions => const [
    originalCharger,
    originalBox,
  ];

  static List<AssessmentQuestion> get warrantyQuestions => const [
    deviceUnderWarrantyDuplicate,
  ];

  static List<String> get ids => mapping.keys.toList();
}
