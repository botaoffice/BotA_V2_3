//+------------------------------------------------------------------+
//|                                                    SIMULATOR.mqh |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.google.com"
#property strict

#include <BOTAV2_3/GUI/BotA_GUI.mqh>
#include <BOTAV2_3/Support/Aethas.mqh>


class SIMULATOR{
   public:
      string file_name;
      string full_name;
      int file_index;
      int filehandle;
      int size;
      
      datetime SearchStartTime;

      bool VALID;
      
      datetime TIME[];
      double   ASK[];
      double   BID[];
      
      ENUM_TIMEFRAMES P;
      
      string SYMBOL;
      
      int POINTER;
      
      bool RUN;
      
      bool STOP;
      
      int ChartPos;

      bool draw_sim;
       
      hline ASK_Line;
      hline BID_Line;
      vline Time_Line;
      vline DataHole_Line[];
      
      Bota_GUI *GUI;
      
      Aethas *this_Aethas;
      
      int last_time;
      
      int Candle_Count;
      int Candle_POINTER;
      tline Candle_topWick[];
      tline Candle_botWick[];
      rectangle Candle_Body[];
      
     
      SIMULATOR(void);
      SIMULATOR(string fn);
      ~SIMULATOR(void);
      
      bool open();
      void close();
      
      bool exe_StartButton();

      bool init_sim();
      void clear_sim();
      void intiGeo(bool valid);
      
      bool setPointer(datetime time);
      bool setLines(int i);
  
      void create_DataHoleLine(datetime starttime,datetime stoptime);
      bool SIM_RUN();
      void SIM_RESET();
      void candle_reset();
      datetime SIM_TICK();
};

SIMULATOR::SIMULATOR(void){
   RUN=false;
   POINTER=0;
   last_time=-1;
   file_index=0;
   filehandle=0;
   STOP=false;
}

SIMULATOR::SIMULATOR(string fn){
   file_name = fn;
   RUN=false;
   file_index=0;
   POINTER=0;
   last_time=-1;
   draw_sim=true;
   
   ASK_Line = hline("SIM_ASKLINE",1,clrSienna,STYLE_SOLID,1,false);
   BID_Line = hline("SIM_BIDLINE",1,clrDodgerBlue,STYLE_SOLID,1,false);
   /*datetime this_time = 0;
   if(VALID){
      this_time = TIME[0];
   }*/
   Time_Line = vline("SIM_TIMELINE",1,clrGold,STYLE_SOLID,1,false);
   STOP=false;
}

SIMULATOR::~SIMULATOR(void){
   ArrayFree(DataHole_Line); 
   ArrayFree(Candle_topWick); 
   ArrayFree(Candle_botWick); 
   ArrayFree(Candle_Body); 
   ArrayFree(TIME); 
   ArrayFree(ASK); 
   ArrayFree(BID); 
}

void SIMULATOR::close(){
   FileClose(filehandle);
}

bool SIMULATOR::open(){
   if(filehandle!=0){
      FileClose(filehandle);
   }
   int retry_target = 100;
   for(int retry=0;retry<retry_target;retry++){
      filehandle=FileOpen(full_name,FILE_READ|FILE_CSV,';');  
      //Print("Opening ",full_name);
      
      if(filehandle!=INVALID_HANDLE){
         retry=retry_target;
         
         ArrayResize(TIME,0); 
         ArrayResize(BID,0);
         ArrayResize(ASK,0);
         POINTER=0;
      
         int i = 0;
         bool done = false;
         datetime lt=0;
         
         bool first = true;
         
         string line_array[];
         string help;
         while(!FileIsEnding(filehandle) && done == false) {
            ArrayResize(line_array,0);
            if(first){
               //Print("FIRST");
               ArrayResize(line_array,ArraySize(line_array)+1); 
               line_array[ArraySize(line_array)-1] = FileReadString(filehandle);  
               first=false;
               //Print(ArraySize(line_array),"-",line_array[ArraySize(line_array)-1]);
            }
            else{
               if(help!=""){
                  ArrayResize(line_array,ArraySize(line_array)+1); 
                  line_array[ArraySize(line_array)-1] = help;     
                  
                  help = "";
                  //Print(ArraySize(line_array),"-h-",line_array[ArraySize(line_array)-1]);
               }
            }
            while(!FileIsLineEnding(filehandle) && !FileIsEnding(filehandle)){ 
               ArrayResize(line_array,ArraySize(line_array)+1);
               line_array[ArraySize(line_array)-1] = FileReadString(filehandle);
               //Print(ArraySize(line_array),"-",line_array[ArraySize(line_array)-1]);
            } 
            if(FileIsEnding(filehandle)){
               done=true;
            }
            else{
               help = FileReadString(filehandle);
            }
            //Sleep(10000);
            if(ArraySize(line_array)<4 || ArraySize(line_array)>4){
               
               Print("Error in data-file ",full_name, "|",i,"|",ArraySize(line_array));
            }
            else{
               datetime checkT1 = datetime(line_array[0]);//FileReadString(filehandle)
               
               
               
               datetime stop_time = TimeGMT()-TimeGMTOffset();
                
               MqlDateTime struct_stopT;
               TimeToStruct(stop_time,struct_stopT);
               struct_stopT.hour=0;
               struct_stopT.min=0;
               struct_stopT.sec=0;
               stop_time = StructToTime(struct_stopT);
               
              
               if(checkT1 >= lt && checkT1 < stop_time){
                  if(ArrayResize(TIME,i+1)   !=-1 &&
                     ArrayResize(BID,i+1)    !=-1 &&
                     ArrayResize(ASK,i+1)    !=-1 ){
                     
                     if(i<ArraySize(TIME) && i>-1){
                        TIME[i] = checkT1;
                        SYMBOL = line_array[1];//FileReadString(filehandle);
                        if(SYMBOL != Symbol()){
                           Print("Simulation - Data Symbol(",SYMBOL,") is not Chart Symbol(",Symbol(),")");
                           return(false);
                        }
                        BID[i] = double(line_array[2]);//FileReadString(filehandle));
                        ASK[i] = double(line_array[3]);//FileReadString(filehandle));
                        
                        
                        if(i>0){
                           int delta = int(TIME[i])-int(TIME[i-1]);
                           if(delta>120){
                              create_DataHoleLine(TIME[i-1],TIME[i]);
                           }
                        }
                     }
                     else{
                        Print("Dafuq-",i,"|",ArraySize(TIME));
                        return(false);
                     }
                     i++;
                     if(i>99999999){
                        Print("You Sure?");
                        done=true;
                        return(false);
                     }
                  }
                  else{
                     done=true;   
                     Print(ArraySize(TIME)," TYou Sure?");
                     Print(ArraySize(BID)," BYou Sure?");
                     Print(ArraySize(ASK)," AYou Sure?");
                     return(false);
                  }
               }
               else{
                  //Print("i",i,"|",checkT1,"|",lt);
                  done=true;
               }
               lt=checkT1;
            }       
         }   
         close();
         if(i>0 && i<=ArraySize(TIME)){
            
            //Print("Simulation - TICK-DATA loaded|START:",TIME[0],"|END:",TIME[i-1]);
            return(true);
         }
         else{
            Print("Simulation - ",i,"|",ArraySize(TIME));
            return(true);
         }
      }  
      else{
         Print("Simulation - FILENAME invalid");
         Print("RETRY: ",retry);
         Sleep(10000);
      }
   }
   return(false);
}   
bool SIMULATOR::init_sim(){

   P=periodTOp(Period());
 
   int max = 5000;

   datetime startdate=SearchStartTime; 
  
   MqlDateTime strDate;
   
   for(file_index;file_index<max;file_index++){
      
      datetime date = startdate+(file_index*86400);
      TimeToStruct(date,strDate); 
      
      string dateString = string(strDate.year);
      if(StringLen(string(strDate.mon))==1){
         dateString +="0";
      }
      dateString +=string(strDate.mon);
      if(StringLen(string(strDate.day))==1){
         dateString +="0";
      }
      dateString +=string(strDate.day);
      
      full_name = file_name+ "\\ChartData\\"+ string(Symbol())+"\\All\\"+ string(Symbol()) +"_" + dateString + ".csv"; 
      if(FileIsExist(full_name)){
         
         VALID = open();
         intiGeo(true);
         file_index+=1;
         return(VALID);
      }
      else{
         if(file_index==max-1){
            Print("Not found..");
            return(false);
         }
      }
   }
   return(false);
}
void SIMULATOR::intiGeo(bool valid){   
   int pos_bonus = 0;
   if(!valid){
      pos_bonus=999999;
   }
   if(ArraySize(TIME)>0){
      if(VALID){
         GUI.set_Hide_Rectangle_Time1(TIME[0]-1);
         GUI.set_Hide_Rectangle_Price1(0);
         GUI.set_Hide_Rectangle_Time2(TIME[0]+9999999);
         GUI.set_Hide_Rectangle_Price2(9999999);
      }
      else{
         GUI.set_Hide_Rectangle_Time1(0);
         GUI.set_Hide_Rectangle_Price1(0);
         GUI.set_Hide_Rectangle_Time2(0);
         GUI.set_Hide_Rectangle_Price2(0);
      }
      
      
      if(VALID){
         ASK_Line.set_Price(ASK[0]);
      }
      else{
         ASK_Line.set_Price(1);
      }
      if(VALID){
         BID_Line.set_Price(BID[0]);
      }
      else{
         BID_Line.set_Price(1);
      }
      if(VALID){
         Time_Line.set_VTime(TIME[0]);
      }
      else{
         Time_Line.set_VTime(0);
      }
      
      if(VALID){
         candle_reset();
      }
      
      //GUI.E_FileName.Text = file_name;
      //GUI.E_FileName.Update();
      /*if(VALID){
         GUI.E_StartTime.Text = string(TIME[0]);
         GUI.E_StopTime.Text = string(TIME[ArraySize(TIME)-1]);
         GUI.E_StartTime.Update();
         GUI.E_StopTime.Update(); 
      } */
      if(draw_sim){
         GUI.Update();
         ASK_Line.Update();
         BID_Line.Update();
         Time_Line.Update();
      }
   }
   else{
      VALID = false;
   }
   
   
   if(valid){
      long handle=ChartID();
      if(handle>0){
         ChartSetInteger(handle,CHART_AUTOSCROLL,false);
         ChartSetInteger(handle,CHART_SHIFT,true);
         ChartSetInteger(handle,CHART_MODE,CHART_CANDLES);
         ResetLastError();
         
         //Chart
         
         
         bool found = false;
         ChartPos =0;
         while(!found){
            if(iTime(Symbol(),Period(),ChartPos)<TIME[0]){
               found = true;
               //Print("Found Time:",iTime(Symbol(),Period(),ChartPos),"|",TIME[0]);
               //Print(ChartPos);
            }
            else{
               ChartPos+=1;
            }
            
            if(ChartPos>999999){
               Print("TOOMUCH");
               found = true;
            }
         }
         
         bool res=ChartNavigate(handle,CHART_END,-(ChartPos-500));
         if(!res) Print("Navigate failed. Error = ",GetLastError());
         ChartRedraw();
      }
   }
}
void SIMULATOR::clear_sim(){
   GUI.setPanel("OFF");
   ASK_Line.set_Price(1);
   BID_Line.set_Price(1);
   Time_Line.set_VTime(1);
   GUI.set_Hide_Rectangle_Price2(1);
   if(draw_sim){
      ASK_Line.Update();
      BID_Line.Update();
      Time_Line.Update();
      GUI.Update();//
   }
   
   ArrayFree(TIME); 
   ArrayFree(BID);
   ArrayFree(ASK);
}

 
bool SIMULATOR::exe_StartButton(){
   if(RUN){
      RUN=false;
      GUI.setPanel("STOP");
      EventKillTimer();
      return(false);
   }
   else{
      RUN=true;
      GUI.setPanel("RUN");
      return(SIM_RUN());
   }
}

/*bool SIMULATOR::exe_TickButton(){
   if(RUN){
      RUN=false;
      GUI.setPanel("STOP");
      EventKillTimer();
   }
   POINTER +=1;
   if(TIME[POINTER]<=datetime(GUI.E_StopTime.get_Text())){
      setLines(POINTER);
      return(true);
   }
   else{
      POINTER-=1;
      return(false);
   }
}*/
/*
void SIMULATOR::exe_FileButton(){
   if(GUI.Panel_State=="STOP"){
      GUI.setPanel("FILE");
   }
   else{
      GUI.setPanel("STOP");
   }
}*/
/*void SIMULATOR::exe_FileReloadButton(){
   file_name = GUI.E_FileName.get_Text();
   VALID = open(); 
   if(VALID){
      GUI.E_StartTime.get_Text = string(TIME[0]);
      GUI.E_StopTime.Text = string(TIME[ArraySize(TIME)-1]);
   }
   SIM_RESET();
}*/

bool SIMULATOR::setPointer(datetime time){
   if(VALID){
      for(int i =0;i<ArraySize(TIME);i++){
         if(TIME[i]>=time){
            POINTER = i;
            setLines(i);
            return(true);
         }
      } 
   }
   return(false);
}

bool SIMULATOR::setLines(int i){
   if(VALID){
      if(i<ArraySize(TIME) && i<ArraySize(ASK) && i<ArraySize(BID)){ 
         ASK_Line.set_Price(ASK[i]);
         BID_Line.set_Price(BID[i]);
         Time_Line.set_VTime(TIME[i]);
         if(draw_sim){
            ASK_Line.Update();
            BID_Line.Update();
            Time_Line.Update();
         }   
            
         
         
         return(true);
      }
   }
   return(false);
}

void SIMULATOR::create_DataHoleLine(datetime starttime,datetime stoptime){
   
   for(int i=0;i<2;i++){ 
      ArrayResize(DataHole_Line,ArraySize(DataHole_Line)+1);
      datetime this_time = starttime; 
      if(i!=0){
         this_time = stoptime; 
      }
      DataHole_Line[ArraySize(DataHole_Line)-1].set_vline("SIM:_Datahole_"+string(ArraySize(DataHole_Line)),this_time,clrWhite,STYLE_DOT,2,false);

      
      DataHole_Line[ArraySize(DataHole_Line)-1].Update();
   }
}

bool SIMULATOR::SIM_RUN(){
   if(VALID){
      if(POINTER+1<ArraySize(TIME)){
         POINTER +=1;
         //if(TIME[POINTER]<=datetime(GUI.E_StopTime.Text)){
            setLines(POINTER);
         /*}
         else{
            POINTER-=1;
            return(false);
         }*/
      
         /*if(int(GUI.E_TimeFactor.Text)==0){*/
            return(true);
         /*}
         else{
            int d_time = (int(TIME[POINTER] - TIME[POINTER-1])*1000)/int(GUI.E_TimeFactor.Text);
            if(d_time==0){
               d_time=500/int(GUI.E_TimeFactor.Text);
               if(d_time==0){
                  d_time=1;
               }
            }
            EventSetMillisecondTimer(d_time);
         }*/
      }
      else{
         RUN=false;
         EventKillTimer();
         GUI.setPanel("STOP");
      }
   }
   else{
      RUN=false;
      EventKillTimer();
      GUI.setPanel("STOP");
   }
   return(false);
}

void SIMULATOR::SIM_RESET(){
   
   //setPointer(datetime(GUI.E_StartTime.Text));
   setLines(POINTER);
    
   //GUI.ResetButton.Color = clrDarkGray;
   //GUI.ResetButton.Update();
   
   RUN=false;
   EventKillTimer();
   GUI.setPanel("STOP");
   
   candle_reset();
}
void SIMULATOR::candle_reset(){

   datetime deltaTime = TIME[ArraySize(TIME)-1]-TIME[0];
   Candle_Count = int(86400/(Period()*60))+2;
   Candle_POINTER = 0;
   ArrayResize(Candle_topWick,Candle_Count+1);
   ArrayResize(Candle_botWick,Candle_Count+1);
   ArrayResize(Candle_Body,Candle_Count+1);
   

   for(int i=0;i<Candle_Count;i++){
      Candle_topWick[i].set_tline("SIM_CTOP_"+string(i),TIME[0],BID[0],TIME[0],BID[0],false,false,clrWhite,STYLE_SOLID,3,true);
      Candle_botWick[i].set_tline("SIM_CBOT_"+string(i),TIME[0],BID[0],TIME[0],BID[0],false,false,clrWhite,STYLE_SOLID,3,true);

      
      Candle_Body[i].set_rectangle("SIM_CBODY_"+string(i),TIME[0]-1,BID[0],TIME[0]+1,BID[0],clrWhite,STYLE_SOLID,1,true,true);
      /*if(draw_sim){
         Candle_topWick[i].Update();
         Candle_botWick[i].Update();
         Candle_Body[i].Update();
      }*/
      
   }

   GUI.set_Hide_Rectangle_Time1(TIME[POINTER]);
   GUI.set_Hide_Rectangle_Time2(TIME[POINTER]+9999999);
   GUI.set_Hide_Rectangle_Price2(999999);
   if(draw_sim){
      GUI.Update();
   }
}

datetime SIMULATOR::SIM_TICK(){
   //GUI.ResetButton.Color = clrYellow;
   //GUI.ResetButton.Update();
         

   int this_time = this_Aethas.getCurrentCandle(P);
   if(this_time != last_time){
      
      
      Candle_POINTER+=1;
      last_time = this_time;
      //if(Candle_POINTER<ArraySize(Candle_Body) && POINTER<ArraySize(BID)){
         //Print("tt:",this_time,"|lt:",last_time,"|cp:",Candle_POINTER,"|as1:",ArraySize(Candle_Body),"|as2:",ArraySize(BID));
      
         
         
         Candle_Body[Candle_POINTER].set_Price1(BID[POINTER]);
         Candle_Body[Candle_POINTER].set_Price2(BID[POINTER]);
         Candle_Body[Candle_POINTER].set_Time1(TIME[POINTER] -(Period()*60));
         Candle_Body[Candle_POINTER].set_Time2(TIME[POINTER]);
         
         Candle_topWick[Candle_POINTER].set_LineVal(TIME[POINTER],BID[POINTER],TIME[POINTER],BID[POINTER]);
         /*Candle_topWick[Candle_POINTER].Price1 = BID[POINTER];
         Candle_topWick[Candle_POINTER].Price2 = BID[POINTER];
         Candle_topWick[Candle_POINTER].Time1 = TIME[POINTER];
         Candle_topWick[Candle_POINTER].Time2 = TIME[POINTER];*/
         Candle_botWick[Candle_POINTER].set_LineVal(TIME[POINTER],BID[POINTER],TIME[POINTER],BID[POINTER]);
         /*Candle_botWick[Candle_POINTER].Price1 = BID[POINTER];
         Candle_botWick[Candle_POINTER].Price2 = BID[POINTER];
         Candle_botWick[Candle_POINTER].Time1 = TIME[POINTER];
         Candle_botWick[Candle_POINTER].Time2 = TIME[POINTER];*/
      //}
   }
   else{
      Candle_Body[Candle_POINTER].set_Price2(BID[POINTER]);
      if(Candle_Body[Candle_POINTER].get_Price1()>=Candle_Body[Candle_POINTER].get_Price2()){
         Candle_Body[Candle_POINTER].set_Color(clrRed);
         
         Candle_botWick[Candle_POINTER].set_Price2(Candle_Body[Candle_POINTER].get_Price2());
         
          if(Candle_Body[Candle_POINTER].get_Price2()<Candle_botWick[Candle_POINTER].get_Price1()){
            Candle_botWick[Candle_POINTER].set_Price1(Candle_Body[Candle_POINTER].get_Price2());
         }
      }
      else{
         Candle_Body[Candle_POINTER].set_Color(clrBlue);

         Candle_topWick[Candle_POINTER].set_Price2(Candle_Body[Candle_POINTER].get_Price2());
         
         if(Candle_Body[Candle_POINTER].get_Price2()>Candle_topWick[Candle_POINTER].get_Price1()){
            Candle_topWick[Candle_POINTER].set_Price1(Candle_Body[Candle_POINTER].get_Price2());
         }
      }
   }
   if(draw_sim){
      
      Candle_Body[Candle_POINTER].Update();
      Candle_botWick[Candle_POINTER].Update();
      Candle_topWick[Candle_POINTER].Update();
      GUI.set_Hide_Rectangle_Time1(TIME[POINTER]);
      
      GUI.Update();
      
      
      
   }
   return(TIME[POINTER]);
}