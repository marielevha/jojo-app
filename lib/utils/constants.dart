import 'package:flutter/material.dart';
import 'package:jojo/models/user/user.dart';


const String appName = 'Jojo';
const String appEmail = 'contact@jojo.com';
const String appDefaultUserName = 'Jojo Star';
const apiBaseUrl = 'http://www.backend.jojo-logistic.com/api';
//const apiBaseUrl = 'http://192.168.1.183:8000/api';
const apiResponseSize = 12;
String currentToken = '';
late User currentUser;
bool subjectTableRemote = false;
bool favoriteRemote = false;
bool documentRemote = false;

//COLORS
const kTextColor1 = Color(0xFF0D1333);

//CONFIGS
const kCheckProgressCode = '1';
const kCheckProgressName = 'CHECK_PROGRESS';
const kCheckNewVersionCode = '2';
const kCheckNewVersionName = 'CHECK_NEW_VERSION';

//HIVE TABLES
const hiveUserTableName = 'users';
const hiveDeliveryTableName = 'deliveries';

const routeLogin = 'login';
const routeHome = 'home';

//PROFILE
const defaultProfile = 'viewer';

//MAPS
const kGoogleApiKey = 'AIzaSyAE_Whjcw6InfId21slA11Mcbpi9cCk1B0';

const kTransactionTypeOne = 'Déménagement/Transport de biens personel';
const kTransactionTypeTwo = 'Transport de marchandises';
