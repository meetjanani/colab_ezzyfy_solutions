String _baseUrl =  'https://rklawfirm.in/new';
String _subUrl = '$_baseUrl/api/v1';

// Home Page Api

String sliderApi = '$_subUrl/sliders/list';
String videoApi = '$_subUrl/videos/list';
String galleryApi = '$_subUrl/galleries/list';
String newsApi  = '$_subUrl/news/list';
String achievementsApi = '$_subUrl/achievements/list';
String testimonialApi = '$_subUrl/testimonials/list';
String teamApi = '$_subUrl/team/list';

String getGeneralChatApi = '$_subUrl/general/chat/messages';
String addGeneralChatMsgApi = '$_subUrl/add/general/chat/message';
String AfterMsgGeneralChatApi = '$_subUrl/general/chat/messageswithid';

//Chat
String getChat = '$_subUrl/chat/messages?';
String addChatMessage = '$_subUrl/add/chat/message';
String getChatbyID = '$_subUrl/chat/messageswithid?';




// Auth Api

String loginApi = '$_subUrl/user/login';
String signUpApi = '$_subUrl/user/register';
String requestOtpApi = '$_subUrl/send-otp';
String verifyOtpApi = '$_subUrl/verify-otp';
String forgotPasswordApi = '$_subUrl/user/forgot-passworsd';
String logoutApi = '$_subUrl/user/logout';
String editApi = '$_subUrl/user/edit/profile';
String addDeviceToken = '$_subUrl/add/device-token';
String editImageApi = '$_subUrl/user/edit/profile/image';
String getProfileApi = '$_subUrl/user/profile';


String suggestionApi = '$_subUrl/add/suggestion';


//other
String advocatesPaginationUrl = '$_subUrl/advocates/list';
String otherServiceUrl = '$_subUrl/services/list';
String matterListUrl = '$_subUrl/user/matters';

String matterApi = '$_subUrl/user/add/matter';

// Appoinment

String getTimeSlotApi = '$_subUrl/time-slots/list';
String saveTimeSlotApi = '$_subUrl/save/slot-booking';
String myAppoinmentApi = '$_subUrl/myappointment';
String rescheduleAppointmentApi = '$_subUrl/rescheduleappointment';