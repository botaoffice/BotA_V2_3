void add_daysleeptime(  ActionBot *this_bot,
                        string t1_start,string t1_end,
                        string t2_start,string t2_end,
                        string t3_start,string t3_end,
                        string t4_start,string t4_end,
                        string t5_start,string t5_end)
{ 
        
   string t1 ="";
   string t2 ="";
   string time_help[];
   string time_help2[];
   string sep = ":";
   ushort u_sep;
   datetime starttime;
   datetime endtime;
   MqlDateTime full_time;
   u_sep =StringGetCharacter(sep,0);     
                        
   int window_count = 0;
   if(t1_start!="" && t1_end!=""){
      window_count+=1;
      if(t2_start!="" && t2_end!=""){
         window_count+=1;
         if(t3_start!="" && t3_end!=""){
            window_count+=1;
            if(t4_start!="" && t4_end!=""){
               window_count+=1;
               if(t5_start!="" && t5_end!=""){
                  window_count+=1;
               }
            }
         }
      }
   }
   

   
   for(int i =0;i<(window_count+1);i++){
      if(i==0){
         t1 = "0:00";
         t2 = t1_start;
      }
      if(i==1){
         t1 = t1_end;
         t2 = t2_start;
      }
      if(i==2){
         t1 = t2_end;
         t2 = t3_start;
      }
      if(i==3){
         t1 = t3_end;
         t2 = t4_start;
      }
      if(i==4){
         t1 = t4_end;
         t2 = t5_start;
      }
      if(i==5){
         t1 = t5_end;
         t2 = "23:59";
      }
      if(i==window_count){
         t2 = "23:59";
      }

      if(t1 != ""){
         StringSplit(t1,u_sep,time_help);
         
         
         TimeToStruct(Aethas_BOT.getTime(PERIOD_M1,0),full_time);
         full_time.hour = int(time_help[0]);
         full_time.min = int(time_help[1]);
         full_time.sec = 0;
         
         starttime = StructToTime(full_time);
      
      
         if(t2 != ""){
            
            
            u_sep =StringGetCharacter(sep,0);
            
            StringSplit(t2,u_sep,time_help2);
            
            TimeToStruct(Aethas_BOT.getTime(PERIOD_M1,0),full_time);
            full_time.hour = int(time_help2[0]);
            full_time.min = int(time_help2[1]);
            full_time.sec = 0;
            
            endtime = StructToTime(full_time);
            
            
            this_bot.add_SleepTwindow(starttime,endtime);
         }
      }
   }
}

//--------------------------------------------------------------
//                            SLEEP-METHODS
//--------------------------------------------------------------
void init_newssleeptime(){
   NEWS = array_news(FileName);
   NEWS.get_News();
   for(int j=0;j<NEWS.get_Size();j++){
      if(NEWS.News[j].get_Country() == "USD"){
         if(NEWS.News[j].get_Impact() == "High"){
            for(int i =0;i<ArraySize(Garen_BOT);i++){
            
               Garen_BOT[i].add_SleepTwindow(NEWS.News[j].get_NewsTime()+(14*3600)-WatchNews_Startoffset,NEWS.News[j].get_NewsTime()+(14*3600)+WatchNews_Endoffset);
               //Garen_BOT[i].SleepT.addNEWSwindow(NEWS.News[j].get_NewsTime()+(14*3600),WatchNews_Startoffset,WatchNews_Endoffset);
            }
         }
      }
      if(NEWS.News[j].get_Country() == "All" || NEWS.News[j].get_Country() == "ALL"){
         if(NEWS.News[j].get_Impact() == "High" || NEWS.News[j].get_Impact() == "Medium"){
            for(int i =0;i<ArraySize(Garen_BOT);i++){
               Garen_BOT[i].add_SleepTwindow(NEWS.News[j].get_NewsTime()+(14*3600)-WatchNews_Startoffset,NEWS.News[j].get_NewsTime()+(14*3600)+WatchNews_Endoffset);
               //Garen_BOT[i].SleepT.addNEWSwindow(NEWS.News[j].get_NewsTime()+(14*3600),WatchNews_Startoffset,(11*3600)); 
            }
         }
      }
   }
}
void init_daysleeptime(){
   for(int j =0;j<ArraySize(Garen_BOT);j++){
      Garen_BOT[j].clear_SleepT();
   }
   for(int j =0;j<ArraySize(Garen_BOT);j++){
      Garen *this_garen =& Garen_BOT[j];
      add_daysleeptime(this_garen, exe_time1_start,exe_time1_end,
                     exe_time2_start,exe_time2_end,
                     exe_time3_start,exe_time3_end,
                     exe_time4_start,exe_time4_end,
                     exe_time5_start,exe_time5_end);
                     
      Garen_BOT[j].init_sleeptime();
   }   
}