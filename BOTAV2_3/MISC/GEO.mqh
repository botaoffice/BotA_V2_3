//+------------------------------------------------------------------+
//|                                                          GEO.mqh |
//|                                       Copyright 2022, HEISL INC. |
//|                                           https://www.google.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, Heisl INC."
#property link      "https://www.google.com"
#property strict

//#include <BOTAV2/MISC/MISC.mqh>

class hline {

   private:

   long Chart_ID;
   string Name;
   int SubWindow;
   double Price;
   color Color;
   ENUM_LINE_STYLE Style;
   int Width;
   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
   
   public:
   
   hline();
   hline( string name,  double price, color clr,ENUM_LINE_STYLE style,int width,bool back);//long chart_id,int subwindow,,bool selection,bool hidden,long z_order
   ~hline();
   
   bool Delete();
   void Create();
   void Update();  
   
   void set_Price(double new_price);
   
   string get_Name();
   
};

hline::hline(void){};

hline::hline( string name, double price, color clr,ENUM_LINE_STYLE style,int width,bool back)//long chart_id, int subwindow,,bool selection,bool hidden,long z_order
{
   
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   Price = price;
   Color = clr;
   Style = style;
   Width = width;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order = 0;
}

hline::~hline(void){}


void hline::set_Price(double new_price){
   Price = new_price;
}
string hline::get_Name(){return(Name);}
 
bool hline::Delete(){ 

   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 
      if(!ObjectDelete(Chart_ID,Name)) 
        { 
         Print(__FUNCTION__, 
               ": failed to delete a horizontal line! Error code = ",GetLastError()); 
         return(false); 
        } 
      return(true); 
   }
   else{
      return(false);
   }
}

void hline::Create(){
   if(!Price) 
      Price=SymbolInfoDouble(Symbol(),SYMBOL_BID); 
   ResetLastError();
   if(!ObjectCreate(Chart_ID,Name,OBJ_HLINE,SubWindow,0,Price)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a horizontal line! Error code = ",GetLastError());  
     } 
}
   
void hline::Update(){ 
   if (ObjectFind(0,Name)<0){
      Create();
   }
   ResetLastError(); 
   double old_price = ObjectGetDouble(Chart_ID,Name,OBJPROP_PRICE,0);
   if(Price!=old_price){
      if(!ObjectMove(Chart_ID,Name,0,0,Price)) { 
         Print(__FUNCTION__, 
               ": failed to move the horizontal line! Error code = ",GetLastError()); 
      } 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_STYLE,Style);  
      ObjectSetInteger(Chart_ID,Name,OBJPROP_WIDTH,Width); 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
      ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   }
}



//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------

class tline {

private:

   long Chart_ID;
   string Name;
   int SubWindow;

   datetime Time1;
   double Price1;
   datetime Time2;
   double Price2;
   bool Ray_Left;
   bool Ray_Right;            

   color Color;
   ENUM_LINE_STYLE Style;
   int Width;
   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
   
public:
   tline();
   tline(string name,datetime time1,double price1, datetime time2,double price2,bool ray_left,bool ray_right, color clr,ENUM_LINE_STYLE style,int width,bool back);
   ~tline();
   void Create();
   void Delete();
   void Update();
   
   void set_tline(string name, datetime time1,double price1, datetime time2,double price2,bool ray_left,bool ray_right, color clr,ENUM_LINE_STYLE style,int width,bool back);
   void set_LineVal(datetime t1_new,double price1_new,datetime t2_new,double price2_new);
   void set_Time2(datetime new_time);
   void set_Price1(double new_price);
   void set_Price2(double new_price);
   
   double get_Price1();
};  

tline::tline(void){}

tline::tline(string name, datetime time1,double price1, datetime time2,double price2,bool ray_left,bool ray_right, color clr,ENUM_LINE_STYLE style,int width,bool back){
   //Print("Name:",name);
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   Time1 = time1;
   Price1 = price1;
   Time2 = time2;
   Price2 = price2;
   Ray_Left = ray_left;
   Ray_Right = ray_right;
   Color = clr;
   Style = style;
   Width = width;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order = 0;
}
tline::~tline(void){}

void tline::set_tline(string name, datetime time1,double price1, datetime time2,double price2,bool ray_left,bool ray_right, color clr,ENUM_LINE_STYLE style,int width,bool back){
   //Print("Name2:",name);
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   Time1 = time1;
   Price1 = price1;
   Time2 = time2;
   Price2 = price2;
   Ray_Left = ray_left;
   Ray_Right = ray_right;
   Color = clr;
   Style = style;
   Width = width;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order = 0;
   
   Update();
}

void tline::set_LineVal(datetime t1_new,double price1_new,datetime t2_new,double price2_new){
   Time1 = t1_new;
   Price1 = price1_new;
   Time2 = t2_new;
   Price2 = price2_new;
   
   Update();
}
void tline::set_Time2(datetime new_time){
   Time2 = new_time;
   
   Update();
}
void tline::set_Price1(double new_price){
   Price1 = new_price;
   
   Update();
}
void tline::set_Price2(double new_price){
   Price2 = new_price;
   
   Update();
}
double tline::get_Price1(){return(Price1);
}
void tline::Create(){ 
   ResetLastError();   
   if(!ObjectCreate(Chart_ID,Name,OBJ_TREND,SubWindow,Time1,Price1,Time2,Price2)) { 
      Print(__FUNCTION__, 
         ": failed to create a trend line! Error code = ",GetLastError(),"|",Name,"|",Time1,"|",Price1,"|",Time2,"|",Price2);  
   } 
} 

void tline::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a trend line! Error code = ",GetLastError()); 
      } 
   }
}


void tline::Update(){
   //Print("Update-",Name);
   if (ObjectFind(0,Name)<0){
      //Print("Object not found-",Name);
      Create();
   }
   
   if(!ObjectMove(Chart_ID,Name,0,Time1,Price1)) { 
      Print(__FUNCTION__, 
         ": failed to move the anchor point! Error code = ",GetLastError(),"|",Name,"|",Time1,"|",Price1); 
   }
   else{
      //Print("Object moved-",Name);
   }
   if(!ObjectMove(Chart_ID,Name,1,Time2,Price2)) { 
      Print(__FUNCTION__, 
         ": failed to move the anchor point! Error code = ",GetLastError(),"|",Name,"|",Time2,"|",Price2); 
   }
   else{
      //Print("Object moved2-",Name);
   }
   ResetLastError(); 
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_STYLE,Style); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_WIDTH,Width); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_RAY_LEFT,Ray_Left); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_RAY_RIGHT,Ray_Right); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
}


//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------


class vline {

private:

   long Chart_ID;
   string Name;
   int SubWindow;
   datetime VTime;
   color Color;
   ENUM_LINE_STYLE Style;
   int Width;
   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
  
public:
   vline(void);
   vline(string name, datetime time, color clr,ENUM_LINE_STYLE style,int width,bool back);
   ~vline(void);
   
   bool Create();
   bool Delete();
   bool Update();
   
   void set_VTime(datetime new_time);
   void set_vline(string name, datetime time, color clr,ENUM_LINE_STYLE style,int width,bool back);
};

vline::vline(void){};

vline::vline(string name, datetime time, color clr,ENUM_LINE_STYLE style,int width,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   VTime = time;
   Color = clr;
   Style = style;
   Width = width;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order = 0;

}
vline::~vline(void){Delete();};

void vline::set_vline(string name, datetime time, color clr,ENUM_LINE_STYLE style,int width,bool back){
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   VTime = time;
   Color = clr;
   Style = style;
   Width = width;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order = 0;
}

void vline::set_VTime(datetime new_time){VTime = new_time;}
   
bool vline::Create(){ 
   ResetLastError(); 
   if(!ObjectCreate(Chart_ID,Name,OBJ_VLINE,SubWindow,VTime,0)) { 
      Print(__FUNCTION__, 
         ": failed to create a trend line! Error code = ",GetLastError());  
      return(false);
   } 
   return(true);
} 
   
bool vline::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a trend line! Error code = ",GetLastError()); 
         return(false);
      } 
      return(true);
   }
   return(false);
}

   
bool vline::Update(){
   if (ObjectFind(0,Name)<0){
      Create();
   }
   if(!ObjectMove(Chart_ID,Name,0,VTime,0)) { 
      Print(__FUNCTION__, 
         ": failed to move the anchor point! Error code = ",GetLastError()); 
   }
   ResetLastError(); 
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_STYLE,Style); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_WIDTH,Width); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   
   return(true);
}

class button {

private:
   long Chart_ID;
   string Name;
   int SubWindow;
   
   int X;
   int Y;
   int Width;
   int Height;
   ENUM_BASE_CORNER Corner;
   
   string Text;
   string Font;
   int FontSize;
   color Color;
   
   color BackColor; 
   color  BorderColor;
   
   bool State;

   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
  
public:

   button(void);
   button(  string name,int x,int y,int width,int height,ENUM_BASE_CORNER corner,
            string text,string font,int fontsize,color c,
            color backcolor,color  bordercolor,bool state,bool back);
   ~button(void);
   
   bool Create();
   bool Delete();
   bool Update();
   
   void set_button(string name,int x,int y,int width,int height,ENUM_BASE_CORNER corner,
                  string text,string font,int fontsize,color c,
                  color backcolor,color  bordercolor,bool state,bool back);
   string get_Name();
   
   void set_State(bool new_state);
   void set_Text(string new_text);
   void set_Color(color new_color);
   void set_Y(int new_y);
   
};
button::button(void){}
   
button::button( string name, int x,int y,int width,int height,ENUM_BASE_CORNER corner,
               string text,string font,int fontsize,color c,
               color backcolor,color  bordercolor,bool state,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   X=x;
   Y=y;
   Width=width;
   Height=height;
   Corner = corner;
   Text = text;
   Font = font;
   FontSize = fontsize;
   Color = c;
   BackColor = backcolor;
   BorderColor = bordercolor;
   State = state;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
   
   Create();
}
button::~button(void){
   Delete();
};
string button::get_Name(void){return(Name);}

void button::set_State(bool new_state){State=new_state;}
void button::set_Text(string new_text){Text=new_text;}
void button::set_Color(color new_color){Color=new_color;}
void button::set_Y(int new_y){Y=new_y;}

void button::set_button(string name,int x,int y,int width,int height,ENUM_BASE_CORNER corner,string text,string font,int fontsize,color c,color backcolor,color bordercolor,bool state,bool back){
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   X=x;
   Y=y;
   Width=width;
   Height=height;
   Corner = corner;
   Text = text;
   Font = font;
   FontSize = fontsize;
   Color = c;
   BackColor = backcolor;
   BorderColor = bordercolor;
   State = state;
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
}
      
bool button::Create(){ 
   ResetLastError(); 
   if(!ObjectCreate(Chart_ID,Name,OBJ_BUTTON,SubWindow,X,Y)) { 
      Print(__FUNCTION__, 
         ": failed to create a button! Error code = ",GetLastError());  
      return(false);
   } 
   return(true);
} 
   
bool button::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a button! Error code = ",GetLastError()); 
         return(false);
      } 
      return(true);
   }
   return(false);
}

   
bool button::Update(){
   if (ObjectFind(0,Name)<0){
      Create();
   }
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XDISTANCE,X); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YDISTANCE,Y); 
//--- set button size 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XSIZE,Width); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YSIZE,Height); 
//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_CORNER,Corner); 
//--- set the text 
   ObjectSetString(Chart_ID,Name,OBJPROP_TEXT,Text); 
//--- set text font 
   ObjectSetString(Chart_ID,Name,OBJPROP_FONT,Font); 
//--- set font size 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_FONTSIZE,FontSize); 
//--- set text color 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
//--- set background color 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BGCOLOR,BackColor); 
//--- set border color 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BORDER_COLOR,BorderColor); 
//--- display in the foreground (false) or background (true) 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
//--- set button state 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_STATE,State); 
//--- enable (true) or disable (false) the mode of moving the button by mouse 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   return(true);
}



class panel {

private:
   long Chart_ID;
   string Name;
   int SubWindow;
   
   int X;
   int Y;
   int Width;
   int Height;
   
   ENUM_BORDER_TYPE Border;
   ENUM_BASE_CORNER Corner;
   ENUM_LINE_STYLE Style;
   
   color Color;
   color BackColor; 

   int LineWidth;             

   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
  
public:
   panel(void);
   panel( string name,int x,int y,int width,int height,ENUM_BORDER_TYPE border,ENUM_BASE_CORNER corner,ENUM_LINE_STYLE style,
            color c, color backcolor,int linewidth,bool back);
   ~panel(void);
   
   bool Create();
   bool Delete();
   bool Update();
   
   void set_panel( string name,int x,int y,int width,int height,ENUM_BORDER_TYPE border,ENUM_BASE_CORNER corner,ENUM_LINE_STYLE style,
            color c, color backcolor,int linewidth,bool back);
   
   void set_Y(int new_y);   
   void set_BackColor(color new_backcolor);      
};
panel::panel(void){}
   
panel::panel(string name,int x,int y,int width,int height,ENUM_BORDER_TYPE border, ENUM_BASE_CORNER corner,ENUM_LINE_STYLE style,
            color c, color backcolor,int linewidth,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   X=x;
   Y=y;
   Width=width;
   Height=height;
   
   Border=border;
   Corner = corner;
   Style = style;

   Color = c;
   BackColor = backcolor;
   LineWidth = linewidth;

   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
   
   Create();
}
panel::~panel(void){
   Delete();
};
void panel::set_panel( string name,int x,int y,int width,int height,ENUM_BORDER_TYPE border,ENUM_BASE_CORNER corner,ENUM_LINE_STYLE style,
            color c, color backcolor,int linewidth,bool back){
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   X=x;
   Y=y;
   Width=width;
   Height=height;
   
   Border=border;
   Corner = corner;
   Style = style;
   
   Color = c;
   BackColor = backcolor;
   LineWidth = linewidth;
   
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;         
}
void panel::set_Y(int new_y){Y=new_y;}  
void panel::set_BackColor(color new_backcolor){BackColor = new_backcolor;}
     
bool panel::Create(){ 
   ResetLastError(); 
   if(!ObjectCreate(Chart_ID,Name,OBJ_RECTANGLE_LABEL,SubWindow,X,Y)) { 
      Print(__FUNCTION__, 
         ": failed to create a button! Error code = ",GetLastError());  
      return(false);
   } 
   return(true);
} 
   
bool panel::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a button! Error code = ",GetLastError()); 
         return(false);
      } 
      return(true);
   }
   return(false);
}

   
bool panel::Update(){
   if (ObjectFind(0,Name)<0){
      Create();
   }
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XDISTANCE,X); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YDISTANCE,Y); 
//--- set button size 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XSIZE,Width); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YSIZE,Height); 
//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BORDER_TYPE,Border); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_CORNER,Corner); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_STYLE,Style); 
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BGCOLOR,BackColor); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_WIDTH,LineWidth); 

   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   return(true);
}


class edit_field{

private:
   long Chart_ID;
   string Name;
   int SubWindow;
   
   int X;
   int Y;
   int Width;
   int Height;
   
   ENUM_ALIGN_MODE Align;
   ENUM_BASE_CORNER Corner;

   color Color;
   color BackColor; 
   color  BorderColor;
   
   string Text;
   string Font;
   int FontSize;  
   
   bool ReadOnly;
               

   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
  
public:
   edit_field(void);
   edit_field(string name,int x,int y,int width,int height,ENUM_ALIGN_MODE align,ENUM_BASE_CORNER corner,
               color c, color backcolor,color bordercolor,string text, string font, int fontsize,bool back);
   ~edit_field(void);
   
   bool Create();
   bool Delete();
   bool Update();
   
   void set_editfield(string name,int x,int y,int width,int height,ENUM_ALIGN_MODE align,ENUM_BASE_CORNER corner,
               color c, color backcolor,color bordercolor,string text, string font, int fontsize,bool back);
   void set_Y(int new_y);
   string get_Text();
};
edit_field::edit_field(void){}
   
edit_field::edit_field(string name,int x,int y,int width,int height,ENUM_ALIGN_MODE align,ENUM_BASE_CORNER corner,
            color c, color backcolor,color bordercolor,string text, string font, int fontsize,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   X=x;
   Y=y;
   Width=width;
   Height=height;
   
   Align=align;
   Corner = corner;

   Color = c;
   BackColor = backcolor;
   BorderColor = bordercolor;
   
   Text = text;
   Font = font;
   FontSize = fontsize;

   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
   
   Create();
}
edit_field::~edit_field(void){
   Delete();
};

void edit_field::set_editfield(string name,int x,int y,int width,int height,ENUM_ALIGN_MODE align,ENUM_BASE_CORNER corner,
            color c, color backcolor,color bordercolor,string text, string font, int fontsize,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   X=x;
   Y=y;
   Width=width;
   Height=height;
   
   Align=align;
   Corner = corner;

   Color = c;
   BackColor = backcolor;
   BorderColor = bordercolor;
   
   Text = text;
   Font = font;
   FontSize = fontsize;

   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
}
void edit_field::set_Y(int new_y){Y=new_y;} 
string edit_field::get_Text(){return(Text);} 


bool edit_field::Create(){ 
   ResetLastError(); 
   if(!ObjectCreate(Chart_ID,Name,OBJ_EDIT,SubWindow,X,Y)) { 
      Print(__FUNCTION__, 
         ": failed to create a button! Error code = ",GetLastError());  
      return(false);
   } 
   return(true);
} 
   
bool edit_field::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a button! Error code = ",GetLastError()); 
         return(false);
      } 
      return(true);
   }
   return(false);
}

   
bool edit_field::Update(){
   if (ObjectFind(0,Name)<0){
      Create();
   }
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XDISTANCE,X); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YDISTANCE,Y); 
//--- set button size 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XSIZE,Width); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YSIZE,Height); 
//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ALIGN,Align);  
   ObjectSetInteger(Chart_ID,Name,OBJPROP_CORNER,Corner); 

   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BGCOLOR,BackColor); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_BORDER_COLOR,BorderColor);  

   ObjectSetString(Chart_ID,Name,OBJPROP_TEXT,Text);  
   ObjectSetString(Chart_ID,Name,OBJPROP_FONT,Font); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_FONTSIZE,FontSize); 

   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   return(true);
}

class label{

private: 
   long Chart_ID;
   string Name;
   int SubWindow;
   
   int X;
   int Y;
   
   ENUM_ANCHOR_POINT Anchor;
   ENUM_BASE_CORNER Corner;

   color Color;

   string Text;
   string Font;
   int FontSize;
   
   double Angle;

   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
  
public:
   label(void);
   label( string name,int x,int y,ENUM_ANCHOR_POINT anchor,ENUM_BASE_CORNER corner,
            color c,double angle,string text, string font, int fontsize, bool back);
   ~label(void);
   
   bool Create();
   bool Delete();
   bool Update();
   
   void set_label(string name,int x,int y,ENUM_ANCHOR_POINT anchor,ENUM_BASE_CORNER corner,
                  color c,double angle,string text, string font, int fontsize, bool back);
   void set_Text(string new_text);
   void set_Y(int new_y);
};
label::label(void){}
   
label::label(string name,int x,int y,ENUM_ANCHOR_POINT anchor,ENUM_BASE_CORNER corner,
            color c,double angle,string text, string font, int fontsize,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   X=x;
   Y=y;

   
   Anchor=anchor;
   Corner = corner;

   Color = c;
   Angle = angle;
   
   Text = text;
   Font = font;
   FontSize = fontsize;

   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;

   Create();
}
label::~label(void){
   Delete();
};

void label::set_label(string name,int x,int y,ENUM_ANCHOR_POINT anchor,ENUM_BASE_CORNER corner,
            color c,double angle,string text, string font, int fontsize,bool back){
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   X=x;
   Y=y;

   
   Anchor=anchor;
   Corner = corner;

   Color = c;
   Angle = angle;
   
   Text = text;
   Font = font;
   FontSize = fontsize;

   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
}  
void label::set_Text(string new_text){Text = new_text;}  
void label::set_Y(int new_y){Y = new_y;} 

bool label::Create(){ 
   ResetLastError(); 
   if(!ObjectCreate(Chart_ID,Name,OBJ_LABEL,SubWindow,X,Y)) { 
      Print(__FUNCTION__, 
         ": failed to create a button! Error code = ",GetLastError());  
      return(false);
   } 
   return(true);
} 
   
bool label::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a button! Error code = ",GetLastError()); 
         return(false);
      } 
      return(true);
   }
   return(false);
}

   
bool label::Update(){
   if (ObjectFind(0,Name)<0){
      Create();
   }
   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_XDISTANCE,X); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_YDISTANCE,Y); 

//--- set the chart's corner, relative to which point coordinates are defined 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ANCHOR,Anchor);   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_CORNER,Corner); 

   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
   ObjectSetDouble(Chart_ID,Name,OBJPROP_ANGLE,Angle);  

   ObjectSetString(Chart_ID,Name,OBJPROP_TEXT,Text);  
   ObjectSetString(Chart_ID,Name,OBJPROP_FONT,Font); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_FONTSIZE,FontSize); 

   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   return(true);
}



class rectangle{

private:
   long Chart_ID;
   string Name;
   int SubWindow;
   
   datetime Time1;
   double Price1;
   datetime Time2;
   double Price2;
   
   color Color;
   ENUM_LINE_STYLE Style;
   int Width;
   bool Fill;
   
   bool Back;
   bool Selection;
   bool Hidden;
   long Z_Order;
  
public: 
   rectangle(void);
   rectangle(string name,datetime time1,double price1,datetime time2,double price2,
            color c,ENUM_LINE_STYLE style,int width,bool fill,bool back);
   ~rectangle(void);
   
   bool Create();
   bool Delete();
   bool Update();
   
   void set_rectangle(string name,datetime time1,double price1,datetime time2,double price2,
            color c,ENUM_LINE_STYLE style,int width,bool fill,bool back);
   void set_Price1(double new_price1);
   void set_Price2(double new_price2);
   void set_Time1(datetime new_time1);
   void set_Time2(datetime new_time2);
   void set_Color(color new_color);
   
   
   double get_Price1();
   double get_Price2();
};
rectangle::rectangle(void){}

rectangle::rectangle(string name,datetime time1,double price1,datetime time2,double price2,
            color c,ENUM_LINE_STYLE style,int width,bool fill,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   Time1=time1;
   Price1=price1;
   Time2=time2;
   Price2=price2;
   
   Color=c;
   Style=style;
   Width=width;
   Fill=fill;
   
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;

   Create();
}
rectangle::~rectangle(void){
   Delete();
};

void rectangle::set_rectangle(string name,datetime time1,double price1,datetime time2,double price2,
            color c,ENUM_LINE_STYLE style,int width,bool fill,bool back)
{
   Chart_ID = 0;
   Name = name;
   SubWindow = 0;
   
   Time1=time1;
   Price1=price1;
   Time2=time2;
   Price2=price2;
   
   Color=c;
   Style=style;
   Width=width;
   Fill=fill;
   
   Back = back;
   Selection = false;
   Hidden = false;
   Z_Order=0;
}   
void rectangle::set_Price1(double new_price1){Price1 = new_price1;}
void rectangle::set_Price2(double new_price2){Price2 = new_price2;}
void rectangle::set_Time1(datetime new_time1){Time1 = new_time1;}
void rectangle::set_Time2(datetime new_time2){Time2 = new_time2;}
void rectangle::set_Color(color new_color){Color = new_color;}

double rectangle::get_Price1(){return(Price1);}
double rectangle::get_Price2(){return(Price2);}

bool rectangle::Create(){ 
   ResetLastError(); 
   if(!ObjectCreate(Chart_ID,Name,OBJ_RECTANGLE,SubWindow,Time1,Price1,Time2,Price2)) { 
      Print(__FUNCTION__, 
         ": failed to create a button! Error code = ",GetLastError());  
      return(false);
   } 
   return(true);
} 
   
bool rectangle::Delete(){ 
   if (ObjectFind(0,Name)>=0){
      ResetLastError(); 

      if(!ObjectDelete(Chart_ID,Name)){ 
         Print(__FUNCTION__, 
            ": failed to delete a button! Error code = ",GetLastError()); 
         return(false);
      } 
      return(true);
   }
   return(false);
}

   
bool rectangle::Update(){
   if (ObjectFind(0,Name)<0){
      Create();
   }
   
   
   if(!ObjectMove(Chart_ID,Name,0,Time1,Price1)) { 
      Print(__FUNCTION__, 
         ": failed to move the anchor point! Error code = ",GetLastError()); 
   }
   if(!ObjectMove(Chart_ID,Name,1,Time2,Price2)) { 
      Print(__FUNCTION__, 
         ": failed to move the anchor point! Error code = ",GetLastError()); 
   }

   
   ObjectSetInteger(Chart_ID,Name,OBJPROP_COLOR,Color); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_STYLE,Style); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_WIDTH,Width); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_FILL,Fill); 

   ObjectSetInteger(Chart_ID,Name,OBJPROP_BACK,Back); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTABLE,Selection); 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_SELECTED,Selection); 
//--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_HIDDEN,Hidden); 
//--- set the priority for receiving the event of a mouse click in the chart 
   ObjectSetInteger(Chart_ID,Name,OBJPROP_ZORDER,Z_Order); 
   return(true);
}