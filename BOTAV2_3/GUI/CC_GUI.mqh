#include <BOTAV2_3/MISC/GEO.mqh>
#include <BOTAV2_3/Jungler/CopyCat.mqh>

class Bota_GUI_CC{
   private:

      string Panel_State;
      panel Panel;
      label Label;
      
      string Name;
  
      label Sleeping_Label;
      label Target_Label;
      label IS_Label;
      
      /*int index;
      int TF;*/
      
      int pos_x;
      int pos_y;
      
   public:   
      void Bota_GUI_CC(void);
      void ~Bota_GUI_CC(void);
      
      void setPanel(string ps);
      void init_gui();
      void Update();
      
      void set_pos_x(int new_val);
      void set_pos_y(int new_val);
      void set_Name(string new_val);
      
      void set_Panel_State(string new_val);
      void set_IS_Label_Text(string new_val);
      //lable *get_IS_Label 
};

void Bota_GUI_CC::Bota_GUI_CC(){
   Panel_State="Off";
   /*index=-1;
   TF = 0;*/
}

void Bota_GUI_CC::~Bota_GUI_CC(){}

void Bota_GUI_CC::set_pos_x(int new_val){pos_x=new_val;}
void Bota_GUI_CC::set_pos_y(int new_val){pos_y=new_val;}
void Bota_GUI_CC::set_Name(string new_val){Name=new_val;}
void Bota_GUI_CC::set_Panel_State(string new_val){Panel_State=new_val;}
void Bota_GUI_CC::set_IS_Label_Text(string new_val){IS_Label.set_Text(new_val);}

void Bota_GUI_CC::init_gui(){
   //if(index>=0){
      //Name = "CC_"+string(index);
      Panel.set_panel(Name+"_Panel",pos_x,pos_y,65,25,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrGray,2,false);
      
      Panel.Update();
      //-----------------------------------
      
      string sep="_";                
      ushort u_sep;
      u_sep=StringGetCharacter(sep,0);              
      string result[];
      
      //Print("GUINAME2: ",Name);
      
      StringSplit(Name,u_sep,result);
      
      Label.set_label(Name+"_Label",pos_x-5,pos_y-5,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,result[0],"Arial",8,false);
      
      Label.Update();
      
      //-----------------------------------
      Sleeping_Label.set_label(Name+"_Sleeping_Label",pos_x-25,pos_y-1,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrWhite,0,"Z","Arial",15,false);
      Sleeping_Label.Update();
      
      //-----------------------------------
      Target_Label.set_label(Name+"_Target_Label",pos_x-40,pos_y-5,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"","Arial",8,false);
      Target_Label.Update();
      
      //-----------------------------------
      IS_Label.set_label(Name+"_IS_Label",pos_x-48,pos_y-5,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,"","Arial",9,false);
      IS_Label.Update();
   //}
}
void Bota_GUI_CC::setPanel(string ps){
   if(ps == "0"){
      //Panel_State="0";  
      Panel.set_Y(pos_y*100);
      Label.set_Y(pos_y*100);
   }
   
   if(ps == "OK"){
      //Panel_State="OK";  
      Panel.set_Y(pos_y);
      Label.set_Y(pos_y-5);
      Panel.set_BackColor(clrGreen);
      
      Sleeping_Label.set_Text("");
      //Label.Text = "OK";
   }
   if(ps == "OFF"){
      //Panel_State="OFF";  
      Panel.set_Y(pos_y);
      Label.set_Y(pos_y-5);
      Panel.set_BackColor(clrYellow);
      //Label.Text = "OFF";
      
      Sleeping_Label.set_Text("");
   }
   if(ps == "SLEEP"){
      //Panel_State="SLEEP";  
      Panel.set_Y(pos_y);
      Label.set_Y(pos_y-5);
      Panel.set_BackColor(clrGray);
      //Label.Text = "BUY";
      
      Sleeping_Label.set_Text("Z");
   }
   if(ps == "BUY"){
      //Panel_State="SLEEP";  
      Panel.set_Y(pos_y);
      Label.set_Y(pos_y-5);
      Panel.set_BackColor(clrOrange);
      //Label.Text = "BUY";
      
      Sleeping_Label.set_Text("B");
   }
   if(ps == "SELL"){
      //Panel_State="SLEEP";  
      Panel.set_Y(pos_y);
      Label.set_Y(pos_y-5);
      Panel.set_BackColor(clrOrange);
      //Label.Text = "BUY";
      
      Sleeping_Label.set_Text("S");
   }
   if(ps == "BOTH"){
      //Panel_State="SLEEP";  
      Panel.set_Y(pos_y);
      Label.set_Y(pos_y-5);
      Panel.set_BackColor(clrRed);
      //Label.Text = "BUY";
      
      Sleeping_Label.set_Text("&&");
   }
}

void Bota_GUI_CC::Update(){
   setPanel(Panel_State);
   
   
   
   Panel.Update();
   Label.Update();

   Sleeping_Label.Update();
   Target_Label.Update();
   IS_Label.Update();
}


class Bota_GUI_CC_Panel{
   private:
      
      string Name;
      
      panel Panel;
      label Label;
      
      Bota_GUI_CC CC[];
      
      int pos_x;
      int pos_y;
      
   public:   
      void Bota_GUI_CC_Panel(void);
      void ~Bota_GUI_CC_Panel(void);
      
      void add_cc();
      
      void init_gui();
      
      void set_pos_x(int new_val);
      void set_pos_y(int new_val);
      void set_Name(string new_val);

};

void Bota_GUI_CC_Panel::Bota_GUI_CC_Panel(void){}
void Bota_GUI_CC_Panel::~Bota_GUI_CC_Panel(void){}

void Bota_GUI_CC_Panel::set_pos_x(int new_val){pos_x=new_val;}
void Bota_GUI_CC_Panel::set_pos_y(int new_val){pos_y=new_val;}
void Bota_GUI_CC_Panel::set_Name(string new_val){Name=new_val;}

void Bota_GUI_CC_Panel::init_gui(){
      Panel.set_panel(Name+"_Panel",pos_x,pos_y,75,255,BORDER_SUNKEN,CORNER_RIGHT_LOWER,STYLE_SOLID,clrAqua,clrDarkGray,2,false);
      Panel.Update();
      //-----------------------------------
      Label.set_label(Name+"_Label",pos_x-30,pos_y,ANCHOR_LEFT_UPPER,CORNER_RIGHT_LOWER,clrBlack,0,Name,"Arial",8,false);
      Label.Update();
}

void Bota_GUI_CC_Panel::add_cc(){
   int size = ArraySize(CC);
   ArrayResize(CC,size+1);
   CC[size].set_pos_x(pos_x - 5);
   CC[size].set_pos_y(pos_y -15 - 30*size);
}