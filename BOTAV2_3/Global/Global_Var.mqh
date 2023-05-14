
//----------------------------------------
//                   GENERAL         
//----------------------------------------  

double           LOT = 0.01;
bool             Dynamic_LOT = true;
double           DL_Divider = 20000.0;

ENUM_TIMEFRAMES  TimeFrame = PERIOD_H1;   
           
             
string          FileName = "BotA_V2_3_Detail2";
bool            writeLog = false;
bool            writeData = false;
bool            writeTick = false;
bool            writeResult = true;
bool            writeSave = true;
bool            Print_Statements = false;
bool            Print_Status = true;
bool            clear_drawings = true;
double           MIN_ACC_SIZE = 10.0;

print_manager PrintManager;
int filereload_count = 0;
int filereload_MAX = 3;

int last_hour = 0;
int last_day = 9;
int hour_count = -1;

bool Draw_Limit = false;

save_manager SaveManager;

//----------------------------------------
//                   SLEEP         
//----------------------------------------  

  bool            WatchNews = true;
  int             WatchNews_Startoffset = 3600*0;
  int             WatchNews_Endoffset = 3600*0;

  string          exe_time1_start   = "1:10";
  string          exe_time1_end   = "23:50";

  string          exe_time2_start   = "";
  string          exe_time2_end   = "";

  string          exe_time3_start   = "";
  string          exe_time3_end   = "";

  string          exe_time4_start   = "";
  string          exe_time4_end   = "";

  string          exe_time5_start   = "";
  string          exe_time5_end   = "";

array_news NEWS;
sleeptime SleepTime;

//----------------------------------------
//                   SIM          
//----------------------------------------        

 datetime         SIM_STARTTIME = D'2022.04.03 15:45'; 
 datetime         SIM_ENDTIME = D'2022.04.03 16:55';
 double           SIM_SPEED = 1;

SIMULATOR SIM;

//----------------------------------------
//                   GUI          
//---------------------------------------- 

Bota_GUI GUI;
//Dali Dali_BOT;
//----------------------------------------
//                   CHAMPS          
//----------------------------------------
//--------------------Support-------------------- 
Aethas Aethas_BOT;

WLB_Analyse WLB_BOT[];


Ave Ave_BOT;



CopyCat CopyCat_BOT[];
double CopyCat_PROFITS[];
double CopyCat_highest[];
int CopyCat_highest_i[]; 

Garen Garen_BOT[];
double Garen_PROFITS[];
double Garen_highest[];
int Garen_highest_i[]; 



//double SIM_Volume = 10000.0;


