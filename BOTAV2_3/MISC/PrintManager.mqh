//+------------------------------------------------------------------+
//|                                                          CSV.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

//#include <BOTAV2_3/MISC/CSV.mqh>


class print_manager{
private:   
      string log_file_name;
      string data_file_name;
      string result_file_name;
      
      string path;
      
      int log_index;
      int result_index;
      int data_index;
      int log_filehandle;
      int data_filehandle;
      int result_filehandle;
      int result_fileCount;
      int tick_filehandle;
      
      
      bool DATA;
      bool TICK;
      bool LOG;
      bool RESULT;
      
      string m[][15];
      int m_count;
      
      bool first_init;
public:      
      print_manager(void);
      print_manager(string fn,bool Data,bool Tick,bool Log,bool Result);
      ~print_manager(void);
      
      
      
      
      void open();
      void reopen();
      void close();
      void write_log(string message0,string message1,string message2,string message3,string message4,string message5,string message6,string message7,string message8,string message9);
      void write_data(string message0,string message1,string message2,string message3,string message4,string message5,string message6,string message7,string message8,string message9,string message10,string message11);
      void write_result(bool last,string message0,string message1,string message2,string message3,string message4,string message5,string message6,string message7,string message8,string message9,string message10,string message11,string message12,string message13,string message14);
      void writeresult_i(int pos);
      void write_tick(string message0,string message1);
      void tick();
};
print_manager::print_manager(){}
print_manager::print_manager(string fn,bool Data,bool Tick,bool Log,bool Result){
   path = fn;
   log_file_name = fn +"\\log\\log_";
   
   log_index = 0;
   bool log_found = false;
   long dates[];
   int datepos = 0;
   for(int i=0;i<30;i++){
      ArrayResize(dates,ArraySize(dates)+1);
      if(FileIsExist(log_file_name+string(i)+ ".csv")){
         dates[i] = FileGetInteger(log_file_name+string(i)+ ".csv" ,FILE_MODIFY_DATE,false);
      }
      else{
         log_index=i;
         log_found=true;
         break;
      }
   }
   if(!log_found){
      long copyarray[];
      ArrayCopy(copyarray,dates,0,0,WHOLE_ARRAY);
      ArraySort(copyarray,WHOLE_ARRAY,0,MODE_DESCEND);
      for(int i=0;i<ArraySize(dates);i++){
         if(dates[i] == copyarray[0]){
            if(i==(ArraySize(dates)-1)){
               log_index=0;
            }
            else{
               log_index=i;
               log_found=true;
            }
         }
      }
   }
   log_file_name = fn +"\\log\\log_" + string(log_index) + ".csv" ;
   
   data_index = 0;
   data_file_name = fn +"\\data\\data_";
   bool data_found = false;
   while(!data_found){
      string new_name = data_file_name+string(data_index)+ ".csv" ;
      string target_name;
      long search_handle=FileFindFirst(new_name,target_name);
      if(search_handle==INVALID_HANDLE){
         data_found=true;
         data_file_name = new_name;
      }
      else{
         data_index++;
      }
   }
   result_index = 0;
   result_file_name = fn +"\\result\\result_"+string(Period())+"_";
   data_found = false;
   while(!data_found){
      string new_name = result_file_name+string(result_index)+ ".csv" ;
      string target_name;
      long search_handle=FileFindFirst(new_name,target_name);
      if(search_handle==INVALID_HANDLE){
         data_found=true;
         //data_file_name = new_name;
      }
      else{
         result_index++;
      }
   }
   
   first_init=true;
   result_fileCount = 1;
   m_count=0;
   
   DATA = Data;
   TICK = Tick;
   LOG = Log;
   RESULT = Result;
}

print_manager::~print_manager(void){
   ArrayFree(m); 
}

void print_manager::close(){
   if(LOG){
      FileWrite(log_filehandle,TimeCurrent(),Symbol(), EnumToString(ENUM_TIMEFRAMES(_Period)),"Stop"); 
      FileClose(log_filehandle); 
   }
   if(DATA){
      FileClose(data_filehandle);
   }
   if(RESULT){
      FileClose(result_filehandle);
   }
   if(TICK){
      FileClose(tick_filehandle);
   }
   Print("Closing files");
}

void print_manager::open(){

   if(LOG){
      log_filehandle=FileOpen(log_file_name,FILE_WRITE|FILE_CSV,';');  
      FileWrite(log_filehandle,TimeCurrent(),Symbol(), EnumToString(ENUM_TIMEFRAMES(_Period)),"Start"); 
   }
   if(DATA){
      data_filehandle=FileOpen(data_file_name,FILE_WRITE|FILE_CSV,';'); 
   }

   if(TICK){
      MqlDateTime time;
      TimeToStruct(TimeCurrent(),time);
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
      
      string tick_filename = path+"\\ChartData\\" +name_bonus +".csv";
      if(FileIsExist(tick_filename)){
         tick_filehandle=FileOpen(tick_filename,FILE_READ|FILE_WRITE|FILE_CSV,';'); 
         if(tick_filehandle!=INVALID_HANDLE){
            FileSeek(tick_filehandle,FileSize(tick_filehandle),SEEK_SET);
         }
         else{
            Print("FILENAME invalid1");    
         }
      }
      else{
         tick_filehandle=FileOpen(tick_filename,FILE_WRITE|FILE_CSV,';'); 
         if(tick_filehandle==INVALID_HANDLE){      
            Print("FILENAME invalid2");    
         }
      }
   }
}

void print_manager::write_log(string message0,string message1,string message2,string message3,string message4,string message5,string message6,string message7,string message8,string message9){
   if(LOG){
      FileWrite(log_filehandle,TimeCurrent(),Symbol(), message0,message1,message2,message3,message4,message5,message6,message7,message8,message9); 
   }
}
void print_manager::write_data(string message0,string message1,string message2,string message3,string message4,string message5,string message6,string message7,string message8,string message9,string message10,string message11){
   if(DATA){
      FileWrite(data_filehandle,TimeCurrent(),Symbol(), message0,message1,message2,message3,message4,message5,message6,message7,message8,message9,message10,message11); 
   }
}
void print_manager::write_result(bool last,string message0,string message1,string message2,string message3,string message4,string message5,string message6,string message7,string message8,string message9,string message10,string message11,string message12,string message13,string message14){
   if(RESULT){
      if(first_init){   
      
            result_file_name = path+ "\\result\\result_" + string(Period()) +"_"+string(result_index) + ".csv";
            result_filehandle=FileOpen(result_file_name,FILE_WRITE|FILE_CSV,';'); 
            
            first_init=false;
            FileWrite(result_filehandle,"Time","Symbol","Name","Profit_Sum","Highest_Loss","Highest_P","Highest_DD","HighestProfitDelta","Points","HighestPoints","m9","","m10","m11","m12","m13","m14");
      }
      FileWrite(result_filehandle,TimeCurrent(),Symbol(),message0,message1,message2,message3,message4,message5,message6,message7,message8,message9,message10,message11,message12,message13,message14);
      if(last){
         FileWrite(result_filehandle,TimeCurrent(),Symbol(),"Stop","","","","","","","","","","","","","","");
      }
   }
}

void print_manager::reopen(){
   if(LOG){
      FileClose(log_filehandle); 
      log_filehandle=FileOpen(log_file_name,FILE_WRITE|FILE_CSV,';');  
   }
   if(DATA){
      FileFlush(data_filehandle);
   }
   if(RESULT){
      FileFlush(result_filehandle);
   }
   if(TICK){
      FileFlush(tick_filehandle);
   }
}
void print_manager::write_tick(string message0,string message1){
   if(TICK){
      FileWrite(tick_filehandle,TimeCurrent(),Symbol(), message0,message1); 
   }
}
void print_manager::tick(){
   if(TICK){
      write_tick(string(SymbolInfoDouble(Symbol(),SYMBOL_BID)),string(SymbolInfoDouble(Symbol(),SYMBOL_ASK)));
   }
}

