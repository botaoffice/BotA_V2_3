//+------------------------------------------------------------------+
//|                                                    SLEEPTIME.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

class timewindow{
   public:
   
      datetime TimeStart;
      datetime TimeEnd;
      
      timewindow(void);
      ~timewindow(void);
      timewindow(datetime s, datetime e);
};

timewindow::timewindow(){}
timewindow::~timewindow(){}
timewindow::timewindow(datetime s, datetime e){
   TimeStart = s;
   TimeEnd = e;
}

class sleeptime{
   public:
      timewindow TimeWindows[];
      
      sleeptime(void);
      ~sleeptime(void);

      void addwindow(datetime s,datetime e);
      
      bool check_time(datetime ckecktime);
      
      void addNEWSwindow(datetime newstime,int start_offset,int end_offset);
      void clear_windows();
};

sleeptime::sleeptime(){}
sleeptime::~sleeptime(){
   ArrayFree(TimeWindows);
}


void sleeptime::addwindow(datetime s,datetime e){
   ArrayResize(TimeWindows,ArraySize(TimeWindows)+1);
   TimeWindows[ArraySize(TimeWindows)-1] = timewindow(s,e);
}


void sleeptime::addNEWSwindow(datetime newstime,int start_offset,int end_offset){
   addwindow(newstime-start_offset,newstime+end_offset);
}

bool sleeptime::check_time(datetime ckecktime){
   for(int i =0;i<ArraySize(TimeWindows);i++){
      if(TimeWindows[i].TimeStart<ckecktime && TimeWindows[i].TimeEnd>ckecktime){
         //Print(ckecktime," found in ",TimeWindows[i].TimeStart, "|",TimeWindows[i].TimeEnd );
         return(false);
      }
   }
   return(true);
}

void sleeptime::clear_windows(){
   ArrayFree(TimeWindows);
   ArrayResize(TimeWindows,0);
}


