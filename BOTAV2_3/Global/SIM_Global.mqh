//+------------------------------------------------------------------+
//|                                                   SIM_Global.mqh |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#include <BOTAV2_3/SIM/SIMULATOR.mqh>
//--------------------------------------------------------------
//                            SIM-METHODS
//--------------------------------------------------------------


void OnChartEvent(const int id,         // Event identifier   
                  const long& lparam,   // Event parameter of long type 
                  const double& dparam, // Event parameter of double type 
                  const string& sparam) // Event parameter of string type 
{
      if(id==CHARTEVENT_OBJECT_CLICK) { 
         if(sparam==GUI.get_StartButton_Name()){
            //Print("Start pressd|",SIM.RUN);
            //SIM.STOP=SIM.RUN;
            
            int f_index=0;
            if(SIM.exe_StartButton()){
               sim_tick();
               for(int i=0;i<ArraySize(SIM.TIME);i++){
                  if(SIM.SIM_RUN()){
                    sim_tick(); 
                  }
                  else{
                     i = ArraySize(SIM.TIME);
                  }
               }
               
               f_index = SIM.file_index;
               sim_init(f_index);
               Sleep(100);
               while(SIM.init_sim()){
                  /*if(SIM.STOP){
                     Print("SIM-STOP");
                     break;
                  }*/
                  for(int i=0;i<ArraySize(SIM.TIME);i++){
                     if(SIM.SIM_RUN()){
                       sim_tick(); 
                     }
                     else{
                        i = ArraySize(SIM.TIME);
                     }
                  }
                  Sleep(100);
                  f_index = SIM.file_index;
                  sim_init(f_index);
                  
               }
               if(writeSave){
                  SaveManager.save();
               }
               PrintManager.close();
            }
         }
         /*if(sparam==GUI.ResetButton.get_Name()){
            //Print("Reset");
            sim_reset();
         }*/
         /*if(sparam==GUI.TickButton.get_Name()){
            //Print("TICK");
            if(SIM.exe_TickButton()){
               sim_tick();
            }
         }*/
         /*if(sparam==GUI.FileButton.get_Name()){
            //Print("File");
            SIM.exe_FileButton();
         }*/
         /*if(sparam==GUI.FileReloadButton.get_Name()){
            //Print("FileReload");
            SIM.exe_FileReloadButton();
         }*/
        /* if(sparam==GUI.SIMButton.get_Name()){
            //Print("Toggle SIM");
            if(!SIMULATION){
               SIMULATION = true;
               
               //GUI.toggle_SimRealButton(true);
               GUI.setPanel("STOP");
               SIM.init_sim();
               sim_reset();
            }
         }
         if(sparam==GUI.REALButton.get_Name()){
            //Print("Toggle REAL");
            if(SIMULATION){
               SIMULATION = false;
               //GUI.toggle_SimRealButton(false);
               SIM.clear_sim();
            }
         }*/
      }  
      if(id==CHARTEVENT_OBJECT_ENDEDIT){ 
         /*if(sparam == GUI.E_FileName.get_Name()){
            GUI.E_FileName.Text = ObjectGetString(0,GUI.E_FileName.Name, OBJPROP_TEXT);
         }
         if(sparam == GUI.E_StartTime.Name){
            GUI.E_StartTime.Text = ObjectGetString(0,GUI.E_StartTime.Name, OBJPROP_TEXT);
            //sim_reset();
         }
         if(sparam == GUI.E_StopTime.Name){
            GUI.E_StopTime.Text = ObjectGetString(0,GUI.E_StopTime.Name, OBJPROP_TEXT);
         }
         if(sparam == GUI.E_TimeFactor.Name){
            GUI.E_TimeFactor.Text = ObjectGetString(0,GUI.E_TimeFactor.Name, OBJPROP_TEXT);
         }
         */
      }   
}
void OnTimer(){
   if(SIMULATION){
      if(SIM.RUN){
         SIM.SIM_RUN(); 
         sim_tick(); 
      }
      else{
         print_BotStatus();
         EventKillTimer();
         
      }
   }
   else{
      EventKillTimer();
      
   }
}
datetime last_simtime = 0;
void sim_tick(){
   SaveManager.clear();
   
   datetime simtime = SIM.SIM_TICK();
   int delta_t = 0;
   if(last_simtime!=0){
      delta_t = int(simtime)-int(last_simtime);
   }
   if(delta_t>120){
      BOT_HOLE_TICK(last_simtime,simtime);
   }
   //Print("Tick:",SIM.TIME[SIM.POINTER],"|",SIM.ASK[SIM.POINTER],"|",SIM.BID[SIM.POINTER]);
   BOT_TICK(SIM.TIME[SIM.POINTER],SIM.ASK[SIM.POINTER],SIM.BID[SIM.POINTER]);
   
   last_simtime = simtime;
}
void sim_reset(){
   //SIM.setPointer(datetime(GUI.E_StartTime.Text));
   SIM.SIM_RESET();
   
   
   for(int i = 0;i<ArraySize(CopyCat_BOT);i++){
      CopyCat_BOT[i].clear();
   }
   for(int i = 0;i<ArraySize(Garen_BOT);i++){
      Garen_BOT[i].clear();
   }
   for(int i = 0;i<ArraySize(WLB_BOT);i++){
      WLB_BOT[i].clear(true);
   }
   init_BOTs();
   init_daysleeptime();
}
void sim_init(int index){
   //Print("SIMULATION ON|",index);

   SIM = SIMULATOR(FileName);
   SIM.GUI =&GUI;
   SIM.file_index = index;
   SIM.SearchStartTime = Sim_Startdate;
   if(index==0){     
      SIM.init_sim();
   }
   init_BOTs();
   
   SIM.this_Aethas =& Aethas_BOT;
   Aethas_BOT.tick(SIM.TIME[0],SIM.ASK[0],SIM.BID[0]);
   
   
   init_daysleeptime();
   init_save();

   
   EventSetMillisecondTimer(1);
}
void sim_clear(){
   Print("SIMULATION OFF");
   SIM.clear_sim();
   init_BOTs();
}


void BOT_HOLE_TICK(datetime starttime, datetime endtime){//int candlepos){
   /*double priceL = iLow(Symbol(),PERIOD_M5,candlepos);
   double priceH = iHigh(Symbol(),PERIOD_M5,candlepos);*/
   //datetime time = Aethas_BOT.getTime(PERIOD_M1,0);//iTime(Symbol(),PERIOD_M5,candlepos);
   datetime candletime;
   int ipointer = 0;
   //Print("Calc Bothole form ",starttime ," to ", endtime);
   bool found=false;
   bool done = false;
   
   
   
   MqlDateTime time;
   TimeToStruct(starttime,time);
   string name_bonus = string(Symbol())+"_"+string(time.year);
   if(StringLen(string(time.mon))<2){
      name_bonus += "0" + string(time.mon);
   }  
   else{
      name_bonus += string(time.mon);
   }
   if(StringLen(string(time.day))<2){
      name_bonus += "0" + string(time.day);
   }  
   else{
      name_bonus += string(time.day);
   }
   
   
   int filehandle=0;
   string filename = FileName+"\\ChartData\\"+string(Symbol())+"\\HOLE\\" +name_bonus +".csv";
   if(FileIsExist(filename)){
      //Print("HOLE-FILENAME found|",filename);
      filehandle=FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV,';'); 
      if(filehandle!=INVALID_HANDLE){
         //FileSeek(filehandle,FileSize(filehandle),SEEK_SET);
         datetime holecandle_time[];
         double holecandle_open[];
         double holecandle_high[];
         double holecandle_low[];
         double holecandle_close[];
         int holecandle_pos=0;
         datetime firsttime=0;
         while(!FileIsEnding(filehandle) && done == false) {
            ArrayResize(holecandle_time,holecandle_pos+1);
            ArrayResize(holecandle_open,holecandle_pos+1);
            ArrayResize(holecandle_high,holecandle_pos+1);
            ArrayResize(holecandle_low,holecandle_pos+1);
            ArrayResize(holecandle_close,holecandle_pos+1);
            
            holecandle_time[holecandle_pos] = datetime(FileReadString(filehandle));
            
            if(holecandle_pos>0){
               if(holecandle_time[holecandle_pos] == holecandle_time[0]){
                  ArrayResize(holecandle_time,holecandle_pos);
                  ArrayResize(holecandle_open,holecandle_pos);
                  ArrayResize(holecandle_high,holecandle_pos);
                  ArrayResize(holecandle_low,holecandle_pos);
                  ArrayResize(holecandle_close,holecandle_pos);
                  
                  done=true;      
               }
            }
            
            if(!done){
               holecandle_open[holecandle_pos] = double(FileReadString(filehandle));
               holecandle_high[holecandle_pos] = double(FileReadString(filehandle));
               holecandle_low[holecandle_pos] = double(FileReadString(filehandle));
               holecandle_close[holecandle_pos] = double(FileReadString(filehandle));
               
               /*Print(holecandle_time[holecandle_pos],"|",
               holecandle_open[holecandle_pos],"|",
               holecandle_high[holecandle_pos],"|",
               holecandle_low[holecandle_pos],"|",
               holecandle_close[holecandle_pos]);
               */
               holecandle_pos+=1;
               if(holecandle_pos == 99999){
                  Print("?to much data in holefile?");
                  done=true;
               }
            }
         }   
         //Print("Found ",holecandle_pos," candledata in file");
         datetime fin_time = endtime;
         for(int i=0;i<holecandle_pos;i++){
            if(holecandle_time[i]>=starttime){
               //Print("HoleDataTick|",holecandle_time[i],"|",starttime);
               ORDER_HOLE_TICK(holecandle_low[i],holecandle_high[i],holecandle_time[i]);
               if(holecandle_time[i]>=endtime){
                  //Print("HoleDataTick-DONE|",holecandle_time[i],"|",endtime);
                  fin_time=holecandle_time[i];
                  break; 
               }
            }
            fin_time=holecandle_time[i];
         }
         if(fin_time<endtime){
            
            time.day+=1;
            datetime new_starttime = StructToTime(time);
            if(new_starttime<iTime(Symbol(),0,0) && endtime>new_starttime){
               Print("AGAIN|st:",new_starttime,"|it",iTime(Symbol(),0,0),"|ft:",fin_time,"|et:",endtime);
               BOT_HOLE_TICK(new_starttime,endtime);
            }
         }
         done=true;
         ArrayFree(holecandle_time);
         ArrayFree(holecandle_open);
         ArrayFree(holecandle_high);
         ArrayFree(holecandle_low);
         ArrayFree(holecandle_close);
         
      }
      else{
         Print("HOLE-FILENAME invalid1");    
      }
      FileClose(filehandle);
   }
   else{
      Print("HOLE-FILENAME not found|",filename);    
   }
   
   
   
   
   
   if(!done){
   
   
   
      for(int i=0;i< 99999; i++){
         candletime = iTime(Symbol(),PERIOD_M1,i);
         if(candletime==0){
            //not found
            ipointer = i;
            i = 99999;
         }
         else{
            if(iTime(Symbol(),PERIOD_M1,i)<=starttime){
               //found
               found=true;
               ipointer=i;
               i=99999;
            }
         }
      }
      if(!found){
         //Print("M1 not found - ",ipointer, "_",iTime(Symbol(),PERIOD_M1,ipointer-1));
         for(int i=0;i< 99999; i++){
            candletime = iTime(Symbol(),PERIOD_M5,i);
            if(candletime==0){
               //not found
               ipointer = i;
               i = 99999;
            }
            else{
               if(iTime(Symbol(),PERIOD_M5,i)<=starttime){
                  //found
                  found=true;
                  ipointer=i;
                  i=99999;
               }
            }
         }
         
         if(!found){
            //Print("M5 not found - ",ipointer, "_",iTime(Symbol(),PERIOD_M5,ipointer-1));
            for(int i=0;i< 99999; i++){
               candletime = iTime(Symbol(),PERIOD_M15,i);
               if(candletime==0){
                  //not found
                  ipointer = i;
                  i = 99999;
               }
               else{
                  if(iTime(Symbol(),PERIOD_M15,i)<=starttime){
                     //found
                     found=true;
                     ipointer=i;
                     i=99999;
                  }
               }
            }
            if(!found){
               //Print("M15 not found - ",ipointer, "_",iTime(Symbol(),PERIOD_M15,ipointer-1));
               Print("Stopped Holecalc");
            }
            else{
               //Print("Found candle in iTime M15 - ",ipointer);
               while(!done){
                  if(writeHoleData){
                     save_DataHoleCandle( iTime(Symbol(),PERIOD_M15,ipointer),
                                          iOpen(Symbol(),PERIOD_M15,ipointer),
                                          iHigh(Symbol(),PERIOD_M15,ipointer),
                                          iLow(Symbol(),PERIOD_M15,ipointer),
                                          iClose(Symbol(),PERIOD_M15,ipointer));
                  }
               
                  ORDER_HOLE_TICK(iLow(Symbol(),PERIOD_M15,ipointer),iHigh(Symbol(),PERIOD_M15,ipointer),iTime(Symbol(),PERIOD_M15,ipointer));
                  ipointer-=1;
                  if(iTime(Symbol(),PERIOD_M15,ipointer) >= endtime){
                     //Print("Finish Holecalc|itime: ",iTime(Symbol(),PERIOD_M15,ipointer) ," - et: ", endtime);
                     done = true;
                  }
                  if(ipointer >= 999999){
                     Print("Something went wrong in HoleCalc");
                     done =true;
                  }
               }
            }
         }
         else{
            //Print("Found candle in iTime M5 - ",ipointer);
            while(!done){
               if(writeHoleData){
                  save_DataHoleCandle( iTime(Symbol(),PERIOD_M5,ipointer),
                                       iOpen(Symbol(),PERIOD_M5,ipointer),
                                       iHigh(Symbol(),PERIOD_M5,ipointer),
                                       iLow(Symbol(),PERIOD_M5,ipointer),
                                       iClose(Symbol(),PERIOD_M5,ipointer));
               }
            
            
               ORDER_HOLE_TICK(iLow(Symbol(),PERIOD_M5,ipointer),iHigh(Symbol(),PERIOD_M5,ipointer),iTime(Symbol(),PERIOD_M5,ipointer));
               ipointer-=1;
               if(iTime(Symbol(),PERIOD_M5,ipointer) >= endtime){
                  //Print("Finish Holecalc|itime: ",iTime(Symbol(),PERIOD_M5,ipointer) ," - et: ", endtime);
                  done = true;
               }
               if(ipointer >= 999999){
                  Print("Something went wrong in HoleCalc");
                  done =true;
               }
            }
         }
      }
      else{
         //Print("Found candle in iTime M1 - ",ipointer);
         
         while(!done){
            if(writeHoleData){
               save_DataHoleCandle( iTime(Symbol(),PERIOD_M1,ipointer),
                                    iOpen(Symbol(),PERIOD_M1,ipointer),
                                    iHigh(Symbol(),PERIOD_M1,ipointer),
                                    iLow(Symbol(),PERIOD_M1,ipointer),
                                    iClose(Symbol(),PERIOD_M1,ipointer));
            }
         
            ORDER_HOLE_TICK(iLow(Symbol(),PERIOD_M1,ipointer),iHigh(Symbol(),PERIOD_M1,ipointer),iTime(Symbol(),PERIOD_M1,ipointer));
            ipointer-=1;
            if(iTime(Symbol(),PERIOD_M1,ipointer) >= endtime){
               //Print("Finish Holecalc|itime: ",iTime(Symbol(),PERIOD_M1,ipointer) ," - et: ", endtime);
               done = true;
            }
            if(ipointer >= 999999){
               Print("Something went wrong in HoleCalc");
               done =true;
            }
         }
      }
   }    
}      
void ORDER_HOLE_TICK(double priceL,double priceH,datetime time){   
   for(int i =0;i<ArraySize(WLB_BOT);i++){
      WLB_BOT[i].hole_tick(priceL,priceH,time);
   }
   for(int i =0;i<ArraySize(Garen_BOT);i++){
      Garen_BOT[i].check_Buy_order(priceH,priceL,time);
      Garen_BOT[i].check_Sell_order(priceH,priceL,time);
   }
   
   for(int i =0;i<ArraySize(CopyCat_BOT);i++){
      CopyCat_BOT[i].check_Buy_order(priceH,priceL,time);
      CopyCat_BOT[i].check_Sell_order(priceH,priceL,time);
   }
   
   
   

}   


void save_DataHoleCandle(datetime c_time,double c_open,double c_high,double c_low,double c_close){
   
   MqlDateTime time;
   TimeToStruct(c_time,time);
   string name_bonus = string(Symbol())+"_"+string(time.year);
   if(StringLen(string(time.mon))<2){
      name_bonus += "0" + string(time.mon);
   }  
   else{
      name_bonus += string(time.mon);
   }
   if(StringLen(string(time.day))<2){
      name_bonus += "0" + string(time.day);
   }  
   else{
      name_bonus += string(time.day);
   }
   
   
   int filehandle=0;
   string filename = FileName+"\\ChartData\\"+string(Symbol())+"\\HOLE\\" +name_bonus +".csv";
   if(FileIsExist(filename)){
      filehandle=FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV,';'); 
      if(filehandle!=INVALID_HANDLE){
         FileSeek(filehandle,FileSize(filehandle),SEEK_SET);
      }
      else{
         Print("HOLE-FILENAME invalid1");    
      }
   }
   else{
      filehandle=FileOpen(filename,FILE_WRITE|FILE_CSV,';'); 
      if(filehandle==INVALID_HANDLE){      
         Print("HOLE-FILENAME invalid2");    
      }
   }
   FileWrite(filehandle,c_time,c_open, c_high,c_low,c_close); 
   FileClose(filehandle);
}