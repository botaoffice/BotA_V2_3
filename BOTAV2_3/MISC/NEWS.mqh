//+------------------------------------------------------------------+
//|                                                         NEWS.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

class news{
   private:

      string Name;
      string Country;
      datetime NewsTime;
      string Impact;
   public:
   news(void);
   news(string n,string c, datetime t, string i);
   ~news(void);
   
   void set_Name(string new_name);
   void set_Country(string new_country);
   void set_NewsTime(datetime new_time);
   void set_Impact(string new_impact);
   
   string get_Country();
   datetime get_NewsTime();
   string get_Impact();
};
news::news(void){
}
news::~news(void){}

news::news(string n,string c, datetime t, string i){
   Name = n;
   Country = c;
   NewsTime = t;
   Impact = i;
}

void news::set_Name(string new_name){Name = new_name;}
void news::set_Country(string new_country){Country = new_country;}
void news::set_NewsTime(datetime new_time){NewsTime = new_time;}
void news::set_Impact(string new_impact){Impact = new_impact;}

string news::get_Country(){return(Country);}
datetime news::get_NewsTime(){return(NewsTime);}
string news::get_Impact(){return(Impact);}

class array_news{
private:   
      
      string save_path;
      int Size;
public:  
      news News[];
    
      array_news(void);
      array_news(string sp);
      ~array_news(void);
      
      void get_News();   
      int get_Size();
};

array_news::array_news(void){
   save_path="";
   Size=0;
}
array_news::array_news(string sp){
   save_path=sp;
   Size=0;
}
array_news::~array_news(void){}

int array_news::get_Size(void){return(Size);}

void array_news::get_News() { 
   string cookie=NULL, headers;
   string reqheaders="User-Agent: Mozilla/4.0\r\n";
   char post[],result[];
   int res;
   string url="https://nfs.faireconomy.media/ff_calendar_thisweek.xml";
   //string url="http://www.forexfactory.com/ffcal_week_this.xml";
   ResetLastError();
   int timeout=5000;
   res=WebRequest("GET",url,reqheaders,timeout,post,result,headers);
   if(res==-1){
      Print("Error in WebRequest. Error code  =",GetLastError());
      //--- Perhaps the URL is not listed, display a message about the necessity to add the address
      MessageBox("Add the address '"+url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION);
   }
   else{
      //--- Load successfully
      PrintFormat("The file has been successfully loaded, File size =%d bytes.",ArraySize(result));
      //--- Save the data to a file
      
      
      
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
      
      string full_path = save_path + "\\NewsData\\" + name_bonus;
         
      int filehandle=FileOpen(full_path+".csv",FILE_WRITE|FILE_BIN);
      //--- Checking errors
      if(filehandle!=INVALID_HANDLE){
         //--- Save the contents of the result[] array to a file
         FileWriteArray(filehandle,result,0,ArraySize(result));
         //--- Close the file
         FileClose(filehandle);
      } 
      string word = "";
      
      bool word_done = false;
      
      bool nextword_name = false;
      bool nextword_country = false;
      bool nextword_time1 = false;
      bool nextword_time2 = false;
      bool nextword_impact = false;
      
      string time1 = "";
      string time2 = "";
      string imp = "";
      MqlDateTime full_time;
      
      for(int i =0;i<ArraySize(result);i++){
         word = word + CharToStr(result[i]); 
         
         if(CharToStr(result[i]) == "<"){
            word_done = false;
         }
         else{
            if(CharToStr(result[i]) == ">"){
               word_done =true;
            }
            else{
               word_done = false;
               if(ArraySize(result)-1 > i){
                  if(CharToStr(result[i+1]) == "<"){
                     word_done =true;
                     
                  }
               }
            }
         }
         
         if(word_done){
            
            if(nextword_name){
               News[ArraySize(News)-1].set_Name(word);
               nextword_name=false;
            }
            if(nextword_country){
               News[ArraySize(News)-1].set_Country(word);
               nextword_country=false;
            }
            if(nextword_time1){
               time1 = remove_trash(word);
               
               string time_help[];
               string sep = "-";
               ushort u_sep;
               u_sep=StringGetCharacter(sep,0);
               
               StringSplit(time1,u_sep,time_help);

               full_time.mon = int(time_help[0]);
               full_time.day = int(time_help[1]);
               full_time.year = int(time_help[2]);
               
               nextword_time1=false;
            }
            if(nextword_time2){
            
               time2 = remove_trash(word);
               
               
               string time_help2[];
               string sep2 = ":";
               ushort u_sep2;

               u_sep2=StringGetCharacter(sep2,0);
               
               StringSplit(time2,u_sep2,time_help2);

               full_time.hour = int(time_help2[0]);
               full_time.min = int(time_help2[1]);
               full_time.sec = 0;
               
               News[ArraySize(News)-1].set_NewsTime(StructToTime(full_time));
               nextword_time2=false;
            }
            
            if(nextword_impact){
            
               imp = remove_trash(word);
               News[ArraySize(News)-1].set_Impact(imp);
               nextword_impact=false;
            }
            
            if(word == "<event>"){
               ArrayResize(News,ArraySize(News)+1);
               Size+=1;
               News[ArraySize(News)-1] = news();   
            }
            if(word == "<title>"){
               nextword_name = true;
            }
            if(word == "<country>"){
               nextword_country = true;
            }
            if(word == "<date>"){
               nextword_time1 = true;
            }
            if(word == "<time>"){
               nextword_time2 = true;
            }
            if(word == "<impact>"){
               nextword_impact = true;
            }
            
            word = "";
         }
      }
   }
   ArrayFree(post);
   ArrayFree(result);
}

string remove_trash(string s){
   StringReplace(s,"<![CDATA[","");
   StringReplace(s,"]","");
   StringReplace(s,">","");
   StringReplace(s,"am","");
   StringReplace(s,"pm","");
                  
   return(s);
}