const BASE_URL = "https://cabike.in/";
const MID_URL = "cba/api/passenger/";
const FULL_URL = BASE_URL+MID_URL;

// otp end points
const getOTPEndPoint = "login/otp";
const verifyOTPEndPoint = "verify/otp";
const resendOTPEndPoint = "resend/otp";
const logoutEndPoint = "logout";

// pin end points

const loginPINEndPoint = "login/pin";
const verifyPINEndPoint = "verify/pin";
const resetPINEndPoint = "reset/pin";
const resendPINEndPoint = "resend/pin";
const forgetPINEndPoint = "forgot/pin";

// profile end points
const createProfileEndPoint = "personal";
const updateProfileEndPoint = "personal";
const getProfileEndPoint = "personal";
const uploadProfilePictureEndPoint = "photo";
const updateProfilePictureEndPoint = "photo";