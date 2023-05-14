
#include "TI_TSL_Global.mqh"
#include "CopyCat_Global.mqh"
#include <BOTAV2_3/Global/Garen_Global.mqh>
#include <BOTAV2_3/Global/WLB_Global.mqh>
#include <BOTAV2_3/Global/SIM_Global.mqh>
#include <BOTAV2_3/Global/Save_Global.mqh>

//#include <BOTAV2_3/GUI/AVE_GUI.mqh>

#include <BOTAV2_3/MISC/NEWS.mqh>
#include <BOTAV2_3/MISC/MISC.mqh>
#include <BOTAV2_3/Global/BotA_Enums.mqh>
#include <BOTAV2_3/Global/BotA_Extern.mqh>
#include "Global_Var.mqh"
#include <BOTAV2_3/Global/Sleeptime_Global.mqh>



int check_Timeframe(){
   if(Period()==1){
      TimeFrame = PERIOD_M1;
      return(1);
   }
   if(Period()==5){
      TimeFrame = PERIOD_M5;
      return(2);
   }
   if(Period()==15){
      TimeFrame = PERIOD_M15;
      return(3);
   }
   if(Period()==30){
      TimeFrame = PERIOD_M30;
      return(4);
   }
   if(Period()==60){
      TimeFrame = PERIOD_H1;
      return(5);
   }
   if(Period()==240){
      TimeFrame = PERIOD_H4;
      return(6);
   }
   return(0);
}
void init_BOTs(){
   //Print("BOT_INIT");
   string sep="_";                
   ushort u_sep;
   u_sep=StringGetCharacter(sep,0);              
   string result[]; 
   StringSplit(Type_Null,u_sep,result);
   uchar char_type[];
   StringToCharArray(result[0],char_type);
   
   
   string WLB_Type = CharToString(char_type[0]);
   int WLB_info = int(CharToString(char_type[ArraySize(char_type)-2]));
   /*if(ArraySize(char_type)>4){
      WLB_info = int(CharToString(char_type[4]));
   }*/
   

   string sep2="|";                
   ushort u_sep2;
   u_sep2=StringGetCharacter(sep2,0);              
   string result2[]; 
   StringSplit(result[1],u_sep2,result2);
   int Time1 = int(result2[2]);

   string result3[]; 
   StringSplit(result[2],u_sep2,result3);
   int Time2 = int(result3[0]);



   string garen_id = string(result3[1]);
   uchar char_garen_id[];
   StringToCharArray(garen_id,char_garen_id);
   int ispe = int(CharToString(char_garen_id[12]));
   
   string cc_id = string(result[3]);
   string ti_id = string(result[4]);
   
   
   uchar char_ave[];
   StringToCharArray(result3[2],char_ave);
   int ave_id = int(CharToStr(char_ave[0]));
   int ave_id2 = int(CharToStr(char_ave[1]));
   int ave_id3 = int(CharToStr(char_ave[2]));
   
   int is_DL =  int(string(result3[3]));
   if(Detail==0){
      init_WLB_BOT(TimeFrame,WLB_Type,4,ispe);// WLB_Type
   }
   else{
      init_WLB_BOT(TimeFrame,WLB_Type,WLB_info,ispe);// WLB_Type
   }
   init_Garen_BOT(Time1,Time2,garen_id,is_DL,ave_id,ave_id2,ave_id3);
   init_CopyCat_BOT(cc_id,ti_id);
   init_TI_BOT(ti_id);


   for(int i=0;i<ArraySize(WLB_BOT);i++){
      string help = WLB_BOT[i].get_name();
      StringSplit(help,u_sep,result);
      for(int j=0;j<ArraySize(Garen_BOT);j++){      
         if(StringFind(Garen_BOT[j].get_name(),result[0],0)>=0){
            Garen *new_garen =& Garen_BOT[j];
            WLB_BOT[i].Add_Garen(new_garen);
         }
      }
   }
   
   if(Detail==3 || Detail==4){
      for(int i=0;i<ArraySize(CopyCat_BOT);i++){
         CopyCat *this_CC =& CopyCat_BOT[i];
         Garen_BOT[0].Add_CopyCat(this_CC);
         this_CC.set_Excuse_TIME(Garen_BOT[0].get_Excuse_TIME());
         this_CC.set_UseBEClose(Garen_BOT[0].get_UseBEClose());
      }
   }
   else{
      for(int i=0;i<ArraySize(CopyCat_BOT);i++){
         CopyCat *this_CC =& CopyCat_BOT[i];
         Garen_BOT[i].Add_CopyCat(this_CC);
         this_CC.set_Excuse_TIME(Garen_BOT[i].get_Excuse_TIME());
         this_CC.set_UseBEClose(Garen_BOT[i].get_UseBEClose());
      }
   }
   
   for(int i=0;i<ArraySize(CopyCat_BOT);i++){
      TI_TSL *this_ti =& TI_BOT[i];
      CopyCat_BOT[i].set_TI_BOT(this_ti);// =& TI_BOT[i];
      CopyCat_BOT[i].set_has_TI(true);
   }  
}


void clear(bool clearDrawing){
   for(int i = 0;i<ArraySize(WLB_BOT);i++){
      WLB_BOT[i].clear(clearDrawing);
   }
   for(int i = 0;i<ArraySize(Garen_BOT);i++){
      Garen_BOT[i].clear();
   }
   for(int i = 0;i<ArraySize(CopyCat_BOT);i++){
      CopyCat_BOT[i].clear();
   }
   if(clearDrawing){
      ObjectsDeleteAll();
   }
   PrintManager.close();
   
   EventKillTimer();
}


void BOT_TICK(datetime time,double ask,double bid){
   int new_candle = Aethas_BOT.tick(time,ask,bid);
   if(new_candle>=60){
      if(new_candle>=60*4){
         if(new_candle>=60*24){
         init_daysleeptime();
            if(!SIMULATION){
               init_newssleeptime();
            }
            print_BotStatus();
         }
      }
   }
   
   Ave_BOT.tick(time,ask,bid);
   
   for(int i =0;i<ArraySize(WLB_BOT);i++){
      WLB_BOT[i].tick(time,ask,bid);
   }
   for(int i =0;i<ArraySize(Garen_BOT);i++){
      Garen_BOT[i].tick(time,ask,bid);
   }
   for(int i =0;i<ArraySize(CopyCat_BOT);i++){
      if(Dynamic_LOT){
         if(SIMULATION){
            CopyCat_BOT[i].set_Lot(calc_lot(DL_Divider,CopyCat_BOT[i].get_SIM_Volume()));
         }
         else{
            CopyCat_BOT[i].set_Lot(calc_lot(DL_Divider,AccountEquity()));
         }
      }
      CopyCat_BOT[i].tick(time,ask,bid);
   }
   for(int i =0;i<ArraySize(TI_BOT);i++){
      TI_BOT[i].tick(time,ask,bid);
   }
}

void print_BotStatus(){
   get_top_GarenProfits();
   get_top_GarenPoints();
   get_top_CopyCatProfits();
   if(Print_Status){
      PrintCopyCatStatus(10);
   }
   get_top_CopyCatPoints();
   if(Print_Status){
      PrintCopyCatStatus(10);
   }   
}