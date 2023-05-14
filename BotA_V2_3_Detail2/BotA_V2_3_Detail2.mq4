//+------------------------------------------------------------------+
//|                                               BotA_V2_1_Tank.mq4 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

/*TODO:
   DONE - tsl min 50% of maxprofit
   carry mit timer / FastClose
   All SL handling to carry ... vllt ah ned
   
   DONE - pip-safe/sim-profit bei real
   DONE - Volume/Lot check
   DONE - Ave add minspeed & remove dl
*/


#include <BOTAV2_3/Global/Global.mqh>

int OnInit(){
   clear(clear_drawings);
   
   
   PrintManager = print_manager(FileName,writeData,writeTick,writeLog,writeResult);
   PrintManager.open();
   
   GUI = Bota_GUI();
   GUI.init_gui();

   string needed_TF_0="1";
   string needed_TF_1="1";
   string needed_TF_2="0";
   string needed_TF_3="0";
   string needed_TF_4="0";
   string needed_TF_5="0";

   int result = check_Timeframe();
   if(result ==0){Print("Something wrong in checktimeframe");}
   if(result ==1){needed_TF_0 = "1";}
   if(result ==2){needed_TF_1 = "1";}
   if(result ==3){needed_TF_2 = "1";}
   if(result ==4){needed_TF_3 = "1";}
   if(result ==5){needed_TF_4 = "1";}
   if(result ==6){needed_TF_5 = "1";}
   if(Detail == 4){
      needed_TF_0="1";
      needed_TF_1="1";
      needed_TF_2="1";
      needed_TF_3="1";
      needed_TF_4="1";
      //string needed_TF_5="1";
   }
   else{
      string sep="_";                
      ushort u_sep;
      u_sep=StringGetCharacter(sep,0);              
      string ti_result[]; 
      StringSplit(Type_Null,u_sep,ti_result);
      //string ti_id = string(result[4]);
      uchar char_type[];
      StringToCharArray(ti_result[4],char_type);
      int n = int(CharToString(char_type[3]));
      if(n==0){
         needed_TF_0="1";
      }
      if(n==1){
         needed_TF_1="1";
      }
      if(n==2){
         needed_TF_2="1";
      }
      if(n==3){
         needed_TF_3="1";
      }
      if(n==4){
         needed_TF_4="1";
      }
      if(n==5){
         needed_TF_5="1";
      }
   }
   
   string full_aethas_id = needed_TF_0 + needed_TF_1 + needed_TF_2 + needed_TF_3 + needed_TF_4 + needed_TF_5 + "0" + "0" + "0";
   Aethas_BOT = Aethas(100,full_aethas_id);
   //Print("AETHAS init done");
   
   Ave_BOT = Ave("Ave_BOT",PERIOD_M5,100,full_aethas_id);

   SaveManager = save_manager(FileName);
   
   if(SIMULATION){ 
      sim_init(0);
  
      GUI.setPanel("STOP");
   }
   Print("WLB:",ArraySize(WLB_BOT),"|G:",ArraySize(Garen_BOT),"|CC:",ArraySize(CopyCat_BOT),"|TI:",ArraySize(TI_BOT));
   
   return(INIT_SUCCEEDED);
}
void OnDeinit(const int reason){
   clear(true);
}

void OnTick(){
}


