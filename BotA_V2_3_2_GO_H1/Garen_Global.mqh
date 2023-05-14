//+------------------------------------------------------------------+
//|                                                 Garen_Global.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+

#include <BOTAV2_3/Tank/Garen.mqh>

//--------------------------------------------------------------
//                            Garen-METHODS
//--------------------------------------------------------------



void init_Garen_BOT(int x, int y,string type, int is_DL,int Ave_ID,int AveTimeTarget,int AveMinSpeed){
   //Print("AN: ",Ave_name);
   //ArrayResize(Garen_PROFITS,0);
   //ArrayResize(Garen_highest,0);
   //ArrayResize(Garen_highest_i,0);   

   //ArrayResize(Garen_BOT,0);
   
   uchar char_type[];
   StringToCharArray(type,char_type);
   
   //for(int i=0;i<ArraySize(WLB_BOT);i++){
      //int x = 14;
      //int y = 5; 
      
      int j=      int(CharToString(char_type[0])); 
      int k=      int(CharToString(char_type[1])); 
         int l=   int(CharToString(char_type[2])); 
      int m=      int(CharToString(char_type[3])); 
         int n=   int(CharToString(char_type[4])); 
         int o=   int(CharToString(char_type[5])); 
      int p=      int(CharToString(char_type[6])); 
            int q=int(CharToString(char_type[7])); 
            int r=int(CharToString(char_type[8])); 
            int s=int(CharToString(char_type[9])); 
            int t=int(CharToString(char_type[10])); 
            int u=int(CharToString(char_type[11])); 
  int v=          int(CharToString(char_type[12])); 
         int w=   int(CharToString(char_type[13])); 
            int z=int(CharToString(char_type[14])); 


      if(Detail == 0){
         //Entry
         for(j=1;j<9;j++){
         for(k=0;k<9;k++){
         for(m=0;m<2;m++){
         //for(is_DL=0;is_DL<2;is_DL++){
            call_create(j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,WLB_BOT[ArraySize(WLB_BOT)-1].get_P(),WLB_BOT[ArraySize(WLB_BOT)-1].get_name(),is_DL,Ave_ID,AveTimeTarget,AveMinSpeed);
         }}}//}//}
         
      }
      else{
      
      if(Detail == 1){
         //SL
         for(l=0;l<8;l++){
         for(n=3;n<9;n++){
         for(o=0;o<2;o++){
         for(w=1;w<8;w++){
            call_create(j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,WLB_BOT[ArraySize(WLB_BOT)-1].get_P(),WLB_BOT[ArraySize(WLB_BOT)-1].get_name(),is_DL,Ave_ID,AveTimeTarget,AveMinSpeed);
         }}}}
      }
      else{
      if(Detail == 2){
         //TP
         for(q=1;q<6;q++){
         for(r=1;r<4;r++){
         for(s=1;s<6;s++){
         if(l==0){
            s=5;
         }
         for(t=1;t<8;t++){
         for(z=1;z<2;z++){
         if(v==1){
            z=2;
         }
            call_create(j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,WLB_BOT[ArraySize(WLB_BOT)-1].get_P(),WLB_BOT[ArraySize(WLB_BOT)-1].get_name(),is_DL,Ave_ID,AveTimeTarget,AveMinSpeed);
         }}}}}
      }
      else{
      
      if(Detail == 6){
         //AVE
         for(Ave_ID=0;Ave_ID<10;Ave_ID++){
         for(AveTimeTarget=0;AveTimeTarget<10;AveTimeTarget++){
         for(AveMinSpeed=0;AveMinSpeed<10;AveMinSpeed++){
            /*Ave_name=string(avenum);
            if(avenum<10){
               Ave_name="0"+string(avenum);    
            }*/
         for(p=1;p<2;p++){
            call_create(j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,WLB_BOT[ArraySize(WLB_BOT)-1].get_P(),WLB_BOT[ArraySize(WLB_BOT)-1].get_name(),is_DL,Ave_ID,AveTimeTarget,AveMinSpeed);
         }}}}
      }
      else{
      if(Detail == 5){
         //TimeFrame
         for(x=1;x<24;x++){
         for(y=1;y<24;y++){
            if((x + y) <25){
               call_create(j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,WLB_BOT[ArraySize(WLB_BOT)-1].get_P(),WLB_BOT[ArraySize(WLB_BOT)-1].get_name(),is_DL,Ave_ID,AveTimeTarget,AveMinSpeed);
            }
         }}
      }
      else{
         call_create(j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,WLB_BOT[ArraySize(WLB_BOT)-1].get_P(),WLB_BOT[ArraySize(WLB_BOT)-1].get_name(),is_DL,Ave_ID,AveTimeTarget,AveMinSpeed);
      }
      }}}}
      

   //}
   //Print(ArraySize(Garen_BOT),"Garen Bots");
}


void call_create(int j,int k,int l,int m, int n, int o, int p, int q,int r,int s,int t,int u,int v,int w,int x,int y, int z,ENUM_TIMEFRAMES wlb_tf,string wlb_name,int is_DL,int Ave_ID,int Ave_TimeTarget,int Ave_MinSpeed){
   double maxloss=0;
         double maxlossfactor=0;
         if(n ==0){
            maxloss=999.0;
         }
         else{
            maxloss=1.0*n;
         }
         if(w==0){
            maxlossfactor=999.0;
         }
         else{
            maxlossfactor=0.42*w;
         }
         bool usereturn = false;  
         if(m==1){
            usereturn = true;
         }
         bool useriskentry = false;
         if(o==0){
            useriskentry=true;
         }
         bool usebeclose = false;
         if(u==0){
            usebeclose=true;
         }
         bool use_pe = true;
         bool use_e = true;
         
         if(v==1){
            use_pe=false;   
         }
         if(v==2){
            use_e=false;   
         }
         int to_faktor = 4500;
         int excuse_factor = 400;
         if(wlb_tf== PERIOD_M1){
            to_faktor = 1000;
            excuse_factor = 200*l;
         }
         if(wlb_tf== PERIOD_M5){
            to_faktor = 2000;
            excuse_factor = 600*l;
         }
         if(wlb_tf== PERIOD_M15){
            to_faktor = 4500;
            excuse_factor = 400*l;
         }
         if(wlb_tf== PERIOD_M30){
            to_faktor = 7000;
            excuse_factor = 700*l;
         }
         if(wlb_tf== PERIOD_H1){
            to_faktor = 7500;//15000
            excuse_factor = 1400*l;
         }
         if(wlb_tf== PERIOD_H4){
            to_faktor = 40000;
            excuse_factor = 3000*l;
         }
         if(l==0){
            excuse_factor = 99999999;
         }
         
         bool ape = false;
         if(z==1){
            ape=true;
         }
         /*string this_avenum = string(Ave_Num);
         if(Ave_Num<10){
            this_avenum = "0"+string(Ave_Num);
         }*/
       //---------------------------------------------------------------------------------------------
                 //      |Name          |  Period  |
                     create_Garen_BOT(wlb_name+"_Garen||"+string(x)+"_"+string(y)+"|"+string(j)+ string(k)+string(l)+string(m)+string(n)+string(o)+string(p)+string(q)+string(r)+string(s)+string(t)+string(u)+string(v)+string(w)+string(z)+"|"+string(Ave_ID)+string(Ave_TimeTarget)+string(Ave_MinSpeed)+"|"+string(is_DL) , wlb_tf,
                
                //   WLB_TO    | WLB_MT     | USE_PE | USE_E            |ExcuseTime|        UseReturn      |  UseBEClose |UseRiskEntry | WatchAve      |AVE_ID |AveTimeTarget| is Darklink
                     to_faktor *j ,   200*k   ,   use_pe   , use_e    ,   excuse_factor    ,       usereturn,        usebeclose,        useriskentry, p, Ave_ID,Ave_TimeTarget,Ave_MinSpeed,is_DL,
                      
                //   BE      | ProfitMin  | MaxLoss               | MaxLossFactor    |  SL      | TP      |SESSION |AdjustPE    
                     0.1 *q  ,   0.05*r  ,   maxloss/*4.0   + 2.0*n*/,maxlossfactor,    0.15*s    ,  0.25*t , x, y ,    ape);
      //---------------------------------------------------------------------------------------------   
}

void create_Garen_BOT(string Name,ENUM_TIMEFRAMES P,
               int WLB_TimeOut,int WLB_MinTime,bool WLB_USE_PE,bool WLB_USE_E,int Excuse_Time,bool UseReturn,bool UseBEClose,bool UseRiskEntry,int WA,int Ave_ID,int Ave_TimeTarget,int Ave_MinSpeed,int is_DL,
               double BE,double PROFITMIN,double MAXLOSS,double MAXLOSSFACTOR,double SL,double TP,int SESSION_s,int SESSION_e,bool ape){
   
   
   ArrayResize(Garen_PROFITS,ArraySize(Garen_PROFITS)+1);
   Garen_PROFITS[ArraySize(Garen_PROFITS)-1] = 0;
   
   ArrayResize(Garen_highest,ArraySize(Garen_highest)+1);
   Garen_highest[ArraySize(Garen_highest)-1] = 0;
   
   ArrayResize(Garen_highest_i,ArraySize(Garen_highest_i)+1);
   Garen_highest_i[ArraySize(Garen_highest_i)-1] = -2;
             
   ArrayResize(Garen_BOT,ArraySize(Garen_BOT)+1);
   
   
   string starttime = "0" + string(SESSION_s) + ":00";
   if(SESSION_s>9){
      starttime = string(SESSION_s) + ":00";
   }
   
   int sessionsum = SESSION_e+SESSION_s;
   string endtime = "0" + string(sessionsum) + ":00";
   if(sessionsum>9){
      endtime = string(sessionsum) + ":00";
   }
   bool use_dl = false;
   if(is_DL>0){
      use_dl = true;
   }
   
   print_manager *this_pm=&PrintManager;
   
   Ave *this_ave =& Ave_BOT;
   bool wa = false;
   bool uadl = false;
   if(WA>0){
      wa = true;
      if(WA==2){
         uadl=true;
      }
   }
   
   Aethas *this_aethas =& Aethas_BOT;
   
   Garen_BOT[ArraySize(Garen_BOT)-1] = Garen(Name,P,starttime,endtime,use_dl,this_pm,SIMULATION,Excuse_Time,UseReturn,UseBEClose,WLB_USE_E,WLB_USE_PE,WLB_TimeOut,WLB_MinTime,ape,BE,PROFITMIN,MAXLOSS,MAXLOSSFACTOR,SL,TP,UseRiskEntry,wa,uadl,Ave_ID,Ave_TimeTarget,Ave_MinSpeed);
   
   Garen_BOT[ArraySize(Garen_BOT)-1].set_Aethas(this_aethas); 
   Garen_BOT[ArraySize(Garen_BOT)-1].set_Ave(this_ave);
   
   
}
void PrintGarenStatus(int max){
   for(int i =0;i<ArraySize(Garen_highest_i);i++){ 
      if(ArraySize(Garen_BOT)>i){
         if(Garen_highest_i[i]>=0 && Garen_highest_i[i]<=ArraySize(Garen_BOT)){
            
            if(i<max){
               Print("#",string(i+1),": ",string(Garen_highest_i[i]) ," ",Garen_BOT[Garen_highest_i[i]].get_name(), 
               
                  "|P= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_Profits_SUM(),2)),   
                  "|PPip= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_Profits_Pip(),2)),         
                  "|HL= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_highest_Loss(),2)),        
                  "|HP= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_highest_P(),2)),      
                  "|HDD=",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_highest_DD(),2)),
                  "|HPD=",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_HighestProfitDelta(),2)),
                  "|Poi=",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_Points(),2)),
                  "|HPoi=",string(calc_round(Garen_BOT[Garen_highest_i[i]].get_g_HighestPoints(),2))
                  
                  //"|D1P= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].g_D1_Profits_SUM,2)),         
                  //"|D1HL= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].g_D1_highest_Loss,2)),        
                  //"|D1HP= ",string(calc_round(Garen_BOT[Garen_highest_i[i]].g_D1_highest_P,2))
                  ); 
            }
            else{
               break;
            }
         }
      }
   }
   if(writeResult){
      for(int i =0;i<ArraySize(Garen_BOT);i++){ 
         PrintManager.write_result(false, string(Garen_BOT[i].get_name()),
                                    string(calc_round(Garen_BOT[i].get_g_Profits_SUM(),2)),      
                                    string(calc_round(Garen_BOT[i].get_g_highest_Loss(),2)),
                                    string(calc_round(Garen_BOT[i].get_g_highest_P(),2)),  
                                    string(calc_round(Garen_BOT[i].get_highest_DD(),2)),     
                                    string(calc_round(Garen_BOT[i].get_g_HighestProfitDelta(),2)),      
                                    string(calc_round(Garen_BOT[i].get_g_Points(),2)),   
                                    string(calc_round(Garen_BOT[i].get_g_HighestPoints(),2)),
                                    
                                    //string(calc_round(Garen_BOT[i].g_D1_Profits_SUM,2)),      
                                    //string(calc_round(Garen_BOT[i].g_D1_highest_Loss,2)),
                                    //string(calc_round(Garen_BOT[i].g_D1_highest_P,2)),  
    
                                    //string(calc_round(Garen_BOT[i].g_D1_HighestProfitDelta,2)),      
                                    string(Aethas_BOT.getTime(PERIOD_M1,0)),"","","","","","");
      }
   }
}


void get_top_GarenProfits(){
   if(ArraySize(Garen_BOT)>0){
      for(int i=0;i<ArraySize(Garen_BOT);i++){
         if(Garen_BOT[i].get_g_HighestProfitDelta()>1){
            Garen_BOT[i].set_g_Points(Garen_BOT[i].get_g_Profits_SUM()/Garen_BOT[i].get_g_HighestProfitDelta());
            if(Garen_BOT[i].get_g_Points()<0.5){
               Garen_BOT[i].set_g_Points(-2);
            }
         }
         else{
            Garen_BOT[i].set_g_Points(-1);
         }
      }
      
      for(int i=0;i<ArraySize(Garen_BOT);i++){
         Garen_PROFITS[i]=Garen_BOT[i].get_g_Profits_SUM();
      }
      
      ArrayResize(Garen_highest,0);
      ArrayCopy(Garen_highest,Garen_PROFITS);
      ArraySort(Garen_highest,WHOLE_ARRAY,0,MODE_DESCEND);
      //double help_P[];
      ArrayCopy(help_P,Garen_PROFITS);
      for(int i =0;i<ArraySize(Garen_highest_i);i++){
         Garen_highest_i[i]=-2;
      }
      for(int i=0;i<ArraySize(Garen_highest);i++){
         for(int j =0;j<ArraySize(help_P);j++){
            if(Garen_highest[i]==help_P[j]){
               Garen_highest_i[i] = j; 
               help_P[j]=9999999.9999;
               break;
            }
         }
      }
   }
}
void get_top_GarenPoints(){
   if(ArraySize(Garen_BOT)>0){
      for(int i=0;i<ArraySize(Garen_BOT);i++){
         if(Garen_BOT[i].get_g_HighestProfitDelta()>1){
            Garen_BOT[i].set_g_Points(Garen_BOT[i].get_g_Profits_SUM()/Garen_BOT[i].get_g_HighestProfitDelta());
            if(Garen_BOT[i].get_g_Points()<0.5){
               Garen_BOT[i].set_g_Points(-2);
            }
         }
         else{
            Garen_BOT[i].set_g_Points(-1);
         }
         Garen_PROFITS[i]=Garen_BOT[i].get_g_Points();
      }
      
      ArrayResize(Garen_highest,0);
      ArrayCopy(Garen_highest,Garen_PROFITS);
      ArraySort(Garen_highest,WHOLE_ARRAY,0,MODE_DESCEND);
      //double help_P[];
      ArrayCopy(help_P,Garen_PROFITS);
      for(int i =0;i<ArraySize(Garen_highest_i);i++){
         Garen_highest_i[i]=-2;
      }
      for(int i=0;i<ArraySize(Garen_highest);i++){
         for(int j =0;j<ArraySize(help_P);j++){
            if(Garen_highest[i]==help_P[j]){
               Garen_highest_i[i] = j; 
               help_P[j]=9999999.9999;
               break;
            }
         }
      }
   }
}

