class API {
  static const String url ='http://apimanago2.v3red.com';
      //'http://165.22.214.43'; //'https://api.manago.in';//http://206.189.141.222:6060';

  // static const String url = 'https://apiv2.manago.in';

  // static const String login = '$url/user/login';
  static const String login = '$url/user/sendOTP';

  static const String loginwithPasswords='$url/user/loginViaPassword';

  static const String forgotPassword='$url/user/sendEmailOTPForForgotPassword';

  static const String updatenewPassword='$url/user/updateNewPassword';

  static const String resetPassword='$url/user/resetPassword';

  static const String register = '$url/user/register';

  static const String forceupdate = '$url/user/static';

  //static const String verifyOTP = '$url/user/otp';
  static const String verifyOTP = '$url/user/verifyOTP';


  static const String verifyEmailOTP = '$url/user/verifyEmailOTP';


  static const String dashboardCount = '$url/employer/dashboard/counts';

  static const String getCityStateMap = '$url/common/states';

  static const String getCountryList = '$url/common/getAllCountryList';

  static const String getCountryStateList = '$url/common/getAllStateListBasedOnCountry';

  static const String getCountryStatecityList = '$url/common/getAllCitiesListBasedOnState';

  static const String getAllStatesAndCities = '$url/common/locations';

  static const String  getLocationByPincode = '$url/common/getLocationByPincode';


  static const String preferredLocation = '$url/common/getPreferredLocation';

  static const String preferredCountry = '$url/common/getAllFilterCountryList';
 // static const String getFirmSize = '$url/common/systemcodes/firmsize';
  static const String getFirmSize = '$url/common/getCompanySizeList';

  //static const String getFirmType = '$url/common/systemcodes/firmtype';

  static const String getFirmType = '$url/common/getFirmtypeList';

  //static const String getSkills = '$url/common/systemcodes/skills';

  static const String getSkills = '$url/common/getSkillSetsList';


  static const String getExperience = '$url/common/getExperienceList';

  static const String getStatus = '$url/common/systemcodes/candidatestatus';

  //static const String getDesignation = '$url/common/systemcodes/designation';

  static const String getDesignation = '$url/common/getDesignationList';

  static const String getFilterDesignation = '$url/job/employerAddedDesignationList';

  static const String getSearchJobTitles = '$url/job/employer';

  // static const String getnotificationdata = '$url/user/notification';
  static const String getnotificationdata = '$url/user/getUserNotifications';

  // static const String updateFCMtoken = '$url/user/updatedevicetoken';

  static const String updateFCMtoken = '$url/user/updateDeviceId';

  static const String resendOTP = '$url/user/resend';

  static const String applicantSalarySlip = '$url/salary/candidate';

  static const String candidateDocument = '$url/document/candidate';

  static const String employeeByUserId = '$url/employer/user';

  //static const String employeeUpdate = '$url/employer/profile';
  static const String employeeUpdate = '$url/employer/updateEmployerPersonalProfile';


  static const String companyUpdate = '$url/employer/updateEmployerCompanyProfile';

  static const String sociallinkUpdate='$url/employer/updateEmployerSocialLinks';


  static const String companyDetails = '$url/employer';

  // static const String jobSave = '$url/job/save';
  static const String jobSave = '$url/job/saveJobData';

  static const String createsubscription = '$url/subscriptions/create';

  static const String getAllJobsAgainstEmployer = '$url/job/employer';

  static const String deleteJob = '$url/job';

  static const String jobDetails = '$url/job/details';

  static const String updateJob = '$url/job/update';

  //static const String getsubscription = '$url/subscriptions/info';

  static const String getsubscription = '$url/subscriptions/plan';

  static const String applicantsAgainstEmployer = '$url/application/employer';

  static const String applicantsAgainstJob = '$url/application/job';

  static const String applicantsProfileView = '$url/candidate/getCandidateDetailsForProfileView';

  // static const String searchCandidate = '$url/candidate/search';
  static const String searchCandidate = '$url/employee/findCandidateViaMobile';

  static const String searchCandidateV2 = '$url/candidate/v3/search';

  static const String filterApplicant = '$url/application/searchApplicant';

  static const String employeeList = '$url/employee/list';

  // static const String employeeSearchList = '$url/employee/search';
  static const String employeeSearchList = '$url/employee/list';

  static const String offeredEmployeeSearchList = '$url/document/employer';

  static const String getCandidateDetails = '$url/candidate/fetchCandidateByCandidateId';

  static const String addEmployee = '$url/employee/saveAvailableCandidate';

  static const String addSalary = '$url/salary/save';

  static const String updateSalary = '$url/salary/update';

  static const String deleteSalarySlip = '$url/salary/deleteSalarySlip';

   //static const String getSalaryAgainstEmployer = '$url/salary/employer';
  static const String getSalaryAgainstEmployer = '$url/salary/getSalaryListByEmployer';


  // static const String getSalaryAgainstEmployee = '$url/salary/employee';

   static const String getSalaryAgainstEmployee = '$url/salary/details';

  static const String addExperienceLetter = '$url/document/save';

  //static const String getExperienceLetter = '$url/document/employer';
  static const String getExperienceLetter = '$url/document/expAgainstEmployer';


  //static const String offerLetterList = '$url/document/offer';

  static const String offerLetterList = '$url/document/offerAgainstEmployer';


  static const String updateOfferletter = '$url/document/update';
  static const String deleteOfferletter = '$url/document/delete';

  static const String candidateSave = '$url/candidate/save';



  // static const String getBacButtonSubscription='$url/subscriptions/info?event=backbutton';

  static const String candidateUpdate = '$url/candidate/profile';

  static const String offerLetterDetails = '$url/document/details';

  static const String employeeListDetails = '$url/employee/details';

  static const String employeeDelete = '$url/employee/delete';

  static const String jobSearch = '$url/job/search';

  static const String updateApplicationStatus = '$url/application/status';

  static const String updateOfferLetterStatus = '$url/employee/updateEmployeeStatus';


  static const String updateEmployeeStatus = '$url/employee/update';

  static const String updatecontactus= '$url/common/saveContactUs';

  static const String deleteaccount= '$url/user/deleteUserAccount';

  static const String EmployerProfileCompletion = '$url/employer/checkEmployerprofileByUserId';
}
