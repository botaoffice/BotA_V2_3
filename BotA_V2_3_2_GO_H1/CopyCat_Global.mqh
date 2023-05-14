

//+------------------------------------------------------------------+
//|                                               CopyCat_Global.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+

#include <BOTAV2_3/Jungler/CopyCat.mqh>

//--------------------------------------------------------------
//                            CopyCat-METHODS
//--------------------------------------------------------------

void init_CopyCat_BOT(string type,string ti_type,int lot_id){

   //H30_1413_CC12 -false
   //H15_1423_CC21 -true

   uchar char_type[];
   StringToCharArray(type,char_type);
   
   uchar char_titype[];
   StringToCharArray(ti_type,char_titype);

   //ArrayResize(CopyCat_PROFITS,0);
   //ArrayResize(CopyCat_highest,0);
   //ArrayResize(CopyCat_highest_i,0);   

   //ArrayResize(CopyCat_BOT,0);
   
      //for(int i=0;i<ArraySize(Garen_BOT);i++){
         //AH11_Garen||8_8|630060152170231_CC11_T162301
         //AH12_Garen||8_8|150150052170241_CC11_T260101
         
         //NH12_Garen||14_5|420040221160221_CC22_T162400
         int j=int(CharToString(char_type[2])); 
         int k=int(CharToString(char_type[3])); 

         int l=int(CharToString(char_titype[1]));
         int m=int(CharToString(char_titype[2]));
         int n=int(CharToString(char_titype[3]));
         int o=int(CharToString(char_titype[4]));
         int p=int(CharToString(char_titype[5]));
         int q=int(CharToString(char_titype[6]));
         int r=int(CharToString(char_titype[7]));

         if(Detail == 3){
            for(j=0;j<5;j++){
            for(k=1;k<5;k++){
               if(j==0){
                  k=5;
               }
               double fed = 0.24*l;
            
            bool useghostcarry=true;
            if(q==0){
               useghostcarry=true;
            }
            //---------------------------------------------------------------------------------------------
                     //      |Name                        |  Period  |
            create_CopyCat_BOT(Garen_BOT[ArraySize(Garen_BOT)-1].get_name() +"_CC"+string(j)+string(k) + "_T" + string(l) + string(m)  + string(n) + string(o) + string(p)+ string(q)+string(r)  , Garen_BOT[ArraySize(Garen_BOT)-1].get_P(),
                      
                      //   ExcuseTime| UseDark  | UseFed | UseFastClose |                     UseBEClose
                                Garen_BOT[ArraySize(Garen_BOT)-1].get_Excuse_TIME()  , false    ,   fed   ,   9999999, Garen_BOT[ArraySize(Garen_BOT)-1].get_UseBEClose(),  useghostcarry,
                      //   ActiveTarget|DeactiveTarget
                                j      ,     k ,lot_id);
            //--------------------------------------------------------------------------------------------- 

            }}
         }
         else{
            if(Detail == 4){
               //AH11_Garen||8_8|630060152170231_CC11_T251201
               /*j=1; 
               k=1; */
         
               for(l=0;l<5;l++){
               //for(m=0;m<8;m++){
               for(n=0;n<5;n++){
               for(o=1;o<5;o++){
               for(r=0;r<3;r++){
                  if(l==4){
                     m=7;
                     n=4;
                     o=4;
                     r=2;
                  }
               //for(p=0;p<3;p++){
               //for(q=0;q<2;q++){
               
                  double fed = 0.25*l;
                  bool useghostcarry=true;
                  if(q==0){
                     useghostcarry=true;
                  }
                  //---------------------------------------------------------------------------------------------
                           //      |Name                        |  Period  |
                  create_CopyCat_BOT(Garen_BOT[ArraySize(Garen_BOT)-1].get_name() +"_CC"+string(j)+string(k) + "_T" + string(l) + string(m)  + string(n) + string(o) + string(p)+ string(q)+string(r)  , Garen_BOT[ArraySize(Garen_BOT)-1].get_P(),
                            
                            //   ExcuseTime| UseDark  | UseFed | UseFastClose |                     UseBEClose
                                      Garen_BOT[ArraySize(Garen_BOT)-1].get_Excuse_TIME()  , false    ,   fed   ,   9999999, Garen_BOT[ArraySize(Garen_BOT)-1].get_UseBEClose(),  useghostcarry,
                            //   ActiveTarget|DeactiveTarget
                                      j      ,     k ,lot_id);
                  //--------------------------------------------------------------------------------------------- 
               }}}}//}//}//}
            }
            else{
               double fed = 0.24*l;
               
               
               bool useghostcarry=true;
               if(q==0){
                  useghostcarry=true;
               }
               //---------------------------------------------------------------------------------------------
                        //      |Name                        |  Period  |
               create_CopyCat_BOT(Garen_BOT[ArraySize(Garen_BOT)-1].get_name() +"_CC"+string(j)+string(k) + "_T" + string(l) + string(m)  + string(n) + string(o) + string(p)+ string(q)+string(r)  , Garen_BOT[ArraySize(Garen_BOT)-1].get_P(),
                         
                         //   ExcuseTime| UseDark  | UseFed | UseFastClose |                     UseBEClose
                                   Garen_BOT[ArraySize(Garen_BOT)-1].get_Excuse_TIME()  , false    ,   fed   ,   9999999, Garen_BOT[ArraySize(Garen_BOT)-1].get_UseBEClose(),  useghostcarry,
                         //   ActiveTarget|DeactiveTarget
                                   j      ,     k ,lot_id);
               //--------------------------------------------------------------------------------------------- 
         }
      }
   //}

      
   //Print(ArraySize(CopyCat_BOT),"CopyCat Bots");
}

void create_CopyCat_BOT(string Name,ENUM_TIMEFRAMES P,
               int Excuse_Time,bool UseDark, double UseFed, int UseFastClose, bool UseBEClose,bool UGC,
               int UseActiveTarget,int UseDeactiveTarget,int lot_id){
   
   ArrayResize(CopyCat_PROFITS,ArraySize(CopyCat_PROFITS)+1);
   CopyCat_PROFITS[ArraySize(CopyCat_PROFITS)-1] = 0;
   
   ArrayResize(CopyCat_highest,ArraySize(CopyCat_highest)+1);
   CopyCat_highest[ArraySize(CopyCat_highest)-1] = 0;
   
   ArrayResize(CopyCat_highest_i,ArraySize(CopyCat_highest_i)+1);
   CopyCat_highest_i[ArraySize(CopyCat_highest_i)-1] = -2;
             
   ArrayResize(CopyCat_BOT,ArraySize(CopyCat_BOT)+1);
   
   
   bool is_active=false;
   if(UseActiveTarget == 0){
      is_active=true;
   }
   print_manager *this_pm =& PrintManager;
   CopyCat_BOT[ArraySize(CopyCat_BOT)-1] = CopyCat(Name,P,this_pm,SIMULATION,Excuse_Time,UGC,is_active,UseDark,UseFed,UseFastClose,UseBEClose,UseActiveTarget,UseDeactiveTarget,LOT);
   CopyCat_BOT[ArraySize(CopyCat_BOT)-1].set_SleepT();
   CopyCat_BOT[ArraySize(CopyCat_BOT)-1].set_Lot_Divider(lot_id);
   Ave *this_ave =& Ave_BOT;
   CopyCat_BOT[ArraySize(CopyCat_BOT)-1].set_Ave(this_ave);
   //Aethas *this_aethas =& Aethas_BOT;
   //CopyCat_BOT[ArraySize(CopyCat_BOT)-1].set_Aethas(this_aethas);// =& Aethas_BOT;
}

double help_P[];

void get_top_CopyCatProfits(){
   for(int i=0;i<ArraySize(CopyCat_BOT);i++){
      if(CopyCat_BOT[i].get_HighestProfitDelta()>1){
         CopyCat_BOT[i].set_Points(CopyCat_BOT[i].get_Profits_SUM()/CopyCat_BOT[i].get_HighestProfitDelta());
         if(CopyCat_BOT[i].get_Points()<0.5){
            CopyCat_BOT[i].set_Points(-2);
         }
      }
      else{
         CopyCat_BOT[i].set_Points(-1);
      }
   }
   
   for(int i=0;i<ArraySize(CopyCat_BOT);i++){
      CopyCat_PROFITS[i]=CopyCat_BOT[i].get_Profits_SUM();
   }
   
   ArrayResize(CopyCat_highest,0);
   ArrayCopy(CopyCat_highest,CopyCat_PROFITS);
   ArraySort(CopyCat_highest,WHOLE_ARRAY,0,MODE_DESCEND);
   
   ArrayCopy(help_P,CopyCat_PROFITS);
   for(int i =0;i<ArraySize(CopyCat_highest_i);i++){
      CopyCat_highest_i[i]=-2;
   }
   for(int i=0;i<ArraySize(CopyCat_highest);i++){
      for(int j =0;j<ArraySize(help_P);j++){
         if(CopyCat_highest[i]==help_P[j]){
            CopyCat_highest_i[i] = j; 
            help_P[j]=9999999.9999;
            break;
         }
      }
   }
}
void get_top_CopyCatPoints(){
   for(int i=0;i<ArraySize(CopyCat_BOT);i++){
      if(CopyCat_BOT[i].get_HighestProfitDelta()>1){
         CopyCat_BOT[i].set_Points(CopyCat_BOT[i].get_Profits_SUM()/CopyCat_BOT[i].get_HighestProfitDelta());
         if(CopyCat_BOT[i].get_Points()<0.5){
            CopyCat_BOT[i].set_Points(-2);
         }
      }
      else{
         CopyCat_BOT[i].set_Points(-1);
      }
      CopyCat_PROFITS[i]=CopyCat_BOT[i].get_Points();
   }
   
   ArrayResize(CopyCat_highest,0);
   ArrayCopy(CopyCat_highest,CopyCat_PROFITS);
   ArraySort(CopyCat_highest,WHOLE_ARRAY,0,MODE_DESCEND);
   //double help_P[];
   ArrayCopy(help_P,CopyCat_PROFITS);
   for(int i =0;i<ArraySize(CopyCat_highest_i);i++){
      CopyCat_highest_i[i]=-2;
   }
   for(int i=0;i<ArraySize(CopyCat_highest);i++){
      for(int j =0;j<ArraySize(help_P);j++){
         if(CopyCat_highest[i]==help_P[j]){
            CopyCat_highest_i[i] = j; 
            help_P[j]=9999999.9999;
            break;
         }
      }
   }
}
void PrintCopyCatStatus(int max){
   for(int i =0;i<ArraySize(CopyCat_highest_i);i++){ 
      if(ArraySize(CopyCat_BOT)>i){
         if(CopyCat_highest_i[i]>=0 && CopyCat_highest_i[i]<=ArraySize(CopyCat_BOT)){
            
            if(i<max){
               Print("#",string(i+1),": ",string(CopyCat_highest_i[i]) ," ",CopyCat_BOT[CopyCat_highest_i[i]].get_name(), 
               
                  "|P= ",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_Profits_SUM(),2)), 
                  "|Ppip= ",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_Profits_Pip(),2)),  
                  "|Psim= ",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_Profits_SIM(),2)),    
                  "|SIMV= ",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_SIM_Volume(),2)),      
                  "|HL= ",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_highest_Loss(),2)),        
                  "|HP= ",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_highest_P(),2)),      
                  "|HDD=",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_highest_DD(),2)),
                  "|HPD=",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_HighestProfitDelta(),2)),
                  "|Poi=",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_Points(),2)),
                  "|HPoi=",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_HighestPoints(),2)),
                  "|OSum=",string(calc_round(CopyCat_BOT[CopyCat_highest_i[i]].get_OrderSum_i(),2))
                  //,       
                  //"|PS=",string(calc_round(Garen_BOT[Garen_highest_i[i]].g_Profits_SELL,2)),        
                  //"|HLC=",string(calc_round(Garen_BOT[Garen_highest_i[i]].g_HighestLossCombo,2)),  
                  //"|HPC=",string(calc_round(Garen_BOT[Garen_highest_i[i]].g_HighestProfitCombo,2))
                  ); 
            }
            else{
               break;
            }
         }
      }
   }
   if(writeResult){
      for(int i =0;i<ArraySize(CopyCat_BOT);i++){ 
         bool last = false;
         if(i==ArraySize(CopyCat_BOT)-1){
            last=true;
         }
         PrintManager.write_result(last, string(CopyCat_BOT[i].get_name()),
                                    string(calc_round(CopyCat_BOT[i].get_Profits_SUM(),2)),     
                                    string(calc_round(CopyCat_BOT[i].get_highest_Loss(),2)), 
                                    string(calc_round(CopyCat_BOT[i].get_highest_P(),2)),  
                                    string(calc_round(CopyCat_BOT[i].get_highest_DD(),2)),     
                                    string(calc_round(CopyCat_BOT[i].get_HighestProfitDelta(),2)),      
                                    string(calc_round(CopyCat_BOT[i].get_Points(),2)),   
                                    string(calc_round(CopyCat_BOT[i].get_HighestPoints(),2)),
                                    string(Aethas_BOT.getTime(PERIOD_M1,0)),"","",
                                    string(calc_round(CopyCat_BOT[i].get_Profits_Pip(),2)),     
                                    string(calc_round(CopyCat_BOT[i].get_Profits_SIM(),2)),
                                    string(calc_round(CopyCat_BOT[i].get_SIM_Volume(),2)),
                                    string(calc_round(CopyCat_BOT[i].get_OrderSum_i(),2)));
                                    //string(calc_round(CopyCat_BOT[i].D1_highest_P,2)),  
                                    //string(calc_round(CopyCat_BOT[i].D1_highest_DD,2)),     
                                    //string(calc_round(CopyCat_BOT[i].D1_HighestProfitDelta,2)),
                                    //string(Aethas_BOT.getTime(PERIOD_M1,0)),"");

      }
   }
}

