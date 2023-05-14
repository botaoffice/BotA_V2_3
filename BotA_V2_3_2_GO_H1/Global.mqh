
#include "TI_TSL_Global.mqh"
#include "CopyCat_Global.mqh"
#include "Garen_Global.mqh"
#include "WLB_Global.mqh"
#include <BOTAV2_3/Global/SIM_Global.mqh>
#include <BOTAV2_3/Global/Save_Global.mqh>

#include <BOTAV2_3/GUI/Dali.mqh>
#include <BOTAV2_3/GUI/AVE_GUI.mqh>

#include <BOTAV2_3/MISC/NEWS.mqh>
#include <BOTAV2_3/MISC/MISC.mqh>
#include <BOTAV2_3/Global/BotA_Enums.mqh>
#include "BotA_Extern.mqh"
#include "Global_Var.mqh"
#include <BOTAV2_3/Global/Sleeptime_Global.mqh>



double VOLUME_SUM = 10000.0;
double last_VOLUME_SUM = 0.0;
/*double highest_DD_percent =0.0;
double highest_DeltaDay = 0.0;
double highest_DeltaDay_percent =0.0;*/

int rip_counter = 0;

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
   ArrayResize(Garen_PROFITS,0);
   ArrayResize(Garen_highest,0);
   ArrayResize(Garen_highest_i,0);   
   ArrayResize(Garen_BOT,0);
   
   ArrayResize(CopyCat_PROFITS,0);
   ArrayResize(CopyCat_highest,0);
   ArrayResize(CopyCat_highest_i,0);   
   ArrayResize(CopyCat_BOT,0);
   
   ArrayResize(TI_BOT,0);
   ArrayResize(WLB_BOT,0);
   
   int panel_id = 0;
   ENUM_TIMEFRAMES this_TF = PERIOD_H1;
   
   
   
   
   int pos=0;
   string Bot_ID[1];
   //##############MO##############
   //--------------E---------------
   //Bot_ID[pos] = "HH11_Garen||2_6|540070131560162|392|0_CC23_T1042211_10";pos++;ArrayResize(Bot_ID,pos+1);// 15       //Link            5      
   Bot_ID[pos] = "AH10_Garen||1_6|180171141510172|793|1_CC33_T3022211_10";pos++;ArrayResize(Bot_ID,pos+1);//  8     //DarkLink           3  
   //--------------PE--------------
   Bot_ID[pos] = "AH11_Garen||1_7|350080141570271|392|0_CC31_T1021211_10";pos++;ArrayResize(Bot_ID,pos+1);//6        //Link              2  
   Bot_ID[pos] = "NH14_Garen||3_5|101050131160221|694|1_CC42_T3043212_10";pos++;ArrayResize(Bot_ID,pos+1);//10        //DarkLink          4 
   //##############LD##############
   //--------------E---------------
   Bot_ID[pos] = "HH10_Garen||5_7|173081131580172|493|0_CC23_T1041210_10";pos++;ArrayResize(Bot_ID,pos+1);//12        //Link               4
   Bot_ID[pos] = "HH10_Garen||7_5|510060153530122|794|1_CC24_T3004212_10";pos++;ArrayResize(Bot_ID,pos+1);//6        //DarkLink            2
   //--------------PE--------------
   //Bot_ID[pos] = "AH13_Garen||7_8|380170122570241|292|0_CC12_T2041212_4";pos++;ArrayResize(Bot_ID,pos+1);//11        //Link              4  
   //Bot_ID[pos] = "HH10_Garen||9_3|672171153120231|692|1_CC13_T2011210_5";pos++;ArrayResize(Bot_ID,pos+1);//13        //DarkLink          5 
   //##############NY##############
   //--------------E---------------
   Bot_ID[pos] = "HH10_Garen||13_6|623161153480142|796|0_CC13_T2003212_5";pos++;ArrayResize(Bot_ID,pos+1);//2       //Link                1
   Bot_ID[pos] = "HH11_Garen||15_3|130130133580112|494|1_CC34_T3033210_10";pos++;ArrayResize(Bot_ID,pos+1);//15       //DarkLink           5
   //--------------PE--------------
   //Bot_ID[pos] = "NH13_Garen||14_6|110030132580241|493|0_CC32_T1042210_8";pos++;ArrayResize(Bot_ID,pos+1);//24      //Link                 8
   //Bot_ID[pos] = "HH11_Garen||15_3|120130121570211|793|1_CC24_T1002212_2";pos++;ArrayResize(Bot_ID,pos+1);//6     //DarkLink              2
   //##############EV##############
   //--------------E---------------
   Bot_ID[pos] = "NH10_Garen||18_6|210081112580122|592|0_CC22_T2014210_10";pos++;ArrayResize(Bot_ID,pos+1);//8      //Link                  3
   Bot_ID[pos] = "AH11_Garen||17_7|582160153240162|692|1_CC11_T1003212_10";pos++;ArrayResize(Bot_ID,pos+1);//11      //DarkLink            4
   //--------------PE--------------
   //Bot_ID[pos] = "NH13_Garen||18_6|127170151580261|693|0_CC13_T1022212_5";pos++;ArrayResize(Bot_ID,pos+1); //15     //Link               5  
   Bot_ID[pos] = "AH12_Garen||20_4|217080143460271|492|1_CC13_T1031211_10";//32       //DarkLink                                          10
   
   

   /*string this_Bot_ID[];
   int size=0;
   if(MO_E_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(MO_E_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(MO_PE_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(MO_PE_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   
   if(LD_E_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(LD_E_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(LD_PE_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(LD_PE_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(NY_E_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(NY_E_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(NY_PE_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(NY_PE_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   
   if(EV_E_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(EV_E_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(EV_PE_L){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   if(EV_PE_D){
      size++;
      ArrayResize(this_Bot_ID,size);
      this_Bot_ID[size-1]=Bot_ID[size-1];
   }
   */
   
   
      
   for(int i=0;i<ArraySize(Bot_ID);i++){
      string sep="_";                
      ushort u_sep;
      u_sep=StringGetCharacter(sep,0); 
      string sep2="|";
      ushort u_sep2;
      u_sep2=StringGetCharacter(sep2,0); 
                   
      string result[]; 
      
      StringSplit(Bot_ID[i],u_sep,result);
      uchar char_type[];
      StringToCharArray(result[0],char_type);
      
      
      string WLB_Type = CharToString(char_type[0]);
      int WLB_info = int(CharToString(char_type[3]));
      if(ArraySize(char_type)>4){
         WLB_info = int(CharToString(char_type[4]));
      }
      ENUM_TIMEFRAMES WLB_timeframe = PERIOD_H1;
      if(StringFind(result[0],"M15",0)>=0){
         WLB_timeframe = PERIOD_M15;
      }   
      else{
         if(StringFind(result[0],"M1",0)>=0){
            WLB_timeframe = PERIOD_M1;
         }
         else{
            if(StringFind(result[0],"M5",0)>=0){
               WLB_timeframe = PERIOD_M5;
            }
            else{
               if(StringFind(result[0],"M30",0)>=0){
                  WLB_timeframe = PERIOD_M30;
               }
               else{
                  if(StringFind(result[0],"H1",0)>=0){
                     WLB_timeframe = PERIOD_H1;
                  }
                  else{
                     if(StringFind(result[0],"H4",0)>=0){
                        WLB_timeframe = PERIOD_H4;
                     }
                     else{
                        Print(StringFind(result[0],"H1",0));
                     }
                  }
               }
            }
         }
      }
                   
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
      int lot_id = int(result[5]);
      
      uchar char_ave[];
      StringToCharArray(result3[2],char_ave);
      int ave_id = int(CharToStr(char_ave[0]));
      int ave_id2 = int(CharToStr(char_ave[1]));
      int ave_id3 = int(CharToStr(char_ave[2]));
      
      int is_DL =  int(string(result3[3]));

      init_WLB_BOT(WLB_timeframe,WLB_Type,WLB_info,ispe);// WLB_Type
      init_Garen_BOT(Time1,Time2,garen_id,is_DL,ave_id,ave_id2,ave_id3);
      init_CopyCat_BOT(cc_id,ti_id,lot_id);
      init_TI_BOT(ti_id);
   }
   //Dali_BOT.free_CC();
   for(int i=0;i<ArraySize(Bot_ID);i++){
      Garen *new_garen =& Garen_BOT[i];
      WLB_BOT[i].Add_Garen(new_garen);
      CopyCat *this_CC =& CopyCat_BOT[i];
      Garen_BOT[i].Add_CopyCat(this_CC);
      this_CC.set_Excuse_TIME(Garen_BOT[i].get_Excuse_TIME());
      this_CC.set_UseBEClose(Garen_BOT[i].get_UseBEClose());
      TI_TSL *this_ti =& TI_BOT[i];
      CopyCat_BOT[i].set_TI_BOT(this_ti);// =& TI_BOT[i];
      CopyCat_BOT[i].set_has_TI(true);
      
      //Dali_BOT.add_CC(this_CC);
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
      if(!SIMULATION){
         print_BotStatus();
      }
      if(new_candle>=60*4){
         if(new_candle>=60*24){
         init_daysleeptime();
            /*if(!SIMULATION){
               init_newssleeptime();
               VOLUME_SUM = AccountBalance();
               if(last_VOLUME_SUM>0){   
                  double delta_day = VOLUME_SUM-last_VOLUME_SUM;
                  double delta_day_percent = (delta_day/last_VOLUME_SUM) * 100;
                  if(delta_day_percent<SaveManager.highest_DeltaDay_percent){
                     SaveManager.highest_DeltaDay_percent = delta_day_percent;
                  }
                  if(delta_day<SaveManager.highest_DeltaDay){
                     SaveManager.highest_DeltaDay = delta_day;
                  }
               }
               last_VOLUME_SUM = VOLUME_SUM; 
            }
            else{*/
               print_BotStatus();
            //}
         }
         else{
            double delta_v=10000.0;
            for(int i =0;i<ArraySize(CopyCat_BOT);i++){
               delta_v =  delta_v + CopyCat_BOT[i].get_Profits_SUM();
               //Print("t",string(i),"|",VOLUME_SUM);
            }
            
            
            //if(VOLUME_SUM-delta_v>0.01 && VOLUME_SUM-delta_v<99999){
               VOLUME_SUM = delta_v;
               if(last_VOLUME_SUM>0){
                  double delta_day = VOLUME_SUM-last_VOLUME_SUM;
                  double delta_day_percent = (delta_day/last_VOLUME_SUM) * 100;
                  if(delta_day_percent<SaveManager.highest_DeltaDay_percent){
                     SaveManager.highest_DeltaDay_percent = delta_day_percent;
                  }
                  if(delta_day<SaveManager.highest_DeltaDay){
                     SaveManager.highest_DeltaDay = delta_day;
                  }
               }
               last_VOLUME_SUM = VOLUME_SUM;
         }
      }
   }
   
   if(SIMULATION){
      //Print("ts|",VOLUME_SUM);
      for(int i =0;i<ArraySize(CopyCat_BOT);i++){
         CopyCat_BOT[i].set_SIM_Volume(VOLUME_SUM);
      }
   }
   
   Ave_BOT.tick(time,ask,bid);
   
   for(int i =0;i<ArraySize(WLB_BOT);i++){
      WLB_BOT[i].tick(time,ask,bid);
   }
   for(int i =0;i<ArraySize(Garen_BOT);i++){
      Garen_BOT[i].tick(time,ask,bid);
   }
   
   SaveManager.all_Profit_SUM=0;
   SaveManager.all_DD=0;
   
   for(int i =0;i<ArraySize(CopyCat_BOT);i++){
      if(Dynamic_LOT){
         if(SIMULATION){
            double new_lot = calc_lot(DL_Divider,CopyCat_BOT[i].get_SIM_Volume()) * CopyCat_BOT[i].get_Lot_Divider()/10;
            if(new_lot<0.01){
               new_lot=0.01;
            } 
            CopyCat_BOT[i].set_Lot(new_lot);
         }
         else{
            double new_lot = calc_lot(DL_Divider,AccountEquity()) * CopyCat_BOT[i].get_Lot_Divider()/10;
            if(new_lot<0.01){
               new_lot=0.01;
            } 
            CopyCat_BOT[i].set_Lot(new_lot);
         }
      }
      CopyCat_BOT[i].tick(time,ask,bid);
      
      SaveManager.all_Profit_SUM+=CopyCat_BOT[i].get_Profits_SUM();
      SaveManager.all_DD+=CopyCat_BOT[i].get_DD();
   }
   
   
   for(int i =0;i<ArraySize(TI_BOT);i++){
      TI_BOT[i].tick(time,ask,bid);
   }
   
   if(SaveManager.all_Profit_SUM>SaveManager.all_HP){
      SaveManager.all_HP=SaveManager.all_Profit_SUM;
   }
   if(SaveManager.all_DD<SaveManager.all_HDD){
      SaveManager.all_HDD=SaveManager.all_DD;
   }
   double delta = SaveManager.all_HP - SaveManager.all_Profit_SUM;
   if(delta>SaveManager.all_HPD){
      SaveManager.all_HPD=delta;
      double percent = (delta/VOLUME_SUM) * 100;
      if(percent > SaveManager.highest_DD_percent){
         SaveManager.highest_DD_percent = percent;
      }
   }
   
   
   /*if(!SIMULATION){
      Dali_BOT.update_CC(); 
   }*/
}

void print_BotStatus(){
   get_top_GarenProfits();
   get_top_GarenPoints();
   get_top_CopyCatProfits();
   /*if(Print_Status){
      PrintCopyCatStatus(ArraySize(CopyCat_BOT));
   }*/
   get_top_CopyCatPoints();
   if(Print_Status){
      PrintCopyCatStatus(ArraySize(CopyCat_BOT));
   }   
   
   if((SaveManager.all_Profit_SUM + SaveManager.all_DD)<-5000){
      Print("RIP");
      rip_counter+=1;
   }

   Print("PS:",SaveManager.all_Profit_SUM,"|HP:",SaveManager.all_HP,"|HDD:",SaveManager.all_HDD,"|HPD:",SaveManager.all_HPD,"|HPDp:",SaveManager.highest_DD_percent,"|HDeD:",SaveManager.highest_DeltaDay,"|HDeDp:",SaveManager.highest_DeltaDay_percent,"|RIP:",rip_counter);
   if(writeResult){
      PrintManager.write_result(true,
                                    string(calc_round(SaveManager.all_Profit_SUM,2)),     
                                    string(calc_round(SaveManager.all_HP,2)), 
                                    string(calc_round(SaveManager.all_HDD,2)),  
                                    string(calc_round(SaveManager.all_HPD,2)),     
                                    string(calc_round(SaveManager.highest_DD_percent,2)), 
                                    string(calc_round(SaveManager.highest_DeltaDay,2)),
                                    string(calc_round(SaveManager.highest_DeltaDay_percent,2)), "","","",   "","","","","");
   }                                 
}