/*Countdown Timer v5
Final version by SHSCOUNTDOWN

Background ideas:
    Solar system


//Notification for bottle of beer counter on april fools day!!

Features:
    Online feature syncing (Sync dates)
    Set custom date
    Days, hours, minutes, seconds left
    Real time school time
    Day and schedule
    Custom sync (Saved with cookies)
    
    Notifications
        Class end
        Reminder for no school and important dates
        Weather?
    
    Various animated backgrounds
        https://www.youtube.com/watch?v=d0uFvhCHWCo
    Alert when class is about to end
    Alert time (5 minutes early, 4, 3, 2, 1, 30 seconds)
    
    Lab, summer days, schedule
    Quotes and newsfeed
    
    Possible powerschool notifications
    Mobile mode
    
    Easter egg for april fools day
    
*/

//Do some js preloading and stuff
/*@pjs font='thin.ttf,bold.ttf';*/

PFont font; //The fancy font we're going to be using
PFont bold; //The bolder font

int sizeX,sizeY;
Time time;
PageScroller scroller;
Quote quote;
NotificationCenter notifications;
Save save;

PImage back_button;
int scroll = 0;

boolean debug = false;

//Checkboxes and shit
CheckBox notification_class;
Button custom_sync_button, not_delay_button, custom_day_button;
Multilist custom_day_selector, not_delay_selector;
BackSelector back_select;
Button back_select_button_temp;

//Other variables
var NEWS_TODAY = ["NEW RELEASE","Release of countdown timer 5.0! Tell all your friends!"];
var backgrounds = [];

void setup(){
    back_button = requestImage("img/button.png");
    size(window.innerWidth, window.innerHeight);
    sizeX = window.innerWidth;
    sizeY = window.innerHeight;
    
    //Set the font
    font = createFont("thin.ttf", 60);
    bold = createFont("bold.ttf", 60);
    textFont(font);
    
    time = new Time();
    scroller = new PageScroller(3);
    quote = new Quote();
    
    notifications = new NotificationCenter();
    notifications.add(new Notification(color(0,0,0,150),NEWS_TODAY[1],NEWS_TODAY[0],3));
    if(time.get_day() == "A" || time.get_day() == "B" || time.get_day() == "C" || time.get_day() == "D")
        notifications.add(new Notification(color(0,0,0,150),"Lab reminder for anyone who has lab the second half of lunch.","LAB REMINDER",1));
    else if(time.get_day() == "E")
        notifications.add(new Notification(color(0,0,0,150),"AP Lab reminder for anyone who has AP lab the second half of lunch.","AP LAB REMINDER",1));
    else if(time.get_day() == "NOSCHOOL")
        notifications.add(new Notification(color(0,0,0,150),"Have a nice weekend/no school day!","HAVE A NICE DAY",3));
    var n = time.get_notifications();
    for(int i=0;i<n.length;i++){
        notifications.add( n[i] );
    }
    notifications.add(new Notification(color(0,0,0,150),"I lost my text file of 3000 random facts :(","RANDOM FACT",4));
    
    frameRate(1200); //To avoid lag use MAX CPU!!! (Valid programming not bad code ;P)

    //Checkboxes
    notification_class = new CheckBox(true, color(#F44336));
    custom_sync_button = new Button(color(#F44336), "SYNC");
    not_delay_button   = new Button(color(#F44336), "DELY");
    custom_day_button  = new Button(color(#F44336), "CDAY");
    back_select_button_temp = new Button(color(0),"HI");
    
    custom_day_selector = new Multilist( ["ABCD","E DAY", "HALF", "MIDTERM", "PARCC", "PARCC2", "DEFAULT"], color(#F44336));
    not_delay_selector  = new Multilist( ["30 SECONDS", "45 SECONDS", "1 MINUTE", "2 MINUTES", "3 MINUTES"], color(#F44336));
    
    save = new Save(time.TIMESHIFT);
    time.TIMESHIFT = save.TIMESHIFT;
    notification_class.selected = save.notification;
    time.CLASSTIMEMAX = save.CLASSTIMEMAX;
    
    backgrounds.push(
        requestImage("img/forest.jpg"),
        requestImage("img/lake.jpg"),
        requestImage("img/mountain.jpg"),
        requestImage("img/mountain2.jpg"),
        requestImage("img/ocean.jpg"),
        requestImage("img/temple.jpg"),
        requestImage("img/aurora.jpg"),
        requestImage("img/lights.jpg"),
        requestImage("img/space.jpg"),
        requestImage("img/fractal.jpg"),
        requestImage("img/city.jpg")
    );
    
    back_select = new BackSelector();
    back_select.selected = save.back;

}


void draw(){
    if(frameCount%30 == 0){
        save.update( notification_class.selected , time.TIMESHIFT , time.CLASSTIMEMAX, back_select.selected );
    
        size(window.innerWidth, window.innerHeight, P2D); //Resize window as needed
        sizeX = window.innerWidth;
        sizeY = window.innerHeight;
    }
    if(sizeY > sizeX){
        //Shitty rotation mechanics :)
        translate(sizeX/2,sizeY/2);
        rotate(PI/2);
        translate(-sizeX/2,-sizeY/2);

    }
    
    background(50);
    image(backgrounds[ back_select.selected ],0,0,sizeX,sizeY);
    
    pushMatrix();
    translate(scroll,0); //scroll

    //Background shadow
    fill(0,0,0,100);
    rect(0, sizeY*0.4 - sizeX/20 - sizeX/40, sizeX,  sizeX/10 + sizeX/160 + sizeX*4.8/40 );
    
    //Main countdown for school ends
    fill(255); textAlign(CENTER,CENTER); textSize(sizeX/10); 
    String time_left = time.time_left_str();
    
    text( time.schoolDaysLeft() ,sizeX*0.2 ,sizeY*0.4);
    text( time_left.split(":")[0] ,sizeX*0.4 ,sizeY*0.4);
    text( time_left.split(":")[1] ,sizeX*0.6 ,sizeY*0.4);
    text( time_left.split(":")[2] ,sizeX*0.8 ,sizeY*0.4);
    
    textSize(sizeX/40);
    text( "SCH. DAYS" ,sizeX*0.2 ,sizeY*0.4 - sizeX/20);
    text( "HOURS" ,sizeX*0.4 ,sizeY*0.4 - sizeX/20);
    text( "MINUTES" ,sizeX*0.6 ,sizeY*0.4 - sizeX/20);
    text( "SECONDS" ,sizeX*0.8 ,sizeY*0.4 - sizeX/20);

    height_n = sizeX/640;
    noStroke();
            
    //Percentage bar to cover gradient
    fill(50); 
    /*rect( sizeX*0.2 - sizeX/20 + sizeX/10 * (1 - time.schoolDaysLeft()/180.0)  ,sizeY*0.4 + sizeX/20 + height_n, sizeX/10 * (time.schoolDaysLeft()/180.0) + 1, height_n + 1);
    rect( sizeX*0.4 - sizeX/20 + sizeX/10 * (minute()/60.0)  ,sizeY*0.4 + sizeX/20 + height_n, sizeX/10 * (1 - minute()/60.0)  + 1, height_n  + 1);
    rect( sizeX*0.6 - sizeX/20 + sizeX/10 * (second()/60.0) ,sizeY*0.4 + sizeX/20 + height_n,  sizeX/10 * (1 - second()/60.0)+ 1, height_n  + 1);
    rect( sizeX*0.8 - sizeX/20 + sizeX/10 * (new Date().getMilliseconds()/1000.0) ,sizeY*0.4 + sizeX/20 + height_n, sizeX/10 * (1 - new Date().getMilliseconds()/1000.0) + 1, height_n  + 1);
    */
    loading_y = sizeY*0.4 + sizeX/20;
    rect( sizeX*0.2 - sizeX/20   ,loading_y + height_n, sizeX/10 , height_n + 1);
    rect( sizeX*0.4 - sizeX/20   ,loading_y + height_n, sizeX/10 , height_n  + 1);
    rect( sizeX*0.6 - sizeX/20   ,loading_y + height_n,  sizeX/10 , height_n  + 1);
    rect( sizeX*0.8 - sizeX/20   ,loading_y + height_n, sizeX/10 , height_n  + 1);
    
    fill(255,100,0); rect( sizeX*0.2 - sizeX/20 ,loading_y + height_n, sizeX/10 * (1 - time.schoolDaysLeft()/180.0), height_n);// color(255,100,0), color(255,255,0));
    fill(255,0,0);   rect( sizeX*0.4 - sizeX/20 ,loading_y + height_n, sizeX/10 * (minute()/60.0), height_n);// color(0,255,0),   color(0,255,100));
    fill(100,552,0); rect( sizeX*0.6 - sizeX/20 ,loading_y + height_n, sizeX/10 * (second()/60.0), height_n);// color(255,0,0),   color(255,100,0));
    fill(0,100,255); rect( sizeX*0.8 - sizeX/20 ,loading_y + height_n, sizeX/10 * (new Date().getMilliseconds()/1000.0), height_n);// color(0,0,255),   color(0,100,255));
    stroke(0);

    
    //Progress bar for school        
    fill(50); noStroke();
    rect( sizeX*0.15 , sizeY*0.4 + sizeX/20 + height_n*4, sizeX*0.7 , height_n+1);
    fill(255,100,0); 
    rect( sizeX*0.15, sizeY*0.4 + sizeX/20 + height_n*4, sizeX*0.7 * time.schoolPercent(), height_n);// color(255,0,0), color(255,255,0));


    //Time till class ends
    fill(255); textSize(sizeX/15);
    text( time.class_time_end_str() , sizeX*0.4, sizeY*0.4 + sizeX/20 + height_n*4 + sizeX/30 );
    
    textSize(sizeX/60); textAlign(LEFT,BOTTOM);
    text( "TIME TILL CLASS ENDS ", sizeX*0.55, sizeY*0.4 + sizeX/20 + height_n*4 + sizeX/40);
    text( "TODAY IS AN " + time.get_day() + " DAY ("  + round(time.schoolPercent()*10000)/100 + "% DONE)"      , sizeX*0.55, sizeY*0.4 + sizeX/20 + height_n*4 + sizeX*1.7/40);
    text( time.get_today()  , sizeX*0.55, sizeY*0.4 + sizeX/20 + height_n*4 + sizeX*2.4/40);
    
    textAlign(CENTER,CENTER);
    text( "REAL TIME: " + time.get_time_str() + " ----- SCH. TIME: " + time.get_fake_time_str()  , sizeX/2, sizeY*0.4 + sizeX/20 + height_n*4 + sizeX*3/40);

    //Background selector button
    image( back_button, sizeX*0.93 - sizeX*0.025, sizeY*0.9 - sizeX*0.025, sizeX*0.05, sizeX*0.05);

    

    /*PAGE2
    Contents:
        Schedule        DONE
        Period order
        Lab time
        Summer days
        
        Options
            Custom sync
            Custom day
            Alert       DONE :)
            Alert timing*/
    
    pushMatrix();
    translate(sizeX, 0);
    
    fill(0,0,0,150);
    rect(0,0,sizeX,sizeY);
    
    //Draw period order
    textSize(sizeX/40);     textAlign(LEFT,TOP); fill(255);
    text("OTHER DATA", textWidth("123"), sizeY *0.2  -sizeX/40);

    text("PERIOD ORDER: " , textWidth("123"), sizeY *0.2);
    text("LAB TIME LEFT: ", textWidth("123"), sizeY *0.2 + sizeX/40);
    text("SUMMER (LFT): " , textWidth("123"), sizeY *0.2 + sizeX/20);
    
    text("SETTINGS", textWidth("123"), sizeY *0.5 - sizeX/20);
    text("DAILY SCHEDULE", sizeX/2  - textWidth("123"), sizeY *0.2 - sizeX/40);
        
    fill(200);
    text(time.period_order(), textWidth("123PERIOD ORDER: 12"), sizeY *0.2);
    text(time.lab_time_end_str(), textWidth("123PERIOD ORDER: 12"), sizeY *0.2 + sizeX/40);
    text(time.summer_left_str() + " DAYS", textWidth("123PERIOD ORDER: 12"), sizeY *0.2 + sizeX/20);
    
    text("Notifications and Reminders", textWidth("123") + sizeX/15, sizeY *0.5 - sizeX/80 - sizeX/320);
    text("Manual time syncing", textWidth("123") + sizeX/15, sizeY *0.5 + sizeX*2.75/50 - sizeX/320);
    text("Custom day selector", textWidth("123") + sizeX/15, sizeY *0.5 + sizeX*4.5/50 - sizeX/320);
    
    fill(100);
    if(notification_class.selected){
        fill(200);
    }  text("Notification delay", textWidth("123") + sizeX/15, sizeY *0.5 + sizeX/50 - sizeX/320 );
    
    notification_class.draw(textWidth("123"), sizeY *0.5 - sizeX/80, sizeX/20, sizeX/40);
    not_delay_button.draw(textWidth("123"), sizeY *0.5 + sizeX/50, sizeX/20, sizeX/40); textSize(sizeX/40);
    custom_sync_button.draw(textWidth("123"), sizeY *0.5 + sizeX*2.75/50, sizeX/20, sizeX/40); textSize(sizeX/40);
    custom_day_button.draw(textWidth("123"), sizeY *0.5 + sizeX*4.5/50, sizeX/20, sizeX/40);
    
    //Draw schedule
    
    stroke(255);
    line( textWidth("123"), sizeY *0.2  + sizeX/320  , sizeX*0.9, sizeY *0.2 + sizeX/320  );
    line( textWidth("123"), sizeY*0.5 - sizeX/40 + sizeX/320, sizeX/2 - sizeX/20, sizeY*0.5 - sizeX/40)  + sizeX/320;
    
    j = 0; textSize(sizeX/40); textAlign(LEFT,TOP);
    fill(220);
    for(ClassTime c:time.get_schedule_list()){
        fill(220);
        if(time.get_fake_time() >= c.start && time.get_fake_time() <= c.end)
            fill(#F44336);
        text( time.meta_format_time(c.start) + " - " + time.meta_format_time(c.end), sizeX/2, sizeY*0.2 + j*sizeX/40 );
        text( floor((c.end-c.start)/60) + " MIN", sizeX/2 + textWidth("00:00 PM - 00:00 PM 12 LENGTH: " ), sizeY*0.2 + j*sizeX/40 );
            
        j++;
    }
    
    j = 0;
    textFont(bold); textSize(sizeX/40); fill(255);
    for(ClassTime c:time.get_schedule_list()){
        fill(255);
        if(time.get_fake_time() >= c.start && time.get_fake_time() <= c.end)
            fill(#F44336);
        text( "T" + (j+1), sizeX/2 - textWidth("123"), sizeY*0.2 + j*sizeX/40 );
        text( "LENGTH: ", sizeX/2 + textWidth("00:00 PM - 00:00 PM 12"), sizeY*0.2 + j*sizeX/40 );
        j++;
    }textFont(font); 
    
    
    //Selectors
    stroke(255);
    custom_day_selector.draw(sizeX/2 - sizeX/8,sizeY/2 - sizeX*4/30, sizeX/4, sizeX/30);
    not_delay_selector.draw(sizeX/2 - sizeX/8,sizeY/2 - sizeX*4/30, sizeX/4, sizeX/30);
    
    popMatrix();
    
    //The first page
    /*Features:
        Daily quote
        (Multilined, up to 2 lines)
    Notifications
        Weather
        Lab reminders
        No school reminders/exception reminders*/
    pushMatrix();
    translate(-sizeX,0);
    
    fill(0,0,0,150); noStroke(); 
    rect(0, sizeX/40, sizeX, sizeX/20);
    
    fill(255); textAlign(LEFT,TOP); textSize(sizeX/60);
    text( "\"" + quote.rand_quote + "\"" , sizeX/40, sizeX/40 + sizeX/320);
    text( "Quote - " + quote.rand_cite, sizeX/2 , sizeX/40 + sizeX/50 + sizeX/320);
        
    //Notifications
    notifications.draw(sizeX*0.03, sizeX/40 + sizeX/20 + sizeX/320,sizeX*0.94,sizeX/20);
    
    popMatrix();
        
    popMatrix();
    
    
    //Updating stuff
    noStroke();
    scroller.draw(sizeX/2, sizeY*0.9, sizeX*0.03, sizeX*0.05, color(255,255,255,100), color(255));
    
    if(abs(scroll - (-scroller.selected*sizeX)) > sizeX*0.01){
        scroll += ((-scroller.selected*sizeX) - scroll)/8;
    }else{
        if(frameRate%30)
            scroll = -scroller.selected*sizeX;
    }
    
    //Display debug information
    if(debug){
        fill(0);textSize(sizeX/40);
        rect(textWidth("12345"), sizeY*0.9, textWidth("FRAMERATE: 10134"), sizeX/40 + sizeX/320);
        fill(255); textAlign(LEFT,TOP);
        text("FRAMERATE: " + round(frameRate), textWidth("12345"), sizeY*0.9);
    }
    
    //Update notifications (Chrome)
    if(notification_class.selected){
        var ndata = time.get_notifications2();
        if(ndata != null){
            if(ndata[0] == "LAB"){
                notifyMe("img/LABICON.jpg",
                ndata[1], ndata[2]);
            }else if(ndata[0] == "CLASS"){
                notifyMe("img/CLASSICON.jpg",
                ndata[1], ndata[2]);
            }
        }
    }
    
    not_delay_button.c = color(#F44336);
    if(!notification_class.selected){
        not_delay_button.c = color(150);
    }
    
    if(back_select.active){
        back_select.draw();
    }

}

void keyPressed(){
    if(key == 100){
        debug = !debug;
    }
}

void mouseClicked(){
    if( back_select_button_temp.isClick(sizeX*0.93- sizeX*0.025, sizeY*0.9 - sizeX*0.025, sizeX*0.05, sizeX*0.05) ){
        back_select.active = true;
    }
    
    scroller.update(sizeX/2, sizeY*0.9, sizeX*0.03, sizeX*0.05);

    notification_class.update(textWidth("123"), sizeY *0.5 - sizeX/80, sizeX/20, sizeX/40);
    
    if(back_select.active){
        if( back_select.update() )
            back_select.active = false;
    }
    
    thing_var = custom_day_selector.update(sizeX/2 - sizeX/8,sizeY/2 - sizeX*4/30, sizeX/4, sizeX/30); //I just gave up naming variables at this point
    if(  thing_var != false ){
        if(thing_var == "ABCD")
            thing_var = "A";
        if(thing_var == "E DAY")    
            thing_var = "E";
        time.master_day = thing_var;
        custom_day_selector.active = !custom_day_selector.active;   
    }

    thing2 = not_delay_selector.update(sizeX/2 - sizeX/8,sizeY/2 - sizeX*4/30, sizeX/4, sizeX/30);
    if( thing2 != false){
        b = int(thing2.split(" ")[0]);
        if( thing2.includes("MIN") )
            b = int(thing2.split(" ")[0]) * 60;
        time.CLASSTIMEMAX = b;
        not_delay_selector.active = false;
    }
    
    not_delay_selector.active = false;
    custom_day_selector.active = false;   
    
    if(not_delay_button.isClick(textWidth("123"), sizeY *0.5 + sizeX/50, sizeX/20, sizeX/40)){
        not_delay_selector.active = !not_delay_selector.active;
    }
    
    if( custom_day_button.isClick(textWidth("123"), sizeY *0.5 + sizeX*4.5/50, sizeX/20, sizeX/40) ){
        custom_day_selector.active = !custom_day_selector.active;   
    }
    
    if( custom_sync_button.isClick(textWidth("123"), sizeY *0.5 - sizeX/80 + sizeX/40*3, sizeX/20, sizeX/40) ){
        var result = prompt("***MANUAL TIME SYNCING***\n Options to sync:\n 1. Give a number in seconds, the higher the number, the slower school time is. Current time shift is "+time.TIMESHIFT+"\n 2. Give a school time real time difference in the format HH:MM:SS&HH:MM:SS. School time goes first, real time second.\n 3. Enter 'DEFAULT' to reset it to default time.", "DEFAULT");
        if(result != null){
            if(result.toUpperCase() == "DEFAULT")  //Is it default?
                time.TIMESHIFT = time.TIMESHIFTDEFAULT;
            else if(!isNaN(result)) //It's a number
                time.TIMESHIFT = int(result);
            else{
                try{
                    String d1 = result.split("&")[1];
                    String d2 = result.split("&")[0];
                    int d01 = int(d1.split(':')[0]) * 3600 + int(d1.split(':')[1]) * 60 + int(d1.split(':')[2]);
                    int d02 = int(d2.split(':')[0]) * 3600 + int(d2.split(':')[1]) * 60 + int(d2.split(':')[2]);
                    if(d01 == null || d02 == null)
                        1/0;
                    time.TIMESHIFT = d01 - d02;
                }catch(e){
                    alert("Invalid input found! Please check your input and try again.")
                }
            }
        }
        
    }

}

//Drawing stuff
void gradient(int x, int y, float w, float h, color c1, color c2 ) {
    noFill();
    for (int i = x; i <= x+w; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
    }
}



class BackSelector{
    boolean active = false;
    int selected = 2;

    BackSelector(){}
    
    void draw(){
        int index = 0;
        fill(0,0,0,200);
        rect(0,0,sizeX,sizeY);
        for(PImage[] i:backgrounds){
            float x = (index%4)*sizeX/4;
            float y = floor((index)/4) * sizeX / 4 * 0.55;
            image(i , x, y, sizeX/4,sizeX/4*0.55);
 
            index++;
        }
 
        float x = (selected%4)*sizeX/4 ;
        float y = floor((selected)/4) * sizeX  / 4 * 0.55;
        fill(0,0,0,0); strokeWeight(5); stroke(255,0,0);
        rect(x,y, sizeX/4,sizeX/4*0.55);
        strokeWeight(1); stroke(0);
    }
    
    void update(){
        float x = floor(mouseX / (sizeX/4 ));
        float y = floor(mouseY / (sizeX/4 * 0.55));
        if (x+y*4 < backgrounds.length){
            selected = x+y*4;
            return true;
        } return false;
    }
}

/*Save data class*/
class Save{
    /*All data here is saved in this class
        Data saved:
            Options:
                notification enabled
                manual time save
            Background*/
    boolean notification;
    int TIMESHIFT;
    int CLASSTIMEMAX;
    int back;
    
    Save(shift){
        if(document.cookie.equals(""))
            document.cookie = "1 "+shift+" 60 2";
        notification = document.cookie.split(" ")[0] == "1" ? true : false;
        TIMESHIFT = int(document.cookie.split(" ")[1]);
        CLASSTIMEMAX = int(document.cookie.split(" ")[2]);
        back = int(document.cookie.split(" ")[3]);
    }
    
    void update( not, shift, c , b) {
        notification = not;
        TIMESHIFT = shift;
        CLASSTIMEMAX = c;
        back = b;
        document.cookie = (not == true ? "1" : "0") + " " + shift + " " + c + " " + b;
    }
}

class Multilist{
    String[] txt;
    color c;
    Button[] buttons = [];
    boolean active = false;
    
    Multilist(String[] t, color c1){
        txt = t; c = c1;
        
        //Button(color c1, String t)
        for(String s:t){
            buttons.push( new Button(c1,s) );
        }
    }
    
    void draw(float x,float y, float w, float h){
        if(active){
            noStroke();
            fill(0);
            rect(x,  y , w*1.02, h*txt.length + 2*txt.length +w*0.02);
            
            fill(30);
            rect(x - w*0.01, y - w*0.01, w*1.02, h*txt.length + 2*txt.length +w*0.02);
            int j = y;
            for(Button b:buttons){
                b.draw(x,j, w, h);
                j+=h+2;
            }
        }
    }
    
    boolean update(x,y,w,h){
        if(active){
            int j = y;
            for(Button b:buttons){
                if(b.isClick(x,j, w, h))
                    return b.txt;
                j+=h+2;
            }
        }return false;
    }
}

/*Fancy button class
You can click it and everything :)*/
class Button{
    color c;
    String txt;
    
    Button(color c1, String t){
        c = c1; txt = t;
    }
    
    void draw(float x,float y,float w,float h){
        fill(c);
        if(isClick(x,y,w,h))
            fill(150);
        rect(x,y,w,h);
        
        fill(255);
        textSize(h*0.7); textAlign(CENTER,CENTER);
        text(txt, x+w/2, y+h/2);
    }
    
    void isClick(float x,float y,float w,float h){
        if(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h){
            return true;
        }return false;
    }
}

/*Fancy checkbox class :D
Not really a checkbox but a slider*/
class CheckBox{
    boolean selected;
    color c;
    float scroll;
    
    CheckBox(boolean s, color c1){
        selected = s; c = c1;
        scroll = selected ? 0.75 : 0.25;
    }
    
    void draw(float x,float y,float w,float h){
        fill(150);
        if(selected)
            fill(c);
        rect(x,y,w,h, h, h, h);
        
        //Draw circle thingy
        fill(255);
        if(selected){
            ellipse(x + w*scroll, y + h/2, h*0.9, h*0.9);
        }else{
            ellipse(x + w*scroll, y + h/2, h*0.9, h*0.9);
        }
        
        //Scroll the neat thingy
        if(selected && abs(scroll - 0.75) > 0.02)
            scroll -= (scroll-0.75)/4;
        else if(!selected && abs(scroll - 0.25) > 0.02)
            scroll -= (scroll-0.25)/4;
    }
    
    void update(float x,float y,float w,float h){
        if(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h){
            selected=!selected;
        }
    }
}


//Notification center
/*Notification
    Color
    Text
Notification center
    Array of notifications*/
class Notification{
    color c;
    String text, title;
    int type; //1 = lab 2 = exception 3 = news 4 = random fact

    Notification(color c1, String t, String title1, int ty){
        c = c1; text = t; type = ty; title = title1;
    }
}

class NotificationCenter{
    var notifications = [];
    NotificationCenter(){}
    
    void draw(float x,float y,float w,float h){
        for(int i=0;i<notifications.length;i++){
            var n = notifications[i];
            fill(n.c); noStroke();
            rect(x, y + h*i + i*sizeX/320, w, h);
            
            fill(255); 
            text(n.title, x+sizeX/10, y+sizeX/320+ h*i + i*sizeX/320);
            fill(200);
            text(n.text, x+sizeX/10, y+sizeX/40+ h*i + i*sizeX/320);
            
            noStroke();
            if(n.type == 1){ //Lab
                fill(#009688);
                rect(x, y+ h*i + i*sizeX/320, sizeX/20,sizeX/20);
                
                stroke(255);
                line(x + sizeX/45, y + sizeX/80+ h*i + i*sizeX/320, x + sizeX/45, y + sizeX/40+ h*i + i*sizeX/320);
                line(x + sizeX/20 - sizeX/45, y + sizeX/80+ h*i + i*sizeX/320, x  + sizeX/20 - sizeX/45, y + sizeX/40+ h*i + i*sizeX/320);
                line(x + sizeX/45, y + sizeX/40+ h*i + i*sizeX/320, x + sizeX/80, y + sizeX/25+ h*i + i*sizeX/320);
                line(x  + sizeX/20 - sizeX/45, y  + sizeX/20 - sizeX/40+ h*i + i*sizeX/320, x  + sizeX/20 - sizeX/80, y  + sizeX/25+ h*i + i*sizeX/320);
                line(x  + sizeX/20 - sizeX/80, y  + sizeX/25+ h*i + i*sizeX/320, x + sizeX/80, y + sizeX/25+ h*i + i*sizeX/320 );
            }else if(n.type == 2){ //Calender
                fill(#66BB6A);
                rect(x, y+ h*i + i*sizeX/320, sizeX/20,sizeX/20);
                
                stroke(255);
                noFill();
                rect(x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320, sizeX/20 - sizeX/50, sizeX/40);
                line( x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.2, x + sizeX/100 + sizeX/20-sizeX/50 , y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.2);
                line( x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.4, x + sizeX/100 + sizeX/20-sizeX/50 , y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.4);
                line( x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.6, x + sizeX/100 + sizeX/20-sizeX/50 , y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.6);
                line( x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.8, x + sizeX/100 + sizeX/20-sizeX/50 , y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40*0.8);
                
                line( x + sizeX/100 + sizeX/40*0.2, y + sizeX/80  + sizeX/40*0.2+ h*i + i*sizeX/320, x + sizeX/100 + sizeX/40*0.2, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40 );
                line( x + sizeX/100 + sizeX/40*0.4, y + sizeX/80  + sizeX/40*0.2+ h*i + i*sizeX/320, x + sizeX/100 + sizeX/40*0.4, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40 );
                line( x + sizeX/100 + sizeX/40*0.6, y + sizeX/80  + sizeX/40*0.2+ h*i + i*sizeX/320, x + sizeX/100 + sizeX/40*0.6, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40 );
                line( x + sizeX/100 + sizeX/40*0.8, y + sizeX/80  + sizeX/40*0.2+ h*i + i*sizeX/320, x + sizeX/100 + sizeX/40*0.8, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40 );
                line( x + sizeX/100 + sizeX/40*1, y + sizeX/80  + sizeX/40*0.2+ h*i + i*sizeX/320, x + sizeX/100 + sizeX/40*1, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/40 );
            }else if(n.type == 3){ //News
                fill(#999999);
                rect(x, y+ h*i + i*sizeX/320, sizeX/20,sizeX/20);
                
                stroke(255);
                noFill();
                rect(x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320, sizeX/20 - sizeX/50, sizeX/40);
                line( x + sizeX/100, y + sizeX/80 + h*i + i*sizeX/320, x+sizeX/80+sizeX/80,  y + sizeX/80 + h*i + i*sizeX/320 + sizeX/80);
                line( x+sizeX/40,  y + sizeX/80 + h*i + i*sizeX/320 + sizeX/80, x + sizeX/60 + sizeX/40, y + sizeX/80 + h*i + i*sizeX/320);
            }else if(n.type == 4){ //Random
                fill(#FFC107);
                rect(x, y+ h*i + i*sizeX/320, sizeX/20,sizeX/20);
                
                fill(255);
                text("i", x+sizeX/100+sizeX/80, y + sizeX/80 + h*i + i*sizeX/320);
                noFill(); stroke(255);
                ellipse(x+sizeX/40, y + sizeX/80 + h*i + i*sizeX/320 + sizeX/80, sizeX/35,sizeX/35);
            }
        }
    }
    
    void add(n){
        notifications.push(n);
    }
    
    void remove(n){
        var index = notifications.indexOf(n);
        if (index > -1) {
            notifications.splice(index, 1);
        }
    }

}
//Page scroll handler class
class PageScroller{
    float n;
    int selected = 0;
    PageScroller(int n1){
        n = n1;
    }
    
    void draw(float x,float y,float r, float d, color c1, color c2){
        fill(0,0,0,130);
        rect( x - d*floor(n/2) - r*1.5, y - r*0.7, d*n + r*1.6, r*1.4);
        
        textAlign(CENTER,CENTER);
        j = 1;
        
        for(float i = x - d*floor(n/2); i <= x+d*floor(n/2); i+=d){
            fill(c1);
            if(selected == j-floor(n/2)-1){
                fill(255,255,255,200);
                r2 = r;
            }else{
                r2 = r*0.9;
            }textSize(r2*0.8);
            ellipse(i,y,r2,r2);
            
            fill(c2);
            text(j, i, y);
            j++;
        }
    }
    
    void update(float x,float y,float r, float d){
        j = -floor(n/2);
        for(float i = x - d*floor(n/2); i <= x+d*floor(n/2); i+=d){
            if( pyth( (mouseX - i), (mouseY - y) ) <= r/2){
                selected = j;
            }  j++;
        }
    }
    
    float pyth(float a,float b){
        return Math.sqrt(a*a+b*b);
    }
}

//Time handler class
/*Functions:
    Get time             DONE
    Get_fake_time        DONE
    Get day              DONE
    Get schedule         DONE
    format_time          DONE
    Get exceptions       DONE
    
    Get time left       DONE
    Time left class     DONE
    Time left lab
    Summer days
    Days school         DONE
    Days left (Including weekened)  DONE    
*/

class Time{
    String URL  = "options.txt";
    var exceptions;
    String master_day = "DEFAULT";
    
    int TIMESHIFT, TIMESHIFTDEFAULT;
    Day school_end;
    Day school_start;
    
    String[] day_weeks = {"SUN","MON","TUE","WED","THUR","FRI","SAT"};
    String[] months = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SPT","OCT","NOV","DEC"};
        
    int last_notification = 0; //Last notification, can't announce 2 notifications too close to each other
    int last_alert = 0;
    int CLASSTIMEMAX = 60; //Seconds before to alert
    
    ClassTime[][] schedules = { //Order: normal, e, half, midterm, parcc, parcc2
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 30480), new ClassTime(30720,33300), new ClassTime(33540,36120), new ClassTime(36360,38940), new ClassTime(38940,42300), new ClassTime(42300,44880), new ClassTime(45120,47700), new ClassTime(47940,50520), new ClassTime(50760,53340) }, 
        {new ClassTime(27900, 29700), new ClassTime(29880,31680), new ClassTime(31860,33660), new ClassTime(33840,35640), new ClassTime(35820,34020+3600), new ClassTime(34200+3600,39600), new ClassTime(39780,41580), new ClassTime(41760,43560) },
        {new ClassTime(28800, 36000), new ClassTime(37800,45000) },
        {new ClassTime(27900,35100), new ClassTime(37800,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) },
        {new ClassTime(27900,35100), new ClassTime(35100,36840), new ClassTime(37020,38760), new ClassTime(38760,42000), new ClassTime(42000,43740), new ClassTime(43920,45660), new ClassTime(45840,47580), new ClassTime(47760,49500), new ClassTime(49680,51420), new ClassTime(51600,53340)  }
    };
    
    Time(){
        exceptions = obtainExceptions();
        TIMESHIFT = 3600*5 + 28*60;
        
        school_start = new Day(9,8,"START");
    }
    
    String[] get_notifications2(){
        //Returns a string to obtain a notification
        //[ type, text ]
        last_notification++;
        String d = get_day();
        
        go = false;
        for(ClassTime c:time.get_schedule_list()){
            if(time.get_fake_time() >= c.start && time.get_fake_time() <= c.end)
                go=true;
        }

         //Check for lab notifications
         if( go && last_notification > 1000){
             if(d == "A" || d == "B" || d == "C" || d == "D"){
                if(time_left_lab() == 120){
                    last_notification = 0;
                    return [ "LAB" , "Lab reminder for anyone who has lab the second half of lunch.", "LAB REMINDER" ];
                }
             }else if(d == "E"){
                 if(get_fake_time() == 11*3600 + 13*60){
                    last_notification = 0;
                    return [ "LAB" , "AP Lab reminder for anyone who has lab the second half of lunch.", "AP LAB REMINDER" ];
                }
             }
             
             if(class_time_end() == CLASSTIMEMAX){
                 last_notification = 0;
                 return ["CLASS", "Class is almost over!", "CLASS REMINDER"];
             }
         }
         return null;
    }
    
    
    String get_today(){
        return day_weeks[new Date().getDay()] + " " + months[month()-1] + " " + day() + " " + year();
    }
    
    int get_time(){
        return hour()*3600 + minute()*60 + second();
    }
    
    int get_fake_time(){
        return get_time() - TIMESHIFT;
    }
    
    String get_time_str(){
        return format_time(get_time());
    }
    
    String get_fake_time_str(){
        return format_time(get_fake_time());
    }
    
    String format_time(sec){
        int h = floor(sec/3600);
        int m = floor((sec - h*3600)/60);
        int s = sec - h*3600 - m*60;
        return add_zero(h) + ":" + add_zero(m) + ":" + add_zero(s);
    }
    
    String add_zero(sec){
        return sec<10 ? "0"+sec : ""+sec;
    }
    
    Array obtainExceptions(){
        String[] data = loadStrings(URL);
        var returned = [];
        
        //Daynames are: A,B,C,D,E,HALF,MIDTERM,PARCC,PARCC2,NOSCHOOL,MODIFIED
        for(String line:data){
            if(!line.startsWith("//") && line != ""){
                if("ABCDEHALFMIDTERMPARCC2NOSCHOOLMODIFIED".contains(line.split(":")[0]) ){
                    int month = int(line.split(":")[1].split("/")[0]);
                    int day   = int(line.split(":")[1].split("/")[1]);
                    returned.push ( new Day(day, month, line.split(":")[0] ) );
                }else if( line.startsWith("TIMESHIFT")){
                    TIMESHIFT = int(line.split(":")[1]);
                    TIMESHIFTDEFAULT = TIMESHIFT;
                }else if( line.startsWith("SCHOOLEND")){
                    int month = int(line.split(":")[1].split("/")[0]);
                    int day   = int(line.split(":")[1].split("/")[1]);
                    school_end = new Day(day, month, "END" );
                }
            }
        }return returned;
    }
    
    String meta_format_time(sec){
        prefix = "AM";
        int h = floor(sec/3600);
        int m = floor((sec - h*3600)/60);
        if(h > 12){
            h -= 12;
            prefix = "PM";
        }
        return add_zero(h) + ":" + add_zero(m) + " " + prefix;
    }
    
    String get_day(){
        if(master_day != "DEFAULT")
            return master_day;
        //0 is sunday, 6  is saturday
        if( new Date().getDay() == 0 || new Date().getDay() == 6){
            return "NOSCHOOL";
        }
        
        //Iterate through exceptions to check day type
        for( Day i:exceptions){
            if(day() == i.day && month() == i.month)
                return i.type;
        }//Return based on day of week
        return ["A","B","C","D","E"][ new Date().getDay() - 1];
    }
    
    String period_order(){
        String d = get_day();
        if(d == "NOSCHOOL")
            return "NO PERIODS";
        else if(d == "MIDTERM")
            return "TEST, TEST";
        else if(d == "MODIFIED")
            return "MODIFIED";
        else if(d == "PARCC" || d=="PARCC2")
            return "UNKNOWN";
        else if(d == "HALF")
            return "1,2,3,4,5,6,7,8";
        else if(d == "A")
            return "1,2,3|6,7,8";
        else if(d == "B")
            return "2,3,4|7,8,5";
        else if(d== "C")
            return "3,4,1|8,5,6";
        else if(d == "D")
            return "4,1,2|5,6,7";
        else if(d == "E")
            return "1,2,3,4|5,6,7,8";
        return "UNKNOWN";
    }
    
    int time_left(){ //Time left till school ends
        //Daynames are: A,B,C,D,E,HALF,MIDTERM,PARCC,PARCC2,NOSCHOOL,MODIFIED
        String d = get_day();
        if("NOSCHOOL" == d)
            return 0;
        else if( d == "HALF")
            return get_fake_time() > format_time(12,6) ? 0 : format_time(12,6) - get_fake_time();
        else if (d == "MODIFIED")
            return get_fake_time() > format_time(14,49) ? 0 : format_time(14,49) - get_fake_time(); //I have no idea :P
        return get_fake_time() > format_time(14,49) ? 0 : format_time(14,49) - get_fake_time();
    }
    
    String time_left_str(){
        return format_time(time_left());
    }
    
    int get_millis(){
        int returned = time_left() > 0 ? 1000 - new Date().getMilliseconds() : 0;
        if(returned < 10)
            return "00"+returned;
        if(returned < 100)
            return "0"+returned;
        return returned;
    }
    
    int format_time(int h,int m){
        return h*3600 + m*60;
    }
    
    float schoolPercent(){
        String d = get_day();
        if( d == "NOSCHOOL"){
            return 1;
        }else if(d == "MIDTERM"){
            returned = (get_fake_time() - format_time(7,45)) / (format_time(10,30) - format_time(7,45));
            if(returned > 1)
                return 1;
            return returned < 0 ? 0 : returned;
        }else if(d == "HALF"){
            returned = (get_fake_time() - format_time(7,45)) / (format_time(12,6) - format_time(7,45));
            if(returned > 1)
                return 1;
            return returned < 0 ? 0 : returned;
        }returned = (get_fake_time() - format_time(7,45)) / (format_time(14,49) - format_time(7,45));
        if(returned > 1)
            return 1;
        return returned < 0 ? 0 : returned;
    }
    
    int schoolDaysLeft(){ //SChool days left, doesn't include breaks and stuff
        if(month() <= school_end.month){
            if(month() < school_end.month || (month() == school_end.month && day() <= school_end.day)){
                int date1 = new Date(month()+"/"+day()+"/"+year());
                int date2 = new Date(school_end.month+"/"+school_end.day+"/"+year());
                return weekdaysBetween(date1,date2);
            }
        }
 
        if(month() == school_end.month && day() > school_end.day){ return 0;}
        if(month() > school_end.month && month() < 9){ return 0;}
        if(month() == 9 && day() < 9){ return 0;}
 
        int date1 = new Date(month()+"/"+day()+"/"+year());
        int date2 = new Date(school_end.month+"/"+school_end.day+"/"+(year()+1));
        returned = weekdaysBetween(date1,date2);
        
        //Subtract out no school days *sigh*
        for(Day i:exceptions){
            if( i.month >= 9){
                j = new Date(i.month+"/"+i.day+"/"+year() );
            }else{
                j = new Date(i.month+"/"+i.day+"/"+ (year()+1) );
            }if( i.type == "NOSCHOOL" && j >= new Date() ){
                returned -= 1;
            }
        }if(returned < 10)
            return "00"+returned;
        if(returned < 100)
            return "0"+returned;
        return returned;
    }
    
    int weekdaysBetween(Date startDate,Date endDate) { //Calculate the number of weekdays between 2 dates
        if (startDate < endDate) {
            Date s = startDate;
            Date e = endDate;
        } else {
            Date s = endDate;
            Date e = startDate;
        }
        int diffDays = Math.floor((e - s) / 86400000);
        int weeksBetween = Math.floor(diffDays / 7);
        if (s.getDay() == e.getDay()) {
            int adjust = 0;
        } else if (s.getDay() == 0 && e.getDay() == 6) {
            int adjust = 5;
        } else if (s.getDay() == 6 && e.getDay() == 0) {
            int adjust = 0;
        } else if (e.getDay() == 6 || e.getDay() == 0) {
            int adjust = 5-s.getDay();
        } else if (s.getDay() == 0 || s.getDay() == 6) {
            int adjust = e.getDay();
        } else if (e.getDay() > s.getDay() ) {
            int adjust = e.getDay()-s.getDay();
        } else {
            int adjust = 5+e.getDay()-s.getDay();
        }
        return (weeksBetween * 5) + adjust;
    }
    
    int class_time_end(){ //Time till class ends
        String d = get_day();
        if(d=="NOSCHOOL" || time_left() == 0)
            return 0;
        //Obtain class schedule for today
        ClassTime[] today = get_schedule_list();
        //Check if current time is between 2 classes
        for(ClassTime c:today){
            if( c.start <= get_fake_time() && get_fake_time() <= c.end )
                return c.end - get_fake_time();
        }//Return smallest time difference to start of a class only if it is 7:30 or after. :)
        int current = 9999999;
        for(ClassTime c:today){
            if( c.start - get_fake_time() < current && c.start - get_fake_time() >= 0 )
                current = c.start - get_fake_time();
        }
        current = current < 999999999 ? current : 0;
        current = get_time() >= convertTime(7,30) ? current : 0;
        return current;
    }
    
    int convertTime(int h,int min){
        return h*3600+min*60;
    }
    
    String class_time_end_str(){
        return format_time(class_time_end());
    }
    
    int time_left_lab(){
        String d = get_day();
        if(d == "A" || d == "B" || d == "C" || d=="D"){
            int returned = 40620-240 - get_fake_time();
             if(get_time() >= 10*3600+47*60)
                return returned > 0 ? returned : 0;
        }return 0;
    }
    
    String lab_time_end_str(){
        return format_time(time_left_lab());
    }
    
    int summer_left(){
        if(month() > school_start.month || (month() == school_start.month && day() >= school_start.day )){
            return 0;
        }if(month() < school_end.month || (month() == school_end.month && day() <= school_end.day )){
            return 0;
        }
        int date1 = new Date(month()+"/"+day()+"/"+year());
        int date2 = new Date(school_start.month+"/"+school_start.day+"/"+year());
        return Math.floor((date2 - date1) / (60*60*24*1000));
    }
    
    String summer_left_str(){
        returned = summer_left();
        if(returned < 10)
            return "00"+returned;
        if(returned < 100)
            return "0"+returned;
        return returned;
    }
    
    ClassTime[] get_schedule_list(){
        String d = get_day();
        ClassTime[] today = schedules[0];
        if(d == "PARCC2")
          return schedules[5];
        if(d == "PARCC") 
          return schedules[4];
        if(d == "MIDTERM") 
          return schedules[3];
        if(d == "HALF") 
          return  schedules[2];
        if(d == "E") 
          return schedules[1];     
        return today;
    }
    
    String[] get_notifications(){
        //Remind about exceptions within 2 days
        var returned = []; //new Notification(color(0,0,0,150),"Reminder there is no school tommorow (9/18)","NO SCHOOL REMINDER",2)
        for(Day d:exceptions){
            if(d.month == month() && d.day - day() <= 2 && d.day - day() > 0){
                String prefix = d.day - day() == 1 ? "tomorrow ("+d.month+"/"+d.day+")" : "("+d.month+"/"+d.day+")";
                var n = undefined;
                if(d.type == "NOSCHOOL"){
                    n = new Notification(color(0,0,0,150),"Reminder there is no school "+prefix,"NO SCHOOL REMINDER",2);
                    returned.push(n);
                }else if(d.type == "MIDTERM"){
                    n = new Notification(color(0,0,0,150),"Reminder there is a midterm test "+prefix,"OBVIOUS MIDTERM REMINDER",2);
                    returned.push(n);
                }else{
                    n = new Notification(color(0,0,0,150),"Reminder there is a " + d.type + " day "+prefix,d.type + " DAY REMINDER",2);
                    returned.push(n);
                }
            }
        }return returned;
    }
}

//Data storage
class Day{
    float day, month;
    String type;
    Day( float d, float m, String t){
        day = d; month = m; type = t;
    }
}

//Datatype: Timerange
//Contains time range
class ClassTime{
    int start,end;
    ClassTime(int s,int e){
        start = s;
        end   = e;
    }
}

//Quotes
class Quote{
    String[][] quotes = { 
        {"Let's All Be Different Same As Me","Shockwave Rider by John Brunner"},
        {"Good old fashioned anti-semitism","[CITATION REDACTED]"},
        {"I drank toasts to the \"confusion of mathematics\" and mourned the destruction of the poetry of the rainbow by M. Newton's prying prism","Hyperion, Dan Simmons"},
        {"As you can see, in my version the man points out to the cat that the house is equipped with deadly neurotoxin dispensers","GLaDOS, unused lines"},
        {"Humans must have some purpose other than a place to store your neurotoxin.","GLaDOS, Portal series"},
        {"Neurotoxin... [cough] [cough] So deadly... [cough] Choking... [laughter] I'm kidding!","GLaDOS, Portal"},
        {"Estas usando este software de traduccion de forma incorrecta. Por favor, consulta el manual","Wheatly, Portal 2"},
        {"Ubersetzungsfehler finden Sie in der Bedienungsanleitung für die Hilfe","Translate this."},
        {"Television has proved that people will look at anything rather than each other.","Ann Landers"},
        {"Asking a working writer what he thinks about critics is like asking a lamppost how it feels about dogs.","Christopher Hampton"},
        {"A ship in port is safe, but that's not what ships are built for.","Grace Murray Hopper"},
        {"Made in processing.js!","You can tell I ran out of quotes"},
        {"Computers don't lie, but liars can compute.","Terry Hayes"},
        {"A C on a lab won't always bring your grade down, it might it bring your grade up from a D","Sarah Daniel"},
        {"Drake wouldn't treat you like this","A meme apparently"},
        {"I am so clever that sometimes I don't understand a single word of what I am saying.","Oscar Wilde"},
        {"He who learns but does not think, is lost! He who dongs dongs, dongs dongs!","Confucius"},
        {"Parting with friends is a sadness. A place is only a place","Dune by Frank Herbert"},
        {"This is a clod! Destroying him will be a service to mankind","Dune by Frank Herbert"},
        {"Lord what fools these mortals be!","Puck, A Midsummer Night's Dream, (3.2.110-115)"},
        {"Violence is sometimes the answer","[Citation redacted]"},
        {"I feel strong enough to punch mister Hendrickson right in the snoot!","Dr. Seuss"},
        {"NOT IDIOT PROOF","DONT COMPLAIN LOL"},
        {"When I graduate I'll just take this down.",":D"},
        {"DONATE DONATE DONATE","DONATE DONATE DONATE"},
        {"There is no such thing as a new idea. It is impossible.","Mark Twain"},
        {"Everyone is racist.","[Citation redacted]"},
        {"sarcasm, it's just another free service I offer.","Not really, I was being sarcastic."},
        {"Rot26 is twice as secure as rot13!","A joke, see http://rot26.org/"},
        {"Don't look directly at the bugs!","Minecraft title splash"},
        {"There are two types of people: those who can extrapolate from incomplete data.","A joke."},
        {"The day before the day after tomorrow is the day after the day before the day after yesterday.","Got bored on IRC chat."},
        {"bababadalgharaghtakamminarronnkonnbronntonnerronntuonnthunntrovarrhounawnskawntoohoohoordenenthurnuk","Just google it."},
        {"I lost the game.","Reference to the Game (Mind Game)"},
        {"Mortals. I envy you. You think you can change things. Stop the universe. Undo what was done long before you came along.","Beautiful Creatures"},
        {"Make it idiot proof and someone will make a better idiot.","Some guy online somewhere"},
        {"He was too busy asking if he could, he didn't stop to ask if he should.","Some guy online somewhere"},
        {"The numbers, Mason! What do they mean?","Jason Hudson, Call of Duty"},
        {"Sometimes a majority simply means that all the fools are on the same side.","Claude C. McDonald"},
        {"If everyone believes it, does that make it true?","Winston, 1984 by George Orwell"},
        {"I can use this to spread propoganda.","You'll probably believe most of these quotes."},
        {"Big brother is watching you.","Government of Oceania, 1984 by George Orwell"},
        {"Now I have become death, the destroyer of worlds.","Bhagavad Gita"},
        {"Reading the source is cheating!","Find the quotes yourself."},
        {"90% bug free! Promise!","We may have a few bugs..."},
        {"How do you play a game against an omniscient opponent?","A logical paradox"},
        {"An interesting game. The only winning move is not to play.","NORAD, WarGames"},
        {"Despite goodwill, human intimacy cannot occur without substantial mutual harm.","A logical paradox"},
        {"Roses are Red Violets are Blue In Soviet Russia Poem writes YOU!!","A Russian reversal joke"},
        {"Perhaps it's impossible to wear an identity without becoming what you pretend to be.","Valentine, Ender's Game by Orson Scott Card"},
        {"Roses are red | Violets are blue | Don't you have anything | Better to do?","A humorous twist on the classic poem."},
        {"I find your lack of faith disturbing.","Lord Vader, Star Wars IV - A New Hope"},
        {"One day, somewhere in the future, my work will be quoted!","Minecraft splash title."},
        {"War is Peace | Freedom is Slavery | Ignorance is strength","1984 by George Orwell"},
        {"100% accurate (Assuming relative time)","Time is relative, thus this timer is 100% accurate in it's time frame"},
        {"Knowledge is power, and power corrupts. Does knowledge corrupt?","A mathamatical joke on mock logical reasoning."},
        {"Share this with your friends!","Do what the quote says."},
        {"Like us on facebook!","The link should be down below (Sometimes)"},
        {"In Soviet Russia, waldo finds you!","A russian reversal joke"},
        {"Peace cannot be kept by force; it can be achieved by understanding.","Albert Einstein"},
        {"Once we understand our limits, we go beyond them.","Albert Einstein"},
        {"A person is a person, no matter how small.","Dr. Seuss"},
        {"People who think they know everything are a great annoyance to those of us who do.","Isaac Asimov"},
        {"I am not a speed reader. I am a speed understander.","Isaac Asimov"},
        {"It is not only the living that are killed in a war.","Isaac Asimov"},
        {"Success is not final; failure is not fatal; it is the courage to continue that counts.","Winston Churchill"},
        {"You have enemies? Good. That means you've stood up for something, sometime in your life.","Winston Churchill"},
        {"To improve is to change; to be perfect is to change often.","Winston Churchill"},
        {"I am fond of pigs. Dogs look up to us. Cats look down on us. Pigs treat us as equals.","Winston Churchill"},
        {"We shape our buildings; thereafter they shape us.","Winston Churchill"},
        {"Nationalism is power hunger tempered by self-deception.","Notes on Nationalism by George Orwell"},
        {"Who controls the past controls the future. Who controls the present controls the past.","1984 by George Orwell"},
        {"All animals are equal, but some animals are more equal than others.","Animal Farm by George Orwell"},
        {"Men can only be happy when they do not assume that the object of life is happiness.","George Orwell"},
        {"Whoever is winning at the moment will always seem to be invincible.","George Orwell"},
        {"404 Quote not found","A play on the 404 error."},
        {"We build too many walls and not enough bridges.","Issac Newton"},
        {"People won't have time for you if you are always angry or complaining.","Stephen Hawking"},
        {"Intelligence is the ability to adapt to change.","Stephen Hawking"},
        {"When one's expectations are reduced to zero, one really appreciates everything one does have.","Stephen Hawking"},
        {"Work gives you meaning and purpose and life is empty without it.","Stephen Hawking"},
        {"Death is the solution to all problems. No man - no problem.","Joseph Stalin, leader of the USSR"},
        {"The death of one man is a tragedy. The death of millions is a statistic.","Joseph Stalin, leader of the USSR"},
        {"Print is the sharpest and the strongest weapon of our party.","Joseph Stalin, leader of the USSR"},
        {"I trust no one, not even myself.","Joseph Stalin, leader of the USSR"},
        {"1.21 gigawatts?! 1.21 gigawatts?! Great Scott!","Doc Brown, Back to the Future"},
        {"Run: cat /dev/random /dev/tty","Run this command in a linux shell."},
        {"The power to annoy is the power to destroy.","A common adage."},
        {"He alone, who owns the youth, gains the future.","Adolf Hitler, Fuher of Nazi Germany"},
        {"Make the lie big, make it simple, keep saying it, and eventually they will believe it.","Adolf Hitler, Fuher of Nazi Germany"},
        {"The victor will never be asked if he told the truth.","Adolf Hitler, Fuher of Nazi Germany"},
        {"TWO PLUS TWO MAKES FIVE","Most commonly referenced to George Orwell's 1984"},
        {"Even in the valley of the shadow of death, two and two do not make six.","Russian Orthodox Church"},
        {"Stuff your eyes with wonder, he said, live as if you'd drop dead in ten seconds.","Fahrenheit 451 by Ray Bradbury"},
        {"See the world. It's more fantastic than any dream made or paid for in factories.","Fahrenheit 451 by Ray Bradbury"},
        {"If you hide your ignorance, no one will hit you and you'll never learn.","Fahrenheit 451 by Ray Bradbury"},
        {"When they give you lined paper, write the other way.","Fahrenheit 451 by Ray Bradbury"},
        {"The sun burnt every day. It burnt time.","Fahrenheit 451 by Ray Bradbury"},
        {"It's not the time that matters, it's the person.","11th Doctor, Doctor Who"},
        {"In 900 years of time and space, I've never met anyone who wasn't important","12th Doctor, Doctor Who"},
        {"Do what I do. Hold tight and pretend it's a plan!","12th Doctor, Doctor Who"},
        {"Never ignore coincidence. Unless, of course, you're busy. In which case, always ignore coincidence.","12th Doctor, Doctor Who"},
        {"We're all stories, in the end. Just make it a good one, eh?","12th Doctor, Doctor Who"},
        {"Come on, Rory! It isn't rocket science, it's just quantum physics!","12th Doctor, Doctor Who"},
        {"Allons-y!","11th Doctor, Doctor Who"},
        {"When life gives you lemons, you dont make lemonade! You throw the lemons back at life","Cave Johnson, Portal Series"},
        {"We do what we must because we can.","GLaDOS, Portal Series"},
        {"It's kind of hard to ask a dead guy what he did wrong.","Maze Runner by James Dashner"},
        {"You get lazy, you get sad. Start givin' up. Plain and simple.","Maze Runner by James Dashner"},
        {"Quit voting me down before you even think about what I'm saying.","Maze Runner by James Dashner"},
        {"Beyond here be dragons","Old saying"},
        {"If at first you don't succeed, try, try again","Common adage"},
        {"Infinite power just isn't very interesting, no matter what game you're playing.","Notch, Minecraft"},
        {"I'm just used to being on fire","Random person on the internet"},
        {"The end is never the end is never the end is never the end...","Stanley Parable"},
        {"You look quite well for a man that's been 'utterly destroyed","Spock, Star Trek"},
        {"If there's nothing wrong with me... maybe there's something wrong with the universe!","Dr. Crusher, Star Trek the Next Generation"},
    };
 
    Quote(){}
 
    //Could be 2 lines but forgot a () and don't want to rewrite
    String[] q = quotes[new Date().getMilliseconds()%quotes.length];
    String rand_quote = q[0];
    String rand_cite = q[1];
 
 
    void randomQuote(){ //Change the current quote
        q = getRandomQuote();
        rand_quote = q[0];
        rand_cite = q[1];
    }
 
    String[] getRandomQuote(){ //Choose a random quote (getMilliseconds is more 'random' than the random function lol)
        int index = new Date().getMilliseconds()%quotes.length;
        return quotes[index];
    }
}
