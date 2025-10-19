import 'package:boilerplate/src/features/questionaire/domain/entities/assessment_question.dart';

// /// Maps backend question IDs to domain model [AssessmentQuestion] objects.
// /// The backend returns questions as a flat array, but they are organized
// /// across different screens in the UI with varying formats and groupings.
// abstract final class QuestionnaireStore {
//   // Basic Functionality Questions
//   static const AssessmentQuestion makeReceiveCalls = AssessmentQuestion(
//     id: 'Q1',
//     text: 'Are you able to make and receive calls?',
//   );

//   static const AssessmentQuestion touchScreenWorking = AssessmentQuestion(
//     id: 'Q2',
//     text: 'Is the touch screen working?',
//   );

//   static const AssessmentQuestion screenOriginal = AssessmentQuestion(
//     id: 'Q3',
//     text: 'Is your phone\'s screen original?',
//   );

//   static const AssessmentQuestion deviceUnderWarranty = AssessmentQuestion(
//     id: 'Q4',
//     text: 'Is the device under warranty?',
//   );

//   static const AssessmentQuestion gstBillWithImei = AssessmentQuestion(
//     id: 'Q5',
//     text: 'Do you have a GST bill with the same IMEI?',
//   );

//   // OLD
//   // static const AssessmentQuestion esimsSupported = AssessmentQuestion(
//   //   id: 'Q6',
//   //   text: 'Do you have the original box with IMEI?',
//   // );

//   static const AssessmentQuestion hasOriginalBox = AssessmentQuestion(
//     id: 'Q6',
//     text: 'Do you have the original box with IMEI?',
//   );

//   static const AssessmentQuestion underWarranty = AssessmentQuestion(
//     id: 'Q7',
//     text: 'Is your device under warranty?',
//   );

//   static const AssessmentQuestion warranty0To3Months = AssessmentQuestion(
//     id: 'Q7O1',
//     text: '0-3 months',
//   );

//   static const AssessmentQuestion warranty3To6Months = AssessmentQuestion(
//     id: 'Q7O2',
//     text: '3-6 months',
//   );

//   static const AssessmentQuestion warranty6To12Months = AssessmentQuestion(
//     id: 'Q7O3',
//     text: '6-11 months',
//   );

//   static const AssessmentQuestion warrantyMoreThan12Months = AssessmentQuestion(
//     id: 'Q7O4',
//     text: 'Above 11 months',
//   );

//   // General Condition Categories
//   // OLD
//   // static const AssessmentQuestion cracksOrScratchOnScreen = AssessmentQuestion(
//   //   id: 'Q7',
//   //   text: 'Cracks/scratch on device screen',
//   // );

//   static const AssessmentQuestion numberOfESims = AssessmentQuestion(
//     id: 'Q8',
//     text: "How many E-sims Does your Device support?"
//   );

//   static const AssessmentQuestion numberOfESims1 = AssessmentQuestion(
//     id: 'Q8O1',
//     text: "1"
//   );

//   static const AssessmentQuestion numberOfESims2 = AssessmentQuestion(
//     id: 'Q8O2',
//     text: "2"
//   );

//   // OLD
//   // static const AssessmentQuestion displayDefects = AssessmentQuestion(
//   //   id: 'Q8',
//   //   text: 'Display defects (spots/lines)',
//   // );

//   static const AssessmentQuestion scratchOrDentOnBody = AssessmentQuestion(
//     id: 'Q9',
//     text: 'Scratch/Dent on device body',
//   );

//   static const AssessmentQuestion devicePanelMissingOrBroken =
//       AssessmentQuestion(id: 'Q10', text: 'Device panel missing/broken');

//   // Screen Damage - Cracks
//   static const AssessmentQuestion crackedScreenOrBrokenGlass =
//       AssessmentQuestion(id: 'Q11', text: 'Cracked Screen or Broken Glass');

//   static const AssessmentQuestion cracksOutsideDisplayArea = AssessmentQuestion(
//     id: 'Q12',
//     text: 'Cracks Outside the Display Area',
//   );

//   // Screen Damage - Scratches
//   static const AssessmentQuestion multipleScreenScratches = AssessmentQuestion(
//     id: 'Q13',
//     text: 'Multiple Scratches (More than 2)',
//   );

//   static const AssessmentQuestion minorScreenScratches = AssessmentQuestion(
//     id: 'Q14',
//     text: 'Minor Scratches (1–2 on Screen)',
//   );

//   // Display Issues - Spots
//   static const AssessmentQuestion largeOrHeavyVisibleSpots = AssessmentQuestion(
//     id: 'Q15',
//     text: 'Large or Heavy Visible Spots',
//   );

//   static const AssessmentQuestion threeOrMoreSmallSpots = AssessmentQuestion(
//     id: 'Q16',
//     text: 'Three or More Small Spots',
//   );

//   static const AssessmentQuestion oneOrTwoSmallSpots = AssessmentQuestion(
//     id: 'Q17',
//     text: 'One or Two Small Spots',
//   );

//   static const AssessmentQuestion noSpotsOnScreen = AssessmentQuestion(
//     id: 'Q18',
//     text: 'No Spots on Screen',
//   );

//   // Display Issues - Lines
//   static const AssessmentQuestion visibleLinesOnScreen = AssessmentQuestion(
//     id: 'Q19',
//     text: 'Visible Lines on Screen',
//   );

//   static const AssessmentQuestion fadedDisplayEdges = AssessmentQuestion(
//     id: 'Q20',
//     text: 'Faded Display Edges',
//   );

//   static const AssessmentQuestion noLinesOnScreen = AssessmentQuestion(
//     id: 'Q21',
//     text: 'No Lines on Screen',
//   );

//   // Display Issues - Discoloration
//   static const AssessmentQuestion severeDiscoloration = AssessmentQuestion(
//     id: 'Q22',
//     text: 'Severe Discoloration',
//   );

//   static const AssessmentQuestion minorDiscoloration = AssessmentQuestion(
//     id: 'Q23',
//     text: 'Minor Discoloration',
//   );

//   static const AssessmentQuestion noDiscoloration = AssessmentQuestion(
//     id: 'Q24',
//     text: 'No Discoloration',
//   );

//   // Body Damage - Scratches
//   static const AssessmentQuestion moreThanTwoBodyScratches = AssessmentQuestion(
//     id: 'Q25',
//     text: 'More than 2 scratches',
//   );

//   static const AssessmentQuestion oneOrTwoBodyScratches = AssessmentQuestion(
//     id: 'Q26',
//     text: '1-2 scratches',
//   );

//   static const AssessmentQuestion noBodyScratches = AssessmentQuestion(
//     id: 'Q27',
//     text: 'No scratches',
//   );

//   // Body Damage - Dents
//   static const AssessmentQuestion multipleDents = AssessmentQuestion(
//     id: 'Q28',
//     text: 'Multiple dents',
//   );

//   static const AssessmentQuestion oneOrTwoMinorDents = AssessmentQuestion(
//     id: 'Q29',
//     text: '1-2 minor dents',
//   );

//   static const AssessmentQuestion noDents = AssessmentQuestion(
//     id: 'Q30',
//     text: 'No dents',
//   );

//   // Panel Damage
//   static const AssessmentQuestion crackedOrBrokenPanel = AssessmentQuestion(
//     id: 'Q31',
//     text: 'Cracked or Broken Side/Back Panel',
//   );

//   static const AssessmentQuestion sideOrBackPanelMissing = AssessmentQuestion(
//     id: 'Q32',
//     text: 'Side or Back Panel Missing',
//   );

//   static const AssessmentQuestion noDamageOnPanel = AssessmentQuestion(
//     id: 'Q33',
//     text: 'No Damage on Side/Back Panel',
//   );

//   // Frame Damage
//   static const AssessmentQuestion bentOrCurvedFrame = AssessmentQuestion(
//     id: 'Q34',
//     text: 'Bent or Curved Frame',
//   );

//   static const AssessmentQuestion looseBetweenScreenAndBody =
//       AssessmentQuestion(id: 'Q35', text: 'Loose Between Screen & Body');

//   static const AssessmentQuestion frameIsStraight = AssessmentQuestion(
//     id: 'Q36',
//     text: 'Frame is Straight (Not Bent)',
//   );

//   // Hardware Issues - Cameras
//   static const AssessmentQuestion frontCameraNotWorking = AssessmentQuestion(
//     id: 'Q37',
//     text: 'Front Camera is not working',
//   );

//   static const AssessmentQuestion rearCameraNotWorking = AssessmentQuestion(
//     id: 'Q38',
//     text: 'Rear Camera is not working',
//   );

//   // Hardware Issues - Buttons & Sensors
//   static const AssessmentQuestion volumeButtonsUnresponsive =
//       AssessmentQuestion(id: 'Q39', text: 'Volume Buttons are unresponsive');

//   static const AssessmentQuestion fingerprintSensorNotWorking =
//       AssessmentQuestion(id: 'Q40', text: 'Fingerprint sensor not working');

//   static const AssessmentQuestion wifiNotConnecting = AssessmentQuestion(
//     id: 'Q41',
//     text: 'Wi-Fi not connecting',
//   );

//   static const AssessmentQuestion speakerMalfunctioning = AssessmentQuestion(
//     id: 'Q42',
//     text: 'Speaker malfunctioning',
//   );

//   static const AssessmentQuestion silentSwitchNotWorking = AssessmentQuestion(
//     id: 'Q43',
//     text: 'Silent switch not working',
//   );

//   static const AssessmentQuestion faceRecognitionNotWorking =
//       AssessmentQuestion(
//         id: 'Q44',
//         text: 'Face recognition sensor not working',
//       );

//   static const AssessmentQuestion powerButtonUnresponsive = AssessmentQuestion(
//     id: 'Q45',
//     text: 'Power button unresponsive',
//   );

//   static const AssessmentQuestion chargingPortNotWorking = AssessmentQuestion(
//     id: 'Q46',
//     text: 'Charging port not working',
//   );

//   static const AssessmentQuestion audioReceiverFaulty = AssessmentQuestion(
//     id: 'Q47',
//     text: 'Audio receiver faulty',
//   );

//   static const AssessmentQuestion cameraGlassBroken = AssessmentQuestion(
//     id: 'Q48',
//     text: 'Camera glass broken',
//   );

//   static const AssessmentQuestion microphoneNotWorking = AssessmentQuestion(
//     id: 'Q49',
//     text: 'Microphone not working',
//   );

//   static const AssessmentQuestion bluetoothNotConnecting = AssessmentQuestion(
//     id: 'Q50',
//     text: 'Bluetooth not connecting',
//   );

//   static const AssessmentQuestion vibrationMotorNotWorking = AssessmentQuestion(
//     id: 'Q51',
//     text: 'Vibration motor not working',
//   );

//   static const AssessmentQuestion proximitySensorNotFunctioning =
//       AssessmentQuestion(id: 'Q52', text: 'Proximity sensor not functioning');

//   // Battery Health
//   static const AssessmentQuestion batteryRequiresService = AssessmentQuestion(
//     id: 'Q53',
//     text: 'Battery requires service (health below 80%)',
//   );

//   static const AssessmentQuestion batteryHealth80To85 = AssessmentQuestion(
//     id: 'Q54',
//     text: 'Battery health at 80–85%',
//   );

//   // Accessories & Warranty
//   static const AssessmentQuestion originalCharger = AssessmentQuestion(
//     id: 'Q55',
//     text: 'Original charger of device',
//   );

//   static const AssessmentQuestion originalBox = AssessmentQuestion(
//     id: 'Q56',
//     text: 'Original box of the phone',
//   );

//   static const AssessmentQuestion deviceUnderWarrantyDuplicate =
//       AssessmentQuestion(id: 'Q57', text: 'Is your device under warranty?');

//   static const Map<String, AssessmentQuestion> mapping = {
//     'Q1': makeReceiveCalls,
//     'Q2': touchScreenWorking,
//     'Q3': screenOriginal,
//     'Q4': deviceUnderWarranty,
//     'Q5': gstBillWithImei,
//     // 'Q6': esimsSupported,
//     // 'Q7': cracksOrScratchOnScreen,
//     // 'Q8': displayDefects,
//     'Q9': scratchOrDentOnBody,
//     'Q10': devicePanelMissingOrBroken,
//     'Q11': crackedScreenOrBrokenGlass,
//     'Q12': cracksOutsideDisplayArea,
//     'Q13': multipleScreenScratches,
//     'Q14': minorScreenScratches,
//     'Q15': largeOrHeavyVisibleSpots,
//     'Q16': threeOrMoreSmallSpots,
//     'Q17': oneOrTwoSmallSpots,
//     'Q18': noSpotsOnScreen,
//     'Q19': visibleLinesOnScreen,
//     'Q20': fadedDisplayEdges,
//     'Q21': noLinesOnScreen,
//     'Q22': severeDiscoloration,
//     'Q23': minorDiscoloration,
//     'Q24': noDiscoloration,
//     'Q25': moreThanTwoBodyScratches,
//     'Q26': oneOrTwoBodyScratches,
//     'Q27': noBodyScratches,
//     'Q28': multipleDents,
//     'Q29': oneOrTwoMinorDents,
//     'Q30': noDents,
//     'Q31': crackedOrBrokenPanel,
//     'Q32': sideOrBackPanelMissing,
//     'Q33': noDamageOnPanel,
//     'Q34': bentOrCurvedFrame,
//     'Q35': looseBetweenScreenAndBody,
//     'Q36': frameIsStraight,
//     'Q37': frontCameraNotWorking,
//     'Q38': rearCameraNotWorking,
//     'Q39': volumeButtonsUnresponsive,
//     'Q40': fingerprintSensorNotWorking,
//     'Q41': wifiNotConnecting,
//     'Q42': speakerMalfunctioning,
//     'Q43': silentSwitchNotWorking,
//     'Q44': faceRecognitionNotWorking,
//     'Q45': powerButtonUnresponsive,
//     'Q46': chargingPortNotWorking,
//     'Q47': audioReceiverFaulty,
//     'Q48': cameraGlassBroken,
//     'Q49': microphoneNotWorking,
//     'Q50': bluetoothNotConnecting,
//     'Q51': vibrationMotorNotWorking,
//     'Q52': proximitySensorNotFunctioning,
//     'Q53': batteryRequiresService,
//     'Q54': batteryHealth80To85,
//     'Q55': originalCharger,
//     'Q56': originalBox,
//     'Q57': deviceUnderWarrantyDuplicate,
//   };

//   static AssessmentQuestion? questionById(String id) => mapping[id];

//   static List<AssessmentQuestion> get allQuestions => const [
//     makeReceiveCalls,
//     touchScreenWorking,
//     screenOriginal,
//     deviceUnderWarranty,
//     gstBillWithImei,
//     esimsSupported,
//     cracksOrScratchOnScreen,
//     displayDefects,
//     scratchOrDentOnBody,
//     devicePanelMissingOrBroken,
//     crackedScreenOrBrokenGlass,
//     cracksOutsideDisplayArea,
//     multipleScreenScratches,
//     minorScreenScratches,
//     largeOrHeavyVisibleSpots,
//     threeOrMoreSmallSpots,
//     oneOrTwoSmallSpots,
//     noSpotsOnScreen,
//     visibleLinesOnScreen,
//     fadedDisplayEdges,
//     noLinesOnScreen,
//     severeDiscoloration,
//     minorDiscoloration,
//     noDiscoloration,
//     moreThanTwoBodyScratches,
//     oneOrTwoBodyScratches,
//     noBodyScratches,
//     multipleDents,
//     oneOrTwoMinorDents,
//     noDents,
//     crackedOrBrokenPanel,
//     sideOrBackPanelMissing,
//     noDamageOnPanel,
//     bentOrCurvedFrame,
//     looseBetweenScreenAndBody,
//     frameIsStraight,
//     frontCameraNotWorking,
//     rearCameraNotWorking,
//     volumeButtonsUnresponsive,
//     fingerprintSensorNotWorking,
//     wifiNotConnecting,
//     speakerMalfunctioning,
//     silentSwitchNotWorking,
//     faceRecognitionNotWorking,
//     powerButtonUnresponsive,
//     chargingPortNotWorking,
//     audioReceiverFaulty,
//     cameraGlassBroken,
//     microphoneNotWorking,
//     bluetoothNotConnecting,
//     vibrationMotorNotWorking,
//     proximitySensorNotFunctioning,
//     batteryRequiresService,
//     batteryHealth80To85,
//     originalCharger,
//     originalBox,
//     deviceUnderWarrantyDuplicate,
//   ];

//   static List<AssessmentQuestion> get functionalityQuestions => const [
//     makeReceiveCalls,
//     touchScreenWorking,
//     screenOriginal,
//     deviceUnderWarranty,
//     gstBillWithImei,
//     esimsSupported,
//   ];

//   static List<AssessmentQuestion> get defectsSelectionQuestions => const [
//     cracksOrScratchOnScreen,
//     displayDefects,
//     scratchOrDentOnBody,
//     devicePanelMissingOrBroken,
//   ];

//   static List<AssessmentQuestion> get screenDefectsQuestions => const [
//     crackedScreenOrBrokenGlass,
//     cracksOutsideDisplayArea,
//     multipleScreenScratches,
//     minorScreenScratches,
//   ];

//   static List<AssessmentQuestion> get displayDefectsQuestions => const [
//     largeOrHeavyVisibleSpots,
//     threeOrMoreSmallSpots,
//     oneOrTwoSmallSpots,
//     noSpotsOnScreen,
//     visibleLinesOnScreen,
//     fadedDisplayEdges,
//     noLinesOnScreen,
//     severeDiscoloration,
//     minorDiscoloration,
//     noDiscoloration,
//   ];

//   static List<AssessmentQuestion> get bodyDefectsQuestions => const [
//     moreThanTwoBodyScratches,
//     oneOrTwoBodyScratches,
//     noBodyScratches,
//     multipleDents,
//     oneOrTwoMinorDents,
//     noDents,
//   ];

//   static List<AssessmentQuestion> get panelDefectsQuestions => const [
//     crackedOrBrokenPanel,
//     sideOrBackPanelMissing,
//     noDamageOnPanel,
//     bentOrCurvedFrame,
//     looseBetweenScreenAndBody,
//     frameIsStraight,
//   ];

//   static List<AssessmentQuestion> get additionalIssuesQuestions => const [
//     frontCameraNotWorking,
//     rearCameraNotWorking,
//     volumeButtonsUnresponsive,
//     fingerprintSensorNotWorking,
//     wifiNotConnecting,
//     speakerMalfunctioning,
//     silentSwitchNotWorking,
//     faceRecognitionNotWorking,
//     powerButtonUnresponsive,
//     chargingPortNotWorking,
//     audioReceiverFaulty,
//     cameraGlassBroken,
//     microphoneNotWorking,
//     bluetoothNotConnecting,
//     vibrationMotorNotWorking,
//     proximitySensorNotFunctioning,
//     batteryRequiresService,
//     batteryHealth80To85,
//   ];

//   static List<AssessmentQuestion> get accessoriesQuestions => const [
//     originalCharger,
//     originalBox,
//   ];

//   static List<AssessmentQuestion> get warrantyQuestions => const [
//     deviceUnderWarrantyDuplicate,
//   ];

//   static List<String> get ids => mapping.keys.toList();
// }


// yes/no update
// kyc 
// image upload
// ba and calculate again  
// 

/// Maps backend question IDs to domain model [AssessmentQuestion] objects.
/// The backend returns questions as a flat array, but they are organized
/// across different screens in the UI with varying formats and groupings.
/// 
/// Updated to match the union section from the backend API response.
abstract final class QuestionnaireStore {
  // ============================================================================
  // Basic Functionality Questions (Page 1)
  // ============================================================================
  
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

  static const AssessmentQuestion hasOriginalBox = AssessmentQuestion(
    id: 'Q6',
    text: 'Oringinal box with Imei',
  );

  // Warranty Sub-Questions
  static const AssessmentQuestion warrantyPeriod = AssessmentQuestion(
    id: 'Q7',
    text: 'Is the device under warranty?',
  );

  static const AssessmentQuestion warranty0To3Months = AssessmentQuestion(
    id: 'Q7O1',
    text: '0-3months',
  );

  static const AssessmentQuestion warranty3To6Months = AssessmentQuestion(
    id: 'Q7O2',
    text: '3-6months',
  );

  static const AssessmentQuestion warranty6To11Months = AssessmentQuestion(
    id: 'Q7O3',
    text: '6-11 months',
  );

  static const AssessmentQuestion warrantyMoreThan11Months = AssessmentQuestion(
    id: 'Q7O4',
    text: 'Above 11 Months',
  );

  // ============================================================================
  // iOS-Only Questions - E-SIM Support
  // ============================================================================
  
  static const AssessmentQuestion numberOfESims = AssessmentQuestion(
    id: 'Q8',
    text: 'How many E-sims Does your Device support?',
    category: QuestionCategory.ios,
  );

  static const AssessmentQuestion numberOfESims1 = AssessmentQuestion(
    id: 'Q8O1',
    text: '1',
    category: QuestionCategory.ios,
  );
  

  static const AssessmentQuestion numberOfESims2 = AssessmentQuestion(
    id: 'Q8O2',
    text: '2',
    category: QuestionCategory.ios,
  );

  // ============================================================================
  // Display Issues (Page 2, 3, 4)
  // ============================================================================

  // Main display defects category (Page 2)
  static const AssessmentQuestion displayDefects = AssessmentQuestion(
    id: 'Q9',
    text: 'Dead spot/Visible line and discolouration on screen',
  );

  // Display Issues - Dead Pixels/Spots (Page 4)
  static const AssessmentQuestion deadPixelsSpots = AssessmentQuestion(
    id: 'Q10',
    text: '1) Dead pixels/spots on screen',
  );

  static const AssessmentQuestion noSpotsOnScreen = AssessmentQuestion(
    id: 'Q10O1',
    text: 'No spot on screen',
  );

  static const AssessmentQuestion oneOrTwoSmallSpots = AssessmentQuestion(
    id: 'Q10O2',
    text: '1-2 Minor spots on screen',
  );

  static const AssessmentQuestion threeOrMoreSmallSpots = AssessmentQuestion(
    id: 'Q10O3',
    text: '3 or more minor spots on screen',
  );

  static const AssessmentQuestion largeOrHeavyVisibleSpots = AssessmentQuestion(
    id: 'Q10O4',
    text: 'Large / heavy visible spots on screen',
  );

  // Display Issues - Lines (Page 4)
  static const AssessmentQuestion visibleLinesCategory = AssessmentQuestion(
    id: 'Q11',
    text: '2) Visible lines on screen',
  );

  static const AssessmentQuestion noLinesOnScreen = AssessmentQuestion(
    id: 'Q11O1',
    text: 'No line(S) on display',
  );

  static const AssessmentQuestion fadedDisplayEdges = AssessmentQuestion(
    id: 'Q11O2',
    text: 'Display faded along edges',
  );

  static const AssessmentQuestion visibleLinesOnScreen = AssessmentQuestion(
    id: 'Q11O3',
    text: 'visible lines on screen',
  );

  // Display Issues - Discoloration (Page 4)
  static const AssessmentQuestion discolorationCategory = AssessmentQuestion(
    id: 'Q12',
    text: '3)Discolouration on screen',
  );

  static const AssessmentQuestion noDiscoloration = AssessmentQuestion(
    id: 'Q12O1',
    text: 'No discolouration',
  );

  static const AssessmentQuestion minorDiscoloration = AssessmentQuestion(
    id: 'Q12O2',
    text: 'Minor Discoulouration',
  );

  static const AssessmentQuestion severeDiscoloration = AssessmentQuestion(
    id: 'Q12O3',
    text: 'Major discolouration',
  );

  // ============================================================================
  // Body Damage (Page 2, 5)
  // ============================================================================

  // Main body defects category (Page 2)
  static const AssessmentQuestion scratchOrDentOnBody = AssessmentQuestion(
    id: 'Q13',
    text: 'Scratch/Dent on device body',
  );

  // Body Damage - Scratches (Page 5)
  static const AssessmentQuestion scratchesOnBody = AssessmentQuestion(
    id: 'Q14',
    text: '1) scrathes on device body',
  );

  static const AssessmentQuestion noBodyScratches = AssessmentQuestion(
    id: 'Q14O1',
    text: 'No scratches',
  );

  static const AssessmentQuestion oneOrTwoBodyScratches = AssessmentQuestion(
    id: 'Q14O2',
    text: '1-2 Scratches',
  );

  static const AssessmentQuestion moreThanTwoBodyScratches = AssessmentQuestion(
    id: 'Q14O3',
    text: 'more than 2 scrathes',
  );

  // Body Damage - Dents (Page 5)
  static const AssessmentQuestion dentsOnDevice = AssessmentQuestion(
    id: 'Q15',
    text: '2)Dents on device',
  );

  static const AssessmentQuestion noDents = AssessmentQuestion(
    id: 'Q15O1',
    text: 'No dents',
  );

  static const AssessmentQuestion oneOrTwoMinorDents = AssessmentQuestion(
    id: 'Q15O2',
    text: '1-2 minor dents',
  );

  static const AssessmentQuestion multipleDents = AssessmentQuestion(
    id: 'Q15O3',
    text: 'Major dents or more than 2',
  );

  // ============================================================================
  // Panel Damage (Page 2, 6)
  // ============================================================================

  // Main panel category (Page 2)
  static const AssessmentQuestion devicePanelMissingOrBroken = AssessmentQuestion(
    id: 'Q16',
    text: 'Device panel missing/Broken',
  );

  // Panel Details - Side/Back Panel (Page 6)
  static const AssessmentQuestion sideBackPanelCondition = AssessmentQuestion(
    id: 'Q17',
    text: '1) Device Side back panel condition',
  );

  static const AssessmentQuestion noDamageOnPanel = AssessmentQuestion(
    id: 'Q17O1',
    text: 'No defects on side or back panel',
  );

  static const AssessmentQuestion sideOrBackPanelMissing = AssessmentQuestion(
    id: 'Q17O2',
    text: 'missing side or back panel',
  );

  static const AssessmentQuestion crackedOrBrokenPanel = AssessmentQuestion(
    id: 'Q17O3',
    text: 'cracked broken side or back panel',
  );

  // Panel Details - Bent/Loose (Page 6)
  static const AssessmentQuestion deviceBentScreenLoose = AssessmentQuestion(
    id: 'Q18',
    text: '2)Device bent screen loose',
  );

  static const AssessmentQuestion frameIsStraight = AssessmentQuestion(
    id: 'Q18O1',
    text: 'Phone not bent',
  );

  static const AssessmentQuestion looseBetweenScreenAndBody = AssessmentQuestion(
    id: 'Q18O2',
    text: 'loose screen (gap in screen and body)',
  );

  static const AssessmentQuestion bentOrCurvedFrame = AssessmentQuestion(
    id: 'Q18O3',
    text: 'Bent/curved Panel',
  );

  // ============================================================================
  // Screen Damage - Cracks/Scratches (Page 3)
  // ============================================================================

  static const AssessmentQuestion brokenScratchOnScreen = AssessmentQuestion(
    id: 'Q19',
    text: 'Broken/scratch on device screen',
  );

  static const AssessmentQuestion minorScreenScratches = AssessmentQuestion(
    id: 'Q19O1',
    text: '1-2 scratches on screen',
  );

  static const AssessmentQuestion multipleScreenScratches = AssessmentQuestion(
    id: 'Q19O2',
    text: 'More than 2 scratches on screen',
  );

  static const AssessmentQuestion cracksOutsideDisplayArea = AssessmentQuestion(
    id: 'Q19O3',
    text: 'chipped/cracked outside display area',
  );

  static const AssessmentQuestion crackedScreenOrBrokenGlass = AssessmentQuestion(
    id: 'Q19O4',
    text: 'screen cracked/glass broken',
  );

  // ============================================================================
  // Hardware Issues - Additional Problems (Page 7)
  // ============================================================================

  static const AssessmentQuestion functionalOrPhysicalProblems = AssessmentQuestion(
    id: 'Q20',
    text: 'Functional or physicall problems',
  );

  static const AssessmentQuestion proximitySensorNotFunctioning = AssessmentQuestion(
    id: 'Q21',
    text: 'Proximity sensor not working',
  );

  // iOS-Only Battery Service
  static const AssessmentQuestion batteryRequiresService = AssessmentQuestion(
    id: 'Q22',
    text: 'battery service',
  
    category: QuestionCategory.ios,
  );

  static const AssessmentQuestion volumeButtonsUnresponsive = AssessmentQuestion(
    id: 'Q23',
    text: 'volume button not working',
  );

  static const AssessmentQuestion frontCameraNotWorking = AssessmentQuestion(
    id: 'Q24',
    text: 'Front Camera not working',
  );

  static const AssessmentQuestion rearCameraNotWorking = AssessmentQuestion(
    id: 'Q25',
    text: 'back camera not working',
  );

  static const AssessmentQuestion fingerprintSensorNotWorking = AssessmentQuestion(
    id: 'Q26',
    text: 'finger touch not working',
  );

  static const AssessmentQuestion wifiNotConnecting = AssessmentQuestion(
    id: 'Q27',
    text: 'wifi not working',
  );

  static const AssessmentQuestion speakerMalfunctioning = AssessmentQuestion(
    id: 'Q28',
    text: 'speaker faulty',
  );

  static const AssessmentQuestion silentSwitchNotWorking = AssessmentQuestion(
    id: 'Q29',
    text: 'silent button not working',
  );

  static const AssessmentQuestion powerButtonUnresponsive = AssessmentQuestion(
    id: 'Q30',
    text: 'power button not working',
  );

  static const AssessmentQuestion faceRecognitionNotWorking = AssessmentQuestion(
    id: 'Q31',
    text: 'face id sensor not working',
  );

  static const AssessmentQuestion audioReceiverFaulty = AssessmentQuestion(
    id: 'Q32',
    text: 'audio receiver not working',
  );

  static const AssessmentQuestion cameraGlassBroken = AssessmentQuestion(
    id: 'Q33',
    text: 'camera glass broken',
  );

  static const AssessmentQuestion microphoneNotWorking = AssessmentQuestion(
    id: 'Q34',
    text: 'micro phone not working',
  );

  static const AssessmentQuestion bluetoothNotConnecting = AssessmentQuestion(
    id: 'Q35',
    text: 'bluetooth not working',
  );

  static const AssessmentQuestion vibrationMotorNotWorking = AssessmentQuestion(
    id: 'Q36',
    text: 'vibrator not working',
  );

  // iOS-Only Battery Health
  static const AssessmentQuestion batteryHealth80To85 = AssessmentQuestion(
    id: 'Q37',
    text: 'battery health 80-85',
    category: QuestionCategory.ios,
  );

  // ============================================================================
  // COMMENTED OUT - Questions removed or changed in union
  // ============================================================================
  
  // OLD Q6 - Replaced with hasOriginalBox (Q6)
  // static const AssessmentQuestion esimsSupported = AssessmentQuestion(
  //   id: 'Q6',
  //   text: 'How many eSIMs are supported?',
  // );

  // OLD Q7 - Now Q19 (Broken/scratch on device screen)
  // static const AssessmentQuestion cracksOrScratchOnScreen = AssessmentQuestion(
  //   id: 'Q7',
  //   text: 'Cracks/scratch on device screen',
  // );

  // OLD Q8 - Now Q9 (Dead spot/Visible line and discolouration on screen)
  // static const AssessmentQuestion displayDefects = AssessmentQuestion(
  //   id: 'Q8',
  //   text: 'Display defects (spots/lines)',
  // );

  // OLD Q55 - No longer in union
  // static const AssessmentQuestion originalCharger = AssessmentQuestion(
  //   id: 'Q55',
  //   text: 'Original charger of device',
  // );

  // OLD Q56 - No longer in union
  // static const AssessmentQuestion originalBox = AssessmentQuestion(
  //   id: 'Q56',
  //   text: 'Original box of the phone',
  // );

  // OLD Q57 - Duplicate of Q4 and Q7, removed
  // static const AssessmentQuestion deviceUnderWarrantyDuplicate = AssessmentQuestion(
  //   id: 'Q57',
  //   text: 'Is your device under warranty?',
  // );

  // OLD Q46 - No longer in union (charging port)
  // static const AssessmentQuestion chargingPortNotWorking = AssessmentQuestion(
  //   id: 'Q46',
  //   text: 'Charging port not working',
  // );

  // ============================================================================
  // MAPPINGS
  // ============================================================================

  static const Map<String, AssessmentQuestion> mapping = {
    'Q1': makeReceiveCalls,
    'Q2': touchScreenWorking,
    'Q3': screenOriginal,
    'Q4': deviceUnderWarranty,
    'Q5': gstBillWithImei,
    'Q6': hasOriginalBox,
    'Q7': warrantyPeriod,
    'Q7O1': warranty0To3Months,
    'Q7O2': warranty3To6Months,
    'Q7O3': warranty6To11Months,
    'Q7O4': warrantyMoreThan11Months,
    'Q8': numberOfESims,
    'Q8O1': numberOfESims1,
    'Q8O2': numberOfESims2,
    'Q9': displayDefects,
    'Q10': deadPixelsSpots,
    'Q10O1': noSpotsOnScreen,
    'Q10O2': oneOrTwoSmallSpots,
    'Q10O3': threeOrMoreSmallSpots,
    'Q10O4': largeOrHeavyVisibleSpots,
    'Q11': visibleLinesCategory,
    'Q11O1': noLinesOnScreen,
    'Q11O2': fadedDisplayEdges,
    'Q11O3': visibleLinesOnScreen,
    'Q12': discolorationCategory,
    'Q12O1': noDiscoloration,
    'Q12O2': minorDiscoloration,
    'Q12O3': severeDiscoloration,
    'Q13': scratchOrDentOnBody,
    'Q14': scratchesOnBody,
    'Q14O1': noBodyScratches,
    'Q14O2': oneOrTwoBodyScratches,
    'Q14O3': moreThanTwoBodyScratches,
    'Q15': dentsOnDevice,
    'Q15O1': noDents,
    'Q15O2': oneOrTwoMinorDents,
    'Q15O3': multipleDents,
    'Q16': devicePanelMissingOrBroken,
    'Q17': sideBackPanelCondition,
    'Q17O1': noDamageOnPanel,
    'Q17O2': sideOrBackPanelMissing,
    'Q17O3': crackedOrBrokenPanel,
    'Q18': deviceBentScreenLoose,
    'Q18O1': frameIsStraight,
    'Q18O2': looseBetweenScreenAndBody,
    'Q18O3': bentOrCurvedFrame,
    'Q19': brokenScratchOnScreen,
    'Q19O1': minorScreenScratches,
    'Q19O2': multipleScreenScratches,
    'Q19O3': cracksOutsideDisplayArea,
    'Q19O4': crackedScreenOrBrokenGlass,
    'Q20': functionalOrPhysicalProblems,
    'Q21': proximitySensorNotFunctioning,
    'Q22': batteryRequiresService,
    'Q23': volumeButtonsUnresponsive,
    'Q24': frontCameraNotWorking,
    'Q25': rearCameraNotWorking,
    'Q26': fingerprintSensorNotWorking,
    'Q27': wifiNotConnecting,
    'Q28': speakerMalfunctioning,
    'Q29': silentSwitchNotWorking,
    'Q30': powerButtonUnresponsive,
    'Q31': faceRecognitionNotWorking,
    'Q32': audioReceiverFaulty,
    'Q33': cameraGlassBroken,
    'Q34': microphoneNotWorking,
    'Q35': bluetoothNotConnecting,
    'Q36': vibrationMotorNotWorking,
    'Q37': batteryHealth80To85,
  };

  static AssessmentQuestion? questionById(String id) => mapping[id];

  static List<AssessmentQuestion> get allQuestions => const [
    makeReceiveCalls,
    touchScreenWorking,
    screenOriginal,
    deviceUnderWarranty,
    gstBillWithImei,
    hasOriginalBox,
    warrantyPeriod,
    warranty0To3Months,
    warranty3To6Months,
    warranty6To11Months,
    warrantyMoreThan11Months,
    numberOfESims,
    numberOfESims1,
    numberOfESims2,
    displayDefects,
    deadPixelsSpots,
    noSpotsOnScreen,
    oneOrTwoSmallSpots,
    threeOrMoreSmallSpots,
    largeOrHeavyVisibleSpots,
    visibleLinesCategory,
    noLinesOnScreen,
    fadedDisplayEdges,
    visibleLinesOnScreen,
    discolorationCategory,
    noDiscoloration,
    minorDiscoloration,
    severeDiscoloration,
    scratchOrDentOnBody,
    scratchesOnBody,
    noBodyScratches,
    oneOrTwoBodyScratches,
    moreThanTwoBodyScratches,
    dentsOnDevice,
    noDents,
    oneOrTwoMinorDents,
    multipleDents,
    devicePanelMissingOrBroken,
    sideBackPanelCondition,
    noDamageOnPanel,
    sideOrBackPanelMissing,
    crackedOrBrokenPanel,
    deviceBentScreenLoose,
    frameIsStraight,
    looseBetweenScreenAndBody,
    bentOrCurvedFrame,
    brokenScratchOnScreen,
    minorScreenScratches,
    multipleScreenScratches,
    cracksOutsideDisplayArea,
    crackedScreenOrBrokenGlass,
    functionalOrPhysicalProblems,
    proximitySensorNotFunctioning,
    batteryRequiresService,
    volumeButtonsUnresponsive,
    frontCameraNotWorking,
    rearCameraNotWorking,
    fingerprintSensorNotWorking,
    wifiNotConnecting,
    speakerMalfunctioning,
    silentSwitchNotWorking,
    powerButtonUnresponsive,
    faceRecognitionNotWorking,
    audioReceiverFaulty,
    cameraGlassBroken,
    microphoneNotWorking,
    bluetoothNotConnecting,
    vibrationMotorNotWorking,
    batteryHealth80To85,
  ];

  static List<AssessmentQuestion> get functionalityQuestions => const [
    makeReceiveCalls,
    touchScreenWorking,
    screenOriginal,
    deviceUnderWarranty,
    gstBillWithImei,
  ];

  static List<AssessmentQuestion> get eSimQuestions => const [
    numberOfESims,
    numberOfESims1,
    numberOfESims2,
  ];

  static List<AssessmentQuestion> get defectsSelectionQuestions => const [
    displayDefects,
    scratchOrDentOnBody,
    devicePanelMissingOrBroken,
    brokenScratchOnScreen,
  ];

  static List<AssessmentQuestion> get screenDefectsQuestions => const [
    brokenScratchOnScreen,
    minorScreenScratches,
    multipleScreenScratches,
    cracksOutsideDisplayArea,
    crackedScreenOrBrokenGlass,
  ];

  static List<AssessmentQuestion> get displayDefectsQuestions => const [
    displayDefects,
    deadPixelsSpots,
    noSpotsOnScreen,
    oneOrTwoSmallSpots,
    threeOrMoreSmallSpots,
    largeOrHeavyVisibleSpots,
    visibleLinesCategory,
    noLinesOnScreen,
    fadedDisplayEdges,
    visibleLinesOnScreen,
    discolorationCategory,
    noDiscoloration,
    minorDiscoloration,
    severeDiscoloration,
  ];

  static List<AssessmentQuestion> get bodyDefectsQuestions => const [
    scratchOrDentOnBody,
    scratchesOnBody,
    noBodyScratches,
    oneOrTwoBodyScratches,
    moreThanTwoBodyScratches,
    dentsOnDevice,
    noDents,
    oneOrTwoMinorDents,
    multipleDents,
  ];

  static List<AssessmentQuestion> get panelDefectsQuestions => const [
    devicePanelMissingOrBroken,
    sideBackPanelCondition,
    noDamageOnPanel,
    sideOrBackPanelMissing,
    crackedOrBrokenPanel,
    deviceBentScreenLoose,
    frameIsStraight,
    looseBetweenScreenAndBody,
    bentOrCurvedFrame,
  ];

  static List<AssessmentQuestion> get additionalIssuesQuestions => const [
    functionalOrPhysicalProblems,
    proximitySensorNotFunctioning,
    batteryRequiresService,
    volumeButtonsUnresponsive,
    frontCameraNotWorking,
    rearCameraNotWorking,
    fingerprintSensorNotWorking,
    wifiNotConnecting,
    speakerMalfunctioning,
    silentSwitchNotWorking,
    powerButtonUnresponsive,
    faceRecognitionNotWorking,
    audioReceiverFaulty,
    cameraGlassBroken,
    microphoneNotWorking,
    bluetoothNotConnecting,
    vibrationMotorNotWorking,
    batteryHealth80To85,
  ];


  static List<AssessmentQuestion> get accessoriesQuestions => const [
    hasOriginalBox,
  ];

  static List<AssessmentQuestion> get warrantyQuestions => const [
    warrantyPeriod,
    warranty0To3Months,
    warranty3To6Months,
    warranty6To11Months,
    warrantyMoreThan11Months,
  ];

  static List<String> get ids => mapping.keys.toList();
}
