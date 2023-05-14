//+------------------------------------------------------------------+
//|                                        ChartDataCollector_V2.mq4 |
//|                                                            Heisl |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

extern  string          FileName = "ChartDataCollector_V2";


class print_manager{
   public:
   
      string filename;
      string path;

      int filehandle;

      print_manager(void);
      print_manager(string fn);
      ~print_manager(void);
      
      
      
      
      void open();
      void reopen();
      void close();

      void write_tick(string message0,string message1);
      void tick();
};

print_manager::print_manager(void){

}

print_manager::print_manager(string fn){
   path = fn;
}

print_manager::~print_manager(void){}

void print_manager::close(){

   FileClose(filehandle);
   Print("Closing files");
}

void print_manager::open(){
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
   
   filename = path+"\\ChartData\\" + string(Symbol()) + "\\" +name_bonus +".csv";
   Print("Path is ",filename);
   if(FileIsExist(filename)){
      filehandle=FileOpen(filename,FILE_READ|FILE_WRITE|FILE_CSV,';'); 
      if(filehandle!=INVALID_HANDLE){
         FileSeek(filehandle,FileSize(filehandle),SEEK_SET);
      }
      else{
         Print("FILENAME invalid1");    
      }
   }
   else{
      filehandle=FileOpen(filename,FILE_WRITE|FILE_CSV,';'); 
      if(filehandle==INVALID_HANDLE){      
         Print("FILENAME invalid2");    
      }
   }
}

void print_manager::reopen(){
   FileFlush(filehandle);
}


void print_manager::write_tick(string message0,string message1){
   FileWrite(filehandle,TimeCurrent(),Symbol(), message0,message1); 
   //Print("Writing - ",TimeCurrent(),"|",Symbol(),"|",message0,"|",message1);
   //reopen();
}
void print_manager::tick(){
   write_tick(string(SymbolInfoDouble(Symbol(),SYMBOL_BID)),string(SymbolInfoDouble(Symbol(),SYMBOL_ASK)));
}


print_manager PrintManager;

int last_hour = 0;
int last_day = 0;
int OnInit(){
   PrintManager = print_manager(FileName);
   return(INIT_SUCCEEDED);
}


void OnDeinit(const int reason){
   PrintManager.close();
}

void OnTick(){
   PrintManager.tick();
   
   if(last_day!=Day()){
      //NEW Hour 
      last_day = Day();
      PrintManager.open();
   }
   else{
      if(last_hour!=Hour()){
         //NEW Hour 
         last_hour = Hour();
         PrintManager.reopen();
      }
   }
}