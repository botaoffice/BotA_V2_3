
//+------------------------------------------------------------------+
//|                                                TI_TSL_Global.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+


#include <BOTAV2_3/Carry/TI_TSL.mqh>

//--------------------------------------------------------------
//                            TI-METHODS
//--------------------------------------------------------------



TI_TSL TI_BOT[]; 


void init_TI_BOT(string type){
   ArrayResize(TI_BOT,0);
   
   uchar char_type[];
   StringToCharArray(type,char_type);
   
      int target = ArraySize(CopyCat_BOT);
      if(Detail == 4){
         target=1;
      }
      for(int i=0;i<target;i++){
         //AH11_Garen||8_8|630060152170231_CC11_T162301
         //AH12_Garen||8_8|150150052170241_CC11_T260101
         
         //NH12_Garen||14_5|420040221160221_CC22_T162400
         int l=int(CharToString(char_type[1]));
         int m=int(CharToString(char_type[2]));
         int n=int(CharToString(char_type[3]));
         int o=int(CharToString(char_type[4]));
         int p=int(CharToString(char_type[5]));
         int q=int(CharToString(char_type[6]));
         int r=int(CharToString(char_type[7]));
         if(Detail == 4){
            for(l=0;l<5;l++){
            for(m=0;m<9;m++){
            for(n=0;n<5;n++){
            for(o=1;o<5;o++){
            //for(p=0;p<3;p++){
            //for(q=0;q<2;q++){
            for(r=0;r<3;r++){
            if(l==4){
               //m=0;
               n=4;
               o=4;
               r=2;
            }

            double tp_factor =1+m*0.5;
   
            if(m==7){
               tp_factor=99;
            }
            ENUM_TIMEFRAMES period = PERIOD_M1;
            if(n==1){
               period = PERIOD_M5;
            }
            if(n==2){
               period = PERIOD_M15;
            }
            if(n==3){
               period = PERIOD_M30;
            }
            if(n==4){
               period = PERIOD_H1;
            }
            if(n==5){
               period = PERIOD_H4;
            }
            //---------------------------------------------------------------------------------------------
                     //      |Name                       |  Period      |
            create_TI_BOT("TI"+string(l)+string(m)+string(n) +string(o)+string(p)+string(q)    , period    ,      //CopyCat_BOT[i].name +
                     //      |TSL_CandleCount            | WLB_percent  | TP_Factor |  TSL_Bonus|ExcuseRule|   Percent_Save
                              o                          , 0.05         , tp_factor , 0          ,      p   , r);
            //--------------------------------------------------------------------------------------------- 
            }}}}}//}}
         }
         else{
            double tp_factor =1+m*0.5;
   
            if(m==7){
               tp_factor=99;
            }
            ENUM_TIMEFRAMES period = PERIOD_M1;
            if(n==1){
               period = PERIOD_M5;
            }
            if(n==2){
               period = PERIOD_M15;
            }
            if(n==3){
               period = PERIOD_M30;
            }
            if(n==4){
               period = PERIOD_H1;
            }
            if(n==5){
               period = PERIOD_H4;
            }
            //---------------------------------------------------------------------------------------------
                     //      |Name                       |  Period      |
            create_TI_BOT("TI"+string(l)+string(m)+string(n) +string(o)+string(p)+string(q)    , period    ,      //CopyCat_BOT[i].name +
                     //      |TSL_CandleCount            | WLB_percent  | TP_Factor |  TSL_Bonus|ExcuseRule|Percent_Save
                              o                          , 0.05         , tp_factor , 0          ,      p  ,r);
            //--------------------------------------------------------------------------------------------- 
         }
      }
   
   //Print(ArraySize(TI_BOT),"TI Bots");
}

void create_TI_BOT(string Name,ENUM_TIMEFRAMES P,
                     int tsl_cc, double WLB_percent,double tp_factor,double tsl_bonus,int ExcuseRule, int Percent_Save){
   int size = ArraySize(TI_BOT);
   ArrayResize(TI_BOT,size+1);
   
   //Aethas *this_aethas =& Aethas_BOT;
   //TI_BOT[size].set_Aethas(this_aethas);
   
   bool clear_et = false;
   bool fill_et  = false;

   if(ExcuseRule==1){
      clear_et = true;
      fill_et  = false;
   }
   if(ExcuseRule==2){
      clear_et = false;
      fill_et  = true;
   } 
   
   TI_BOT[size] = TI_TSL(Name,P,tsl_cc,WLB_percent,tp_factor,tsl_bonus,clear_et,fill_et,Percent_Save);              
}

