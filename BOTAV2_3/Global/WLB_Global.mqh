//+------------------------------------------------------------------+
//|                                                   WLB_Global.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+

#include <BOTAV2_3/Support/WLB_Analyse.mqh>

//--------------------------------------------------------------
//                            WLB-METHODS
//--------------------------------------------------------------
void init_WLB_BOT(ENUM_TIMEFRAMES this_TimeFrame,string this_WLB_Type,int this_i,int ispe){
   ArrayResize(WLB_BOT,0);
   if(Detail == 0){
      for(int i =0;i<3;i++){
         if(i==0){
            this_WLB_Type="N";
         }
         if(i==1){
            this_WLB_Type="A";
         }
         if(i==2){
            this_WLB_Type="H";
         }
         
         double pe_val = 50;
         int mode = 0;
         if(ispe == 2){ 
            for(int j =0;j<5;j++){
               pe_val = 30 + j*10;
               set_WLB_BOT(this_TimeFrame,this_WLB_Type,j,mode,pe_val);
            }
         }
         else{
            for(mode =0;mode<2;mode++){
               set_WLB_BOT(this_TimeFrame,this_WLB_Type,mode,mode,pe_val);
            } 
         }
      }
   }
   else{
      int i = this_i;
      int mode = 0;
      double pe_val = 50;
      if(ispe==2){
         pe_val = 30 + i*10;
      }
      else{
         mode = this_i;
      }

      set_WLB_BOT(this_TimeFrame,this_WLB_Type,i,mode,pe_val); 
   }
   //Print(ArraySize(WLB_BOT),"WLB Bots");
}      
      
void set_WLB_BOT(ENUM_TIMEFRAMES this_TimeFrame,string this_WLB_Type,int this_i,int mode,double pe_val){      
      if(this_TimeFrame == PERIOD_M1){
      if(this_WLB_Type == "N" || this_WLB_Type == "n" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("NM01"+string(this_i)  ,  PERIOD_M1,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.05   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "A" || this_WLB_Type == "a" ){    
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("AM01"+string(this_i)  ,  PERIOD_M1,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.12   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      }

      if(this_TimeFrame == PERIOD_M5){
      if(this_WLB_Type == "N" || this_WLB_Type == "n" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("NM05"+string(this_i)  ,  PERIOD_M5,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.05   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "A" || this_WLB_Type == "a" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("AM05"+string(this_i)  ,  PERIOD_M5,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.12   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "H" || this_WLB_Type == "h" ){   
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("HM05"+string(this_i)  ,  PERIOD_M5,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.25   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      
      }
      }
      
      if(this_TimeFrame == PERIOD_M15){
      if(this_WLB_Type == "N" || this_WLB_Type == "n" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("NM15"+string(this_i)  ,  PERIOD_M15,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.05   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "A" || this_WLB_Type == "a" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("AM15"+string(this_i)  ,  PERIOD_M15,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.12   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      
      if(this_WLB_Type == "H" || this_WLB_Type == "h" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("HM15"+string(this_i)  ,  PERIOD_M15,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.25   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      }
      
      if(this_TimeFrame == PERIOD_M30){
      //---------------------------------------------------------------------------------------------
      if(this_WLB_Type == "N" || this_WLB_Type == "n" ){
               //       Name        |    Period
      create_WLB_BOT("NM30"+string(this_i)  ,  PERIOD_M30,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.05   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "A" || this_WLB_Type == "a" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("AM30"+string(this_i)  ,  PERIOD_M30,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.12   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "H" || this_WLB_Type == "h" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("HM30"+string(this_i)  ,  PERIOD_M30,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.25   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      }
      if(this_TimeFrame == PERIOD_H1){
      //---------------------------------------------------------------------------------------------
      if(this_WLB_Type == "N" || this_WLB_Type == "n" ){
               //       Name        |    Period
      create_WLB_BOT("NH1"+string(this_i)  ,  PERIOD_H1,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.05   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "A" || this_WLB_Type == "a" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("AH1"+string(this_i)  ,  PERIOD_H1,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.12   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------      
      }
      if(this_WLB_Type == "H" || this_WLB_Type == "h" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("HH1"+string(this_i)  ,  PERIOD_H1,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.25   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      }
      
      
      if(this_TimeFrame == PERIOD_H4){
      //---------------------------------------------------------------------------------------------
      if(this_WLB_Type == "N" || this_WLB_Type == "n" ){
               //       Name        |    Period
      create_WLB_BOT("NH4"+string(this_i)  ,  PERIOD_H4,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.05   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "A" || this_WLB_Type == "a" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("AH4"+string(this_i)  ,  PERIOD_H4,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.12   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }
      if(this_WLB_Type == "H" || this_WLB_Type == "h" ){
      //---------------------------------------------------------------------------------------------
               //       Name        |    Period
      create_WLB_BOT("HH4"+string(this_i)  ,  PERIOD_H4,
                
                //   WLB_TO| WLB_Bonus |WLB_Percent|WLB_BodyPercent|WLB_BodyBigger|USE_PE  |  
                     999999     ,      0.00   ,    0.25   ,  0.42         ,     0.1      ,  true   ,
                
                //  Timefactor | WLB Type |PE-VAL
                    2          ,mode      ,pe_val);
      //---------------------------------------------------------------------------------------------
      }    
   }
}

void create_WLB_BOT(string Name,ENUM_TIMEFRAMES P,
               int WLB_TimeOut,double WLB_Bonus,double WLB_Percent,double WLB_BodyPercent,double WLB_BodyBigger,bool WLB_PreEntry,
               int timefactor,int WLB_mode,double PE_VAL){

   ArrayResize(WLB_BOT,ArraySize(WLB_BOT)+1);
   
   print_manager *this_pm =& PrintManager;
   //Ave *this_ave =& Ave_BOT;
   //Print("1");
   //Aethas *this_aethas =& Aethas_BOT;
   
   WLB_BOT[ArraySize(WLB_BOT)-1] = WLB_Analyse(Name,P,this_pm,WLB_TimeOut,WLB_Bonus,WLB_Percent,WLB_BodyPercent,WLB_BodyBigger,PE_VAL,WLB_mode);                                     
}



