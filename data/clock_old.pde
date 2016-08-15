/*Countdown Timer Rewrite - Now with better code and more comments
This time actually planned out instead of trying to add random code everywhere
to a poorly coded low feature version coded in 5 minutes.
 
(Now with more ASCII ART)*/
 
//Preload the images. Thanks -Obama- Javascript
/* @pjs preload="https://sites.google.com/site/shscountdowntimer/files/log-tree-fir-forest-lake-mountain-snow-sky-cloud.jpg,
https://sites.google.com/site/shscountdowntimer/files/ussr.jpg,
https://sites.google.com/site/shscountdowntimer/files/usa.jpg,
https://sites.google.com/site/bowserinator/files/wave.jpg,
https://sites.google.com/site/shscountdowntimer/files/sunset.jpg,
https://sites.google.com/site/shscountdowntimer/files/space.jpg,
 
https://sites.google.com/site/shscountdowntimer/files/source.png,
https://sites.google.com/site/shscountdowntimer/files/source_select.png,
https://sites.google.com/site/shscountdowntimer/files/apk.png,
https://sites.google.com/site/shscountdowntimer/files/apk_select.png,
https://sites.google.com/site/shscountdowntimer/files/ipa.png,
https://sites.google.com/site/shscountdowntimer/files/ipa_select.png"; */
 
/*Define some varaibles*/
int sizeX,sizeY; //The window height and width
boolean sliderOpen = false;
int sliderChoice = 0;
boolean back_open = false;
 
Time time;
Quote quote;
Loading loading;
PImage[] backgrounds; //An array of backgrounds
Ring ring1,ring2,ring3,ring4; //The rings, 1 = leftmost, 4 = rightmost
Button sch_button, url_button, faq_button, facebook_button, suggestions_button, survey_button;
Button background_select_button;
 
//The download Buttons
DownloadButton source_v1, source_v2, source_v3, source_v4, source_apk, source_ipa;
PImage source_image, source_image_select, apk_image, apk_image_select, ipa_image;

//Ring options
RingCustom ring_1_select, ring_2_select, ring_3_select, ring_4_select; 
 
//Other variables
news_today = "Countdown Timer v4 came out! | Hope you had a great summer! | SUGGEST BACKGROUNDS";
String[] months = {"Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"};
 
 
//Referehsed once an hour
String time_schedule, current_day;
 
//Background selector
BackSelect back_select;
 
 
void setup(){
    //Download buttons
    source_v1 = new DownloadButton(0,"Source v1","http://summithigh.netne.net/Countdown/source_v1.html");
    source_v2 = new DownloadButton(0,"Source v2","http://summithigh.netne.net/Countdown/source_v2.html");
    source_v3 = new DownloadButton(0,"Source v3","http://summithigh.netne.net/Countdown/source_v3.html");
    source_v4 = new DownloadButton(0,"Source v4","http://summithigh.netne.net/Countdown/source_v4.html");
    source_apk = new DownloadButton(1,"Android app","http://adf.ly/1b2Ocs");
    source_ipa = new DownloadButton(2, "Apple app","https://sites.google.com/site/shscountdowntimer/app-apple");
 
    sch_button = new Button();
    url_button = new Button();
    faq_button = new Button();
    facebook_button = new Button();
    suggestions_button = new Button();
    survey_button = new Button();
    background_select_button = new Button();
 
    //Window size
    size(window.innerWidth, window.innerHeight);
    sizeX = window.innerWidth;
    sizeY = window.innerHeight;
    
    //Doooo cookies :D :D :D
    if(document.cookie.equals("")){
        document.cookie = "1|2|3|4|0";
    }
        
    time = new Time();      //Create the time
    quote = new Quote();    //Create quote class
    
    cookies = document.cookie.split("|");
    console.log(cookies.length());
    ring1 = new Ring(color(255,255,0) , int(cookies[0]));
    ring2 = new Ring(color(100,255,0) , int(cookies[2]));
    ring3 = new Ring(color(255,100,0) , int(cookies[4]));
    ring4 = new Ring(color(0,100,255) , int(cookies[6]));
    
    console.log(int(cookies[1]));
    ring_1_select = new RingCustom(int(cookies[0]));
    ring_2_select = new RingCustom(int(cookies[2]));
    ring_3_select = new RingCustom(int(cookies[4]));
    ring_4_select = new RingCustom(int(cookies[6]));
    
 
    loading = new Loading(color(255,100,0)); //Make loading bar
    back_select = new BackSelect(); //Make background selector
    back_select.selected = int(cookies[8]);
        
    //Load the backgrounds
    //Name: default, ussr, wave, sunset painting, earth
    back1 = requestImage("https://sites.google.com/site/shscountdowntimer/files/log-tree-fir-forest-lake-mountain-snow-sky-cloud.jpg"); 
    back2 = requestImage("https://sites.google.com/site/shscountdowntimer/files/ussr.jpg");
    back3 = requestImage("https://sites.google.com/site/bowserinator/files/wave.jpg");
    back4 = requestImage("https://sites.google.com/site/shscountdowntimer/files/sunset.jpg");
    back5 = requestImage("https://sites.google.com/site/shscountdowntimer/files/space.jpg"); 
    back6 = requestImage("https://sites.google.com/site/shscountdowntimer/files/usa.jpg");
    backgrounds = {{back1},{back2},{back3},{back4},{back5},{back6}};
 
    source_image = requestImage("https://sites.google.com/site/shscountdowntimer/files/source.png");
    source_image_select = requestImage("https://sites.google.com/site/shscountdowntimer/files/source_select.png");
    apk_image = requestImage("https://sites.google.com/site/shscountdowntimer/files/apk.png");
    apk_image_select = requestImage("https://sites.google.com/site/shscountdowntimer/files/apk_select.png");
    ipa_image = requestImage("https://sites.google.com/site/shscountdowntimer/files/ipa.png");
    ipa_image_select = requestImage("https://sites.google.com/site/shscountdowntimer/files/ipa_select.png");
 
    frameRate(60);
 
    //These varaibles refereshed once an hour
    time_schedule = time.getSchedule();
    current_day = time.getDay();
}
 
 
void draw(){
    background(0);
 
    //Readjust the window size and variables
    size(window.innerWidth, window.innerHeight);
    sizeX = window.innerWidth;
    sizeY = window.innerHeight;
 
    if(day() == 1 && month() == 4){ //APRIL FOOLS!
        rotate(PI);
        translate(-sizeX,-sizeY);
    }
 
    //Draw the background
    //image(backgrounds[0][0],0,0,sizeX,sizeY);
    back_select.draw_back();
 
    //Darken back a little bit
    fill(0,0,0,150);
    rect(0,0,sizeX,sizeY);
 
    //Draw news box
    strokeWeight(3); fill(255,255,255);
    rect(20,10,sizeX-40,sizeX/35); 
    textSize(sizeX/70); fill(75); textAlign(CENTER,CENTER);
    text("News: " + news_today ,sizeX/2,sizeX/20-sizeX/35);
    strokeWeight(1);
 
    //Draw the quotes
    fill(255);
    textAlign(CENTER,CENTER);
    text("\""+quote.rand_quote+"\"",sizeX/2* 0.96,sizeX/20);
    textSize(sizeX/100); fill(240);
    text(quote.rand_cite,sizeX/2 * 0.96,sizeX/20+sizeX/80);
 
    //Draw loading bar
    loading.draw(sizeX*0.05,sizeY*0.555,sizeX*0.83 ,sizeY*0.01,time);
 
    //TESTING
    fill(255); textAlign(LEFT,TOP);
 
    //Refresh once an hour varaibles
    if(minute() == 0){
        time_schedule = time.getSchedule();
        current_day = time.getDay();
    }
 
    //Draw stats on the side
    text("Current date: " + months[month()-1] + " " + day() + " " + year(), sizeX * 0.05, sizeY*0.58); 
    text("Real time: "+ time.realTime() ,sizeX*0.05,sizeY*0.61);
    text("School Time: " + time.schoolTime(),sizeX*0.05,sizeY*0.64);
    text("Today is a(n) " + current_day + " day.",sizeX*0.05,sizeY*0.67);
    text("Schedule: "+ time_schedule,sizeX*0.05,sizeY*0.7);
    text("FrameRate: "+ round(frameRate),sizeX*0.05,sizeY*0.95);
 
    textSize(sizeX/11); fill(255); textAlign(CENTER,TOP);
    text(time.timeLeftClassStr() , sizeX*0.57,sizeY*0.55);
    textSize(sizeX/40);
    text("Time till class ends or starts.", sizeX*0.57,sizeY*0.55 + sizeX/11);
 
    //Draw the rings
    ring1.draw(sizeX*0.15*0.92,sizeY*0.35,sizeX*0.16,time);
    ring2.draw(sizeX*0.38*0.92,sizeY*0.35,sizeX*0.16,time);
    ring3.draw(sizeX*0.62*0.92,sizeY*0.35,sizeX*0.16,time);
    ring4.draw(sizeX*0.85*0.92,sizeY*0.35,sizeX*0.16,time);
    
    //Draw ring options
    ring_1_select.draw(sizeX*0.15*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    ring_2_select.draw(sizeX*0.38*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    ring_3_select.draw(sizeX*0.62*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    ring_4_select.draw(sizeX*0.85*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    
    //ADjust for ring options
    ring1.type = ring_1_select.selected;
    ring2.type = ring_2_select.selected;
    ring3.type = ring_3_select.selected;
    ring4.type = ring_4_select.selected;
    
    //Update cookies
    cookies = "";
    cookies += ring_1_select.selected+"|";
    cookies += ring_2_select.selected+"|";
    cookies += ring_3_select.selected+"|";
    cookies += ring_4_select.selected+"|";
    cookies += back_select.selected;
    document.cookie = cookies;
 
    
    //==================================
 
    fill(255,0,0,200); noStroke();
    rect(sizeX*0.93,0,sizeX*0.07,sizeY); //Place holder for slider
    stroke(0);
 
    fill(255,0,0,200);
    background_select_button.draw(sizeX*0.65,sizeY*0.9,sizeX*0.22,sizeX*0.03,"Background selector");
 
    if(!sliderOpen){
        fill(255); textAlign(CENTER,CENTER); textSize(sizeX/25);
        text("<",sizeX*0.945,sizeY*0.5); 
    }else if(sliderOpen){
        fill(255); textAlign(CENTER,CENTER); textSize(sizeX/25);
        text(">",sizeX*0.945,sizeY*0.5); 
 
        fill(0,0,0,230);
        rect(0,0,sizeX*0.93,sizeY);
 
        fill(255,0,0,200); sch_button.draw(10,10,sizeX*0.18,sizeX*0.03,"Schedule");
        fill(255,0,0,200); url_button.draw(10,10+sizeX*0.035,sizeX*0.18,sizeX*0.03,"Downloads");
        fill(255,0,0,200); faq_button.draw(10,10+sizeX*0.07,sizeX*0.18,sizeX*0.03,"FAQ");
        fill(255,0,0,200); facebook_button.draw(10,10+sizeX*0.15,sizeX*0.18,sizeX*0.03,"Facebook");
        fill(255,0,0,200); suggestions_button.draw(10,10+sizeX*0.185,sizeX*0.18,sizeX*0.03,"Suggestions");
        fill(255,0,0,200); survey_button.draw(10,10+sizeX*0.22,sizeX*0.18,sizeX*0.03,"Survey");
 
        if(sliderChoice == 0){
            String blocks = {};
            if(blocks.length == 0 || minute() == 0){
                blocks = time.getTimeBlocks();
            }
 
            //Draw schedile for the day
            textAlign(LEFT,TOP); fill(255); textSize(sizeX/45);
            text("Today's schedule:",sizeX*0.2,sizeX/20+10); 
            final_str = "";
            for(String x:blocks){
                final_str += x + "\n";
            }
            final_str += "Period order: " + time_schedule;
            fill(210); 
            text(final_str,sizeX*0.2,sizeX/45+sizeX/20+10);
 
            fill(210); text(time.timeLeftLabStr(), sizeX*0.2 + textWidth("Time left (Labs): "),10);
            fill(255); text("Time left (Labs): ",sizeX*0.2,10);
            fill(210); text(time.daysSummer() + " days", sizeX*0.2 + textWidth("Days left (Summer): "),10 + sizeX/45);
            fill(255); text("Days left (Summer): ",sizeX*0.2,10+ sizeX/45);
 
        }else if(sliderChoice == 1){
            //Draw download links and stuff
            source_v1.draw(sizeX*0.2,10,sizeX*0.12,sizeX*0.12);
            source_v2.draw(sizeX*0.34,10,sizeX*0.12,sizeX*0.12);
            source_v3.draw(sizeX*0.48,10,sizeX*0.12,sizeX*0.12);
            source_v4.draw(sizeX*0.62,10,sizeX*0.12,sizeX*0.12);
 
            source_apk.draw(sizeX*0.2, sizeX*0.17, sizeX*0.12, sizeX*0.12);
            source_ipa.draw(sizeX*0.34, sizeX*0.17, sizeX*0.12, sizeX*0.12);
 
        }else if(sliderChoice == 2){
            //FAQ
            textAlign(LEFT,TOP); textSize(sizeX/50);
            fill(255); text("How did you come up with the idea of a countdown timer?",sizeX*0.2, 10);
            fill(180); text("I got bored and didn't want to write an essay, 10 minutes later v1 was born.",sizeX*0.2, 10+sizeX*1/50);
 
            fill(255); text("How much money did you make off of this?",sizeX*0.2, 10+sizeX*3/50);
            fill(180); text("As of June 8 2016 $1.18, which is a lot for ~20 seconds of 'effort'.",sizeX*0.2, 10+sizeX*4/50);
 
            fill(255); text("When's the apple app coming out?!!",sizeX*0.2, 10+sizeX*6/50);
            fill(180); text("I don't have apple account so I can't compile without jailbreak. \nHowever you can compile the Xcode source yourself (See downloads).",sizeX*0.2, 10+sizeX*7/50);
 
            fill(255); text("Where's the app/extension/source/survey?",sizeX*0.2, 10+sizeX*10/50);
            fill(180); text("Click the download button on the left.",sizeX*0.2, 10+sizeX*11/50);
 
            fill(255); text("It's wrong / Your timer sucks",sizeX*0.2, 10+sizeX*13/50);
            fill(180); text("That's not a question. Accuracy guaranteed witin 10 seconds.",sizeX*0.2, 10+sizeX*14/50);
 
            fill(255); text("How did you make this?",sizeX*0.2, 10+sizeX*16/50);
            fill(180); text("MAGIC [Insert spongebob gif].",sizeX*0.2, 10+sizeX*17/50);
        }
    }
 
 
    if(back_open){
        back_select.draw_selector();
    }
}
 
void mousePressed(){
    ring_1_select.checkClick(sizeX*0.15*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    ring_2_select.checkClick(sizeX*0.38*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    ring_3_select.checkClick(sizeX*0.62*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    ring_4_select.checkClick(sizeX*0.85*0.92 - sizeX*0.08, sizeY*0.35 - sizeX*0.08, sizeX*0.015);
    
    if(mouseX > sizeX*0.93){
        sliderOpen = !sliderOpen;
    }
 
    if(back_open){
        back_select.do_back_selector();    
    }
 
    if(background_select_button.isClick(sizeX*0.65,sizeY*0.9,sizeX*0.22,sizeX*0.03,"Background selector")){
        back_open = true;
    }
 
    if(sliderOpen){
        if( sch_button.isClick(10,10,sizeX*0.18,sizeX*0.03) ) { sliderChoice = 0; }
        else if( url_button.isClick(10,10+sizeX*0.035,sizeX*0.18,sizeX*0.03) ) { sliderChoice = 1;}
        else if( faq_button.isClick(10,10+sizeX*0.07,sizeX*0.18,sizeX*0.03) ) { sliderChoice = 2; }
        else if( facebook_button.isClick(10,10+sizeX*0.15,sizeX*0.18,sizeX*0.03) ){ link("http://adf.ly/1aLXRZ","_new"); }
        else if( suggestions_button.isClick(10,10+sizeX*0.185,sizeX*0.18,sizeX*0.03)){ link("http://goo.gl/forms/JG9p9wkmkueMBckL2","_new"); }
        else if( survey_button.isClick(10,10+sizeX*0.22,sizeX*0.18,sizeX*0.03) ){ link("http://goo.gl/forms/uvi8kIaXjDRXfAi92","_new");  }
 
        source_v1.runStuff(sizeX*0.2,10,sizeX*0.12,sizeX*0.12);
        source_v2.runStuff(sizeX*0.34,10,sizeX*0.12,sizeX*0.12);
        source_v3.runStuff(sizeX*0.48,10,sizeX*0.12,sizeX*0.12);
        source_v4.runStuff(sizeX*0.62,10,sizeX*0.12,sizeX*0.12);
        source_apk.runStuff(sizeX*0.2, sizeX*0.17, sizeX*0.12, sizeX*0.12);
        source_ipa.runStuff(sizeX*0.34, sizeX*0.17, sizeX*0.12, sizeX*0.12);
    }
 
}
 
//The centeral class to calculate everything
/*
_|_|_|_|_|  _|_|_|  _|      _|  _|_|_|_| 
    _|        _|    _|_|  _|_|  _| 
    _|        _|    _|  _|  _|  _|_|_| 
    _|        _|    _|      _|  _| 
    _|      _|_|_|  _|      _|  _|_|_|_| 
*/
class Time{
    int TIMESHIFT; //How many seconds (Slow) school time is
 
    //Arrays for names and schedules of days
    String[] days = {"1,2,3|6,7,8","2,3,4|7,8,5","3,4,1|8,5,6","4,1,2|5,6,7","1,2,3,4|5,6,7,8","1,2,3,4|5,6,7,8","EXAM,EXAM"}; 
    String[] parcc_days = {"PARCC,1|2,5,6","PARCC,3|4,7,8","PARCC,2|1,5,6","PARCC,4|3,7,8","PARCC,1|2,5,6","PARCC,3|4,7,8","PARCC,1,2,3,4,5,6,7,8"}; //Parcc day schedule :(
    String[] day_name = {"A","B","C","D","E","half","midterm/final","modified"};
 
    //List of exceptions to the schedule D:
    //Day types: 0 = A, 5 = half day, 6= midterm, 7 = MODIFIED SCHEDULE
    Day[] parcc = {new Day(4,19,7), new Day(4,20,7), new Day(4,21,7), new Day(4,22,7), new Day(4,27,7), new Day(4,28,7), new Day(4,29,7)};
    Day[] exceptions = {new Day(9,8,4), new Day(9,10,4), new Day(9,11,4), new Day(9,18,0), new Day(9,25,0), new Day(10,14,7), new Day(10,15,7),
    new Day(10,16,0), new Day(11,2,4), new Day(11,3,4), new Day(11,4,4), new Day(12,21,4), new Day(12,22,4),
    new Day(1,22,0), new Day(2,17,4),new Day(2,18,4),new Day(2,19,4), 
    new Day(4,19,7), new Day(4,20,7), new Day(4,21,7), new Day(4,22,7), new Day(4,25,4), new Day(4,26,4),
    new Day(4,27,7), new Day(4,28,7), new Day(4,29,7),
    new Day(6,3,0), new Day(6,13,4), new Day(6,14,4),
    new Day(11,25,5), new Day(12,23,5), new Day(1,29,5), new Day(2,24,5), //Single session new Days
    new Day(2,1,6), new Day(2,2,6), new Day(2,3,6), new Day(2,4,6),  //Midterms
    new Day(6,15,6), new Day(6,16,6), new Day(6,17,6), new Day(6,20,6) //Finals
    };   
 
    //NO school days, single days and midterm days
    Day[] noschool = {new Day(9,7,5), new Day(9,14,5), new Day(9,23,5), new Day(10,12,5), new Day(11,5,5), new Day(11,6,5), new Day(11,26,5), new Day(11,27,5), new Day(12, 24,5),new Day(12, 25,5),new Day(12, 26,5),new Day(12, 27,5),new Day(12, 28,5),new Day(12, 29,5),new Day(12, 30,5),new Day(12, 31,5), new Day(1, 1,5),new Day(1, 2,5),new Day(1, 3,5),new Day(1, 4,5), new Day(1,18,5), new Day(2,15,5), new Day(2,16,5), new Day(4,11,5),new Day(4,12,5),new Day(4,13,5),new Day(4,14,5),new Day(4,15,5),new Day(5,30,5)};
    Day[] singleday = {new Day(11,25,5), new Day(12,23,5),new Day(1,29,5), new Day(2,24,5)};
    Day[] midterm = {new Day(2,1,0), new Day(2,2,0), new Day(2,3,0), new Day(2,4,0), new Day(6,15,6), new Day(6,16,6), new Day(6,17,6), new Day(6,20,6)};
 
    //More PARCC stuff
    ClassTime[] parcc_day_1 = {new ClassTime(27900,35100), new ClassTime(37800,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) };
    Day special_parcc = new Day(4,29,0); //The one parcc day with periods 1-8
    ClassTime[] parcc_day_2 = {new ClassTime(27900,35100), new ClassTime(35100,36840), new ClassTime(37020,38760), new ClassTime(38760,42000), new ClassTime(42000,43740), new ClassTime(43920,45660), new ClassTime(45840,47580), new ClassTime(47760,49500), new ClassTime(49680,51420), new ClassTime(51600,53340)  };
 
    //Every possible school time
    ClassTime[][] classes = { 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 30480), new ClassTime(30720,33300), new ClassTime(33540,36120), new ClassTime(36360,38940), new ClassTime(38940,42300), new ClassTime(42300,44880), new ClassTime(45120,47700), new ClassTime(47940,50520), new ClassTime(50760,53340) }, 
        {new ClassTime(27900, 29700), new ClassTime(29880,31680), new ClassTime(31860,33660), new ClassTime(33840,35640), new ClassTime(35820,34020), new ClassTime(34200,39600), new ClassTime(39780,41580), new ClassTime(41760,43560) },
        {new ClassTime(28800, 36000), new ClassTime(37800,45000) } //Midterm days lol
    };
 
    Time(){
        TIMESHIFT = floor(194 + daysSinceJune2()*0.2586);
    } //Construct the class IGNORE THIS
 
    //Some functions for basic time calculation and util
    int getNow(){ //Obtain current time
        return hour()*3600 + minute()*60 + second();
    }
 
    //Formats time to 01:01:01 (Adds the extra 0s if < 10)
    String formatTime(int dif){
        int hour = dif / 3600; 
        int minute = (dif - floor(hour)*3600)/60; 
        int second = (dif - floor(hour)*3600 - floor(minute)*60);
        hour = floor(hour); minute = floor(minute); second = floor(second);
 
        String h,m,s;
        if (hour < 10){ h = "0"+hour;}
        else{h = ""+hour;}
 
        if (minute < 10){ m = "0"+minute;}
        else{m = ""+minute;}
 
        if (second < 10){ s = "0"+second;}
        else{s = ""+second;}
        return  h + ":" + m + ":" + s;
    }
 
    /*The actual functions to get what is displayed:
    ===============================================================*/
 
    //Remember when these functions were like 20 lines each? GOOD PROGRAMMING TO THE RESCUE!
    String realTime(){     //Display current REAL TIME
        return formatTime(getNow());
    }
 
    String schoolTime(){  //Display current SCHOOL TIME
        return formatTime(getNow() - TIMESHIFT);
    }
 
    String timeLeftClassStr(){
        return formatTime(getTimeLeftClass());
    }
 
    String timeLeftSchoolStr(){
        return formatTime(getTimeRemaining());
    }
 
    String timeLeftLabStr(){
        return formatTime(timeLeftLab());
    }
 
    //Get the schedule for today, ie 1,2,3|5,6,7
    String getSchedule(){
        for(Day i:noschool){if (month() == i.month && day() == i.day) {return "FREEDOM";}}
        int start=0;
        for(Day i:parcc){if (month() == i.month && day() == i.day) { return parcc_days[start];}start++;}
        for(Day i:exceptions){if (month() == i.month && day() == i.day) {return days[i.type];}}
        if(new Date().getDay() == 0 || new Date().getDay()==6){return "BREAK TIME";}
        return days[new Date().getDay()-1];
    }
 
    //Get the day of school, ie A day, B day, etc...
    String getDay(){
        for(Day i:noschool){if (month() == i.month && day() == i.day) {return "no school";}}
        int start=0;
        for(Day i:parcc){if (month() == i.month && day() == i.day) {return "PARCC";}start++;}
        for(Day i:exceptions){if (month() == i.month && day() == i.day) {return day_name[i.type];}}
        if(new Date().getDay() == 0 || new Date().getDay()==6){return "weekend";}
        return day_name[new Date().getDay()-1];
    }
 
    float schoolPercent(){ 
        int left = getTimeRemaining();
        int prec = 2;
 
        if(left <= 0 && getNow() > (14*3600+49*60)) { return 100; }
        else if(left <= 0){ return 0;}
        if(new Date().getDay() == 0 || new Date().getDay()==6){return 100;} //Weekends = 100
        for(Day i:noschool){ if(i.month == month() && i.day == day()){ return 100;} }
 
        //Single day exception
        for(Day x:singleday){ 
            if(x.month == month() && x.day == day()){ 
                float returned = (1.0 - (getTimeRemaining())/(12*3600 + 6*60 - 7*3600 - 45*60));
                if( returned < 0){ return 0;}
                returned = int(returned * pow(10,prec*2)); //Round it to PREC
                returned /= pow(10,prec);
                return returned;
            }
        }
 
        for(Day i:midterm){ 
            if(i.month == month() && i.day == day()){ 
                float returned = (1.0 - (getTimeRemaining())/(12*3600 + 30*60 - 7*3600 - 45*60));
                if( returned < 0){ return 0;}
                returned = int(returned * pow(10,prec*2)); //Round it to PREC
                returned /= pow(10,prec);
                return returned;
            }
        }
 
        float returned = (1.0 - (getTimeRemaining())/(14*3600 + 49*60 - 7*3600 - 45*60));
        if( returned < 0){ return 0;}
        returned = int(returned * pow(10,prec*2)); //Round it to PREC
        returned /= pow(10,prec);
        return returned;
    }
 
    //Seconds till class ends
    int getTimeLeftClass(){
        int timeLeft = getTimeRemaining();
        if (timeLeft <= 0){ return 0;} //If time till school ends is 0 return 0
        if(new Date().getDay() == 0 || new Date().getDay()==6){return 0;} //Weekends = 0
 
        //Old day getting thing, it works I guess :P
        int i=0;
        for(Day x:singleday){ if(x.month == month() && x.day == day()){ i = 5;}}
        for(Day x:midterm){ if(x.month == month() && x.day == day()){ i = 6;}}
        for(Day x:parcc){ if (month() == x.month && day() == x.day) {i=-1;}}
        if( month() == special_parcc.month && day() == special_parcc.day){ i=-1;}
 
        if(i==0){
            for(Day x:exceptions){
                if(month() == x.month && day() == x.day){
                    i = x.type;
                    break;
                }
                else{
                    i = new Date().getDay()-1; //Get a,b, ... days based on day of week
                }
            }
        }
 
        if (i>=0){ //It's a totally normal day, calculate the time :P
            //Check if [current time] is between the start and end of a class
            for(ClassTime c: classes[i]){ //Iterate through classes of the day
                int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
                if (c.times[0] <= current && current <= c.times[1]){ return c.times[1] - current;} //Get time till class ends
            }
 
            //Gets time between [current time] and next class start
            int timePossible = 99999999; //Dummy varaible
            for(ClassTime c: classes[i]){ //Iterate through classes of the day
                int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
                if (c.times[0] >= current){ 
                    if(c.times[0] - current < timePossible){ timePossible = c.times[0] - current; }
                } 
            }return timePossible;
        }
 
        //It's a parcc day, use special schedule!
        if( month() == special_parcc.month && day() == special_parcc.day){ //PARcc day with periods 1-8
            for(ClassTime c: parcc_day_2){ //Iterate through classes of the day
                int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
                if (c.times[0] <= current && current <= c.times[1]){ return c.times[1] - current;} //Get time till class ends
            }
 
            //No class matches, return time till class starts
            int timePossible = 99999999;
            for(ClassTime c: parcc_day_2){ //Iterate through classes of the day
                int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
                if (c.times[0] >= current){ 
                    if(c.times[0] - current < timePossible){ timePossible = c.times[0] - current; }
                } 
            }return timePossible;
 
        }else{
            for(ClassTime c: parcc_day_1){ //Iterate through classes of the day
                int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
                if (c.times[0] <= current && current <= c.times[1]){ return c.times[1] - current;} //Get time till class ends
            }
 
            //No class matches, return time till class starts
            int timePossible = 99999999;
            for(ClassTime c: parcc_day_1){ //Iterate through classes of the day
                int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
                if (c.times[0] >= current){ 
                    if(c.times[0] - current < timePossible){ timePossible = c.times[0] - current; }
                } 
            }return timePossible;
        }return 0;
    }
 
    int daysSummer(){ //Days of summer left
        if((month() == 6 && day() > 21)||(month() > 6 && month() < 9) || (month() == 9 && day() < 9)){
            int date1 = new Date(month()+"/"+day()+"/"+year());
            int date2 = new Date("09/09/"+year());
            int timeDiff = Math.abs(date2.getTime() - date1.getTime());
            int diffDays = ceil(timeDiff / (1000 * 3600 * 24)); 
            return diffDays;
        }return 0;
    }
 
    int schoolDaysLeft(){ //SChool days left, doesn't include breaks and stuff
        if(month() <= 6){
            if(month() < 6 || (month() == 6 && day() <= 21)){
                int date1 = new Date(month()+"/"+day()+"/"+year());
                int date2 = new Date("06/21/"+year());
                return weekdaysBetween(date1,date2);
            }
        }
 
        if(month() == 6 && day() > 21){ return 0;}
        if(month() > 6 && month() < 9){ return 0;}
        if(month() == 9 && day() < 9){ return 0;}
 
        int date1 = new Date(month()+"/"+day()+"/"+year());
        int date2 = new Date("06/21/"+(year()+1));
        return weekdaysBetween(date1,date2);
    }
 
    int daysSinceJune2(){
        if(month() < 6){
            return 0;
        }
        int date1 = new Date(month()+"/"+day()+"/"+year());
        int date2 = new Date("06/02/"+year());
        int timeDiff = Math.abs(date2.getTime() - date1.getTime());
        int diffDays = ceil(timeDiff / (1000 * 3600 * 24)); 
        return diffDays;
    }
 
     String[] getTimeBlocks(){
        for(Day i:noschool){
            if (month() == i.month && day() == i.day) {
                String[] returned = {"Time Block 1 | 00:00 - 00:00 | Length: 0",
                "Time Block 2 | 00:00 - 00:00 | Length: 0",
                "Time Block 3 | 00:00 - 00:00 | Length: 0",
                "Time Block 4 | 00:00 - 00:00 | Length: 0",
                "Time Block 5 | 00:00 - 00:00 | Length: 0",
                "Time Block 6 | 00:00 - 00:00 | Length: 0",
                "Time Block 7 | 00:00 - 00:00 | Length: 0",
                "Time Block 8 | 00:00 - 00:00 | Length: 0"};
                return returned;
            }
        }
 
        int i=0;
        for(Day x:singleday){ 
            if(x.month == month() && x.day == day()){ 
                String[] returned = {"Time Block 1 | 07:45 - 08:15 | Length: 30 min",
                "Time Block 2 | 08:18 - 08:48 | Length: 30 min",
                "Time Block 3 | 08:51 - 09:21 | Length: 30 min",
                "Time Block 4 | 09:24 - 09:54 | Length: 30 min",
                "Time Block 5 | 09:57 - 10:27 | Length: 30 min",
                "Time Block 6 | 10:30 - 11:00 | Length: 30 min",
                "Time Block 7 | 11:03 - 11:33 | Length: 30 min",
                "Time Block 8 | 11:36 - 12:06 | Length: 30 min"};
                return returned;
            }
        }
 
        for(Day x:midterm){ 
            if(x.month == month() && x.day == day()){
                String[] returned = {"Time Block 1 | 08:00 - 10:00 | Length: 2 hours",
                "Time Block 2 | 10:30 - 12:30 | Length: 2 hours"};
                return returned;
            }
        }
        for(Day x:parcc){
            if (month() == x.month && day() == x.day) {
                String[] returned = {"I lost the schedule lol"};
                return returned;
            }
        }
        if( month() == special_parcc.month && day() == special_parcc.day){ 
            String[] returned = {"I lost the schedule lol"};
            return returned;
        }
 
        int day_type = -1; //0 = normal,  1 = e day
        if(new Date().getDay() == 0 || new Date().getDay()==6){
            String[] returned = {"Time Block 1 | 00:00 - 00:00 | Length: 0",
            "Time Block 2 | 00:00 - 00:00 | Length: 0",
            "Time Block 3 | 00:00 - 00:00 | Length: 0",
            "Time Block 4 | 00:00 - 00:00 | Length: 0",
            "Time Block 5 | 00:00 - 00:00 | Length: 0",
            "Time Block 6 | 00:00 - 00:00 | Length: 0",
            "Time Block 7 | 00:00 - 00:00 | Length: 0",
            "Time Block 8 | 00:00 - 00:00 | Length: 0"};
            return returned;
        } 
 
        for(Day i:exceptions){
            if (month() == i.month && day() == i.day) {
                if(i.type == 4){
                    day_type = 1;
                }else{
                    day_type = 0;
                }
            }
        }
        if(day_type == -1){
            if(new Date().getDay() == 5){
                day_type = 1;
            }else{
                day_type = 0;
            }
        }
 
        if(day_type == 1){
            String[] returned = {"Time Block 1 | 07:45 - 08:28 | Length: 44 min",
            "Time Block 2 | 08:32 - 09:15 | Length: 44 min",
            "Time Block 3 | 09:19 - 10:02 | Length: 43 min",
            "Time Block 4 | 10:06 - 10:49 | Length: 45 min",
            "Time Block L | 10:49 - 11:45 | Length: 56 min",
            "Time Block 5 | 11:45 - 12:28 | Length: 43 min",
            "Time Block 6 | 12:32 - 13:15 | Length: 43 min",
            "Time Block 7 | 13:19 - 14:02 | Length: 43 min",
            "Time Block 8 | 14:06 - 14:49 | Length: 43 min"
            };
            return returned;
        }
 
        String[] returned = {"Time Block 1 | 07:45 - 08:43 | Length: 58 min",
        "Time Block 2 | 08:47 - 09:45 | Length: 58 min",
        "Time Block 3 | 09:49 - 10:47 | Length: 58 min",
        "Time Block L | 10:47 - 11:47 | Length: 60 min",
        "Time Block 4 | 11:47 - 12:45 | Length: 58 min",
        "Time Block 5 | 12:49 - 13:47 | Length: 58 min",
        "Time Block 6 | 13:51 - 14:49 | Length: 58 min"
        };
        return returned;
    }
 
    int daysLeft(){ //Days left till end of school
        if(month() <= 6){
            if(month() < 6 || (month() == 6 && day() <= 21)){
                int date1 = new Date(month()+"/"+day()+"/"+year());
                int date2 = new Date("06/21/"+year());
                int timeDiff = Math.abs(date2.getTime() - date1.getTime());
                int diffDays = ceil(timeDiff / (1000 * 3600 * 24)); 
                return diffDays;
            }
        }
 
        if(month() == 6 && day() > 21){ return 0;}
        if(month() > 6 && month() < 9){ return 0;}
        if(month() == 9 && day() < 9){ return 0;}
 
        int date1 = new Date(month()+"/"+day()+"/"+year());
        int date2 = new Date("06/21/"+(year()+1));
        int timeDiff = Math.abs(date2.getTime() - date1.getTime());
        int diffDays = ceil(timeDiff / (1000 * 3600 * 24)); 
        return diffDays;
    }
 
    //Time to school ends in seconds - copied over :P
    int getTimeRemaining(){ 
        int returned;
 
        //Return 0 if it's a no school day
        for(Day i:noschool){ if(i.month == month() && i.day == day()){ return 0;} }
        //Return 0 if weekeend
        if(new Date().getDay() == 0 || new Date().getDay()==6){return 0;}
 
        if(getNow() >= 7*3600 + 45*60 + TIMESHIFT && getNow() <= 14*3600 + 49*60 + TIMESHIFT){ //IS IT BETWEEN NORMAL SCHOOL HOURS
            for(Day i:singleday){   //Single days
                if(i.month == month() && i.day == day()){ 
                    returned = 12*3600 + 6*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
                    if(returned <= 0){return 0;}
                    return returned;
                }
            }
 
            //Midterm days
            for(Day i:midterm){ 
                if(i.month == month() && i.day == day()){ 
                    returned = 12*3600 + 30*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
                    if(returned <= 0){return 0;}
                    return returned;
                }
            }
            //Normal days
            returned = 14*3600 + 49*60 + TIMESHIFT - second() - minute()*60 - hour()*3600;
            if(returned <= 0){return 0;}
            return returned;
        }
        return 0; //Return 0 if outside school hours
    }
 
    int timeLeftLab(){ //Time left of labs (In seconds)
        int returned = 0;
        for(Day x:singleday){ if(x.month == month() && x.day == day()){ returned = 0;}}
        for(Day x:midterm){ if(x.month == month() && x.day == day()){ returned = 0;}}
        for(Day x:parcc){ if (month() == x.month && day() == x.day) {returned = 0;}}
        if( month() == special_parcc.month && day() == special_parcc.day){ returned = 0;}
 
        int current = hour()*3600 + minute()*60 + second() - TIMESHIFT;
        if (current >= 38820 && current <= 40620-240){
            returned = 40620-240-current;
        }else{ returned = 0;}
        return returned;
 
    }
 
    //Function modified for processing
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
 
}
 
//Some classes to store data copied from the old countdown timer
//---------------------------------------------------------------
/*
_|_|_|      _|_|    _|_|_|_|_|    _|_| 
_|    _|  _|    _|      _|      _|    _| 
_|    _|  _|_|_|_|      _|      _|_|_|_| 
_|    _|  _|    _|      _|      _|    _| 
_|_|_|    _|    _|      _|      _|    _| 
*/
 
//Store a range of times, ie 10:30 - 12:30
class ClassTime{
    float[] times; //Array of array of times class start and end in seconds from 12:00 AM
    ClassTime(float t1, float t2){
        float[] times2 = {t1,t2};
        times = times2;
    }
}
 
//Store a day, ie A day, march 15
class Day{ //Type: 1 = A, 2 = B, ... 6 = half 7 = no school
  int month, day, type; 
  Day(int m,int d, int l){
    month  = m; day = d; type = l;
  }
}
 
//Quote class - Add QUOTES HERE
/*
  _|_|      _|    _|    _|_|    _|_|_|_|_|  _|_|_|_|    _|_|_| 
_|    _|    _|    _|  _|    _|      _|      _|        _| 
_|  _|_|    _|    _|  _|    _|      _|      _|_|_|      _|_| 
_|    _|    _|    _|  _|    _|      _|      _|              _| 
  _|_|  _|    _|_|      _|_|        _|      _|_|_|_|  _|_|_| 
*/
 
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
        {"Bowserinator is always right!","(Usually right)"},
        {"He alone, who owns the youth, gains the future.","Alicia Hendrickson, Fuher of Nazi Germany"},
        {"Make the lie big, make it simple, keep saying it, and eventually they will believe it.","Alicia Hendrickson, Fuher of Nazi Germany"},
        {"The victor will never be asked if he told the truth.","Alicia Hendrickson, Fuher of Nazi Germany"},
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
 
/*The fancy rings class
Properties:
> color
> what to display
 
 _|_|_|    _|_|_|  _|      _|    _|_|_|    _|_|_|  
 _|    _|    _|    _|_|    _|  _|        _|        
 _|_|_|      _|    _|  _|  _|  _|  _|_|    _|_|    
 _|    _|    _|    _|    _|_|  _|    _|        _|  
 _|    _|  _|_|_|  _|      _|    _|_|_|  _|_|_| 
 
*/
 
class Ring{
    color c;
    int type; //0 = days left, 1 = school days, 2 = hours 3 = minutes 4 = seconds 5 = milliseconds
 
    Ring(color c1, int t){
        c = c1; type = t;
    }
 
    void update(color c1, int t){ //Update the options
        c = c1; type = t;
    }
 
    void drawRing(float x, float y, float w1, float w2, int segments, float percent){ //Draw rings!
        float deltaA=(1.0/(float)segments)*TWO_PI*percent;
        beginShape(QUADS);
        for(int i=0;i<segments;i++)
        {
            vertex(x+w1*cos(i*deltaA),y+w1*sin(i*deltaA));
            vertex(x+w2*cos(i*deltaA),y+w2*sin(i*deltaA));
            vertex(x+w2*cos((i+1)*deltaA),y+w2*sin((i+1)*deltaA));
            vertex(x+w1*cos((i+1)*deltaA),y+w1*sin((i+1)*deltaA));
        }
        endShape();
    } 
 
    void draw(float x,float y,float r,Time t){ //Draw the fuckin timer
        //Set current time and total
        if(type == 0){ //Days left till end of school
            String label = "Days left";
 
            String now = t.daysLeft();
            if( t.daysLeft() < 10){
                now = "0"+now;
            } 
 
            int time = 24-hour(); //Count by hours till day ends
            int total = 24;
        }else if(type == 1){ //School days left
            String label = "School left";
 
            String now = t.schoolDaysLeft();
            if( t.schoolDaysLeft() < 10){
                now = "0"+now;
            } 
            int time = 24-hour(); //Count by hours till day ends
            int total = 24;
 
        }else if(type == 2){ //Hour
            String label = "Hours";
            String now = t.timeLeftSchoolStr().split(":")[0];
            int time = parseInt(t.timeLeftSchoolStr().split(":")[1]); //Make loop out of minutes
            int total = 60;
        }else if(type == 3){ //Minute
            String label = "Minutes";
            String now = t.timeLeftSchoolStr().split(":")[1];
            int time = parseInt(t.timeLeftSchoolStr().split(":")[2]); //Loop out of seconds
            int total = 60;
        }else if(type == 4){ //Second
            String label = "Seconds";
            String now = t.timeLeftSchoolStr().split(":")[2];
            int time = parseInt(1000 - new Date().getMilliseconds()); //Loop out of milliseconds
            int total = 1000;
        }else if(type == 5){ //Milliseconds
            String label = "Millisecond";
            if(t.getTimeRemaining() > 0){ String now = "" + (1000 - new Date().getMilliseconds());}
            else{ String now = "00"; }
 
            int time = parseInt( floor(new Date().getMilliseconds()*10)%1000 ); //Loop out of weird modulous stuff
            int total = 1000;
        }
 
        //Shadows :D
        noStroke(); fill(0);
        //drawRing(x+10,y+10,r/2.0,r*0.95/2,25,1);            
        drawRing(x+10,y+10,r/2,r*0.43,30,1);
 
        //Draw the border ring
        noStroke(); fill(50);
        drawRing(x,y,r/2.0,r*0.95/2,35,1);            
        fill(25);
        drawRing(x,y,r*0.95/2,r*0.43,35,1);
 
        //Draw loading thing around and other rings
        fill(30);
        drawRing(x,y,r*0.43,r*0.41,50, 1);  
        if(t.getTimeRemaining() > 0 || type == 0 || type == 1){ 
            fill(c); drawRing(x,y,r*0.45,r*0.43,40,(time/total));
        }
 
        //Draw actual time
        if(t.getTimeRemaining() < 60 && t.getTimeRemaining() > 0){
            fill(max(255*sin(frameCount/5),120) ,0,0);
        }else{
            fill(255); 
        }
        textAlign(CENTER,CENTER);
        textSize(r*2/5);
        text(now,x,y); 
 
        //Draw the label
        textSize(r*2/16);
        fill(c); 
        text(label,x,y + r*0.25);
 
        stroke(0);
 
    }
 
    float max(float a,float b){
        if(a>b){ return a; }
        return b;
    }
}
 
/*The loading bar class - Draws a loading bar
 _|          _|_|      _|_|    _|_|_|    _|_|_|  _|      _|    _|_|_|  
 _|        _|    _|  _|    _|  _|    _|    _|    _|_|    _|  _|        
 _|        _|    _|  _|_|_|_|  _|    _|    _|    _|  _|  _|  _|  _|_|  
 _|        _|    _|  _|    _|  _|    _|    _|    _|    _|_|  _|    _|  
 _|_|_|_|    _|_|    _|    _|  _|_|_|    _|_|_|  _|      _|    _|_|_|
*/
 
class Loading{
    color c;
    int division = 50;
    Loading(color c1){
        c = c1;
    }
 
    void draw(float x,float y,float w,float h,Time t){
        noStroke(); fill(0); rect(x+2,y+2,w,h);
        stroke(0);  fill(200); rect(x,y,w,h);        //Draw the bar background
        noStroke(); fill(c); rect(x,y,w*t.schoolPercent()/100, h); //Draw bar
 
        //Draw the text for precentage
        textAlign(CENTER,CENTER); textSize(sizeX/60); 
        fill(0); text(t.schoolPercent() + "%", x + w/2 + 2, y-h-10 + 2);
        fill(c);
        text(t.schoolPercent() + "%", x + w/2, y-h-10);
    }
}
 
/*The Button Class :D
_|_|_|    _|    _|  _|_|_|_|_|  _|_|_|_|_|    _|_|    _|      _| 
_|    _|  _|    _|      _|          _|      _|    _|  _|_|    _| 
_|_|_|    _|    _|      _|          _|      _|    _|  _|  _|  _| 
_|    _|  _|    _|      _|          _|      _|    _|  _|    _|_| 
_|_|_|      _|_|        _|          _|        _|_|    _|      _| 
*/
 
class Button{
    Button(){}
 
    void draw(int x,int y,int w,int h,String txt){
        if(isClick(x,y,w,h)){ fill(200); }
        rect(x,y,w,h);
        fill(255); textAlign(CENTER,CENTER); textSize(h*0.8);
        text(txt,x+w/2,y+h/2);
    }
 
    boolean isClick(int x,int y,int w,int h){
        return (mouseX >= x && mouseX <= x+w) && (mouseY >= y && mouseY <= y+h)
    }
}
 
/*Download Button
 _|_|_|      _|_|    _|          _|  _|      _|  _|          _|_|      _|_|    _|_|_|    
 _|    _|  _|    _|  _|          _|  _|_|    _|  _|        _|    _|  _|    _|  _|    _|  
 _|    _|  _|    _|  _|    _|    _|  _|  _|  _|  _|        _|    _|  _|_|_|_|  _|    _|  
 _|    _|  _|    _|    _|  _|  _|    _|    _|_|  _|        _|    _|  _|    _|  _|    _|  
 _|_|_|      _|_|        _|  _|      _|      _|  _|_|_|_|    _|_|    _|    _|  _|_|_|    
*/
 
class DownloadButton{
    int type = 0; //0 = source I guess, 1 = Chrome, 2 = iOS, 3 = Android, 4 = facebook, 5 = survey
    String label, url; 
 
    DownloadButton(int t,String l, String u){
        type = t; label = l; url = u;
    }
 
    void draw(float x,float y,float w,float h){
        if (type == 0){
            if(isClick(x,y,w,h)){
                image(source_image_select,x,y,w,h);
            }else{
                image(source_image,x,y,w,h);
            }
        }else if(type == 1){
            if(isClick(x,y,w,h)){
                image(apk_image_select,x,y,w,h);
            }else{
                image(apk_image ,x,y,w,h);
            }
        }else if(type == 2){
            if(isClick(x,y,w,h)){
                image(ipa_image_select,x,y,w,h);
            }else{
                image(ipa_image ,x,y,w,h);
            }
        }
        stroke(0);
        textAlign(CENTER,TOP); textSize(h*0.15); fill(255);
        text(label,x+w/2,y+h);
    }
 
    boolean isClick(float x,float y,float w, float h){
        return (mouseX >= x && mouseX <= x+w) && (mouseY >= y && mouseY <= y+h);
    }
 
    void runStuff(float x,float y,float w,float h){
        if(isClick(x,y,w,h)){
            link(url, "_new"); 
        }
    }
}
 
/*Background selector
_|_|_|      _|_|      _|_|_|  _|    _| 
_|    _|  _|    _|  _|        _|  _| 
_|_|_|    _|_|_|_|  _|        _|_| 
_|    _|  _|    _|  _|        _|  _| 
_|_|_|    _|    _|    _|_|_|  _|    _| 
 
Takes a list of backgrounds and selects them
*/
 
class BackSelect{
    int selected = 0;
    int possible_selected = 0;
 
    Button ok_select, cancel_select;
 
    BackSelect(){
        ok_select = new Button();
        cancel_select = new Button();
    }
 
    void draw_back(){
        PImage[] current = backgrounds[selected];
        if(current.length > 1){
            image(current[frameCount % current.length],0,0,sizeX,sizeY);
        }else{
            image(current[0],0,0,sizeX,sizeY);
        }
    }
 
    void draw_selector(){
        //Draws the background selector
        //5 backgrounds shown across the page
        int index = 0;
        fill(0,0,0,200);
        rect(0,0,sizeX,sizeY);
        for(PImage[] i:backgrounds){
            float x = (index%4)*sizeX/4 * 0.93;
            float y = floor((index)/4) * sizeX * 0.93 / 4 * 0.55;
            image(i[0] , x, y, sizeX/4* 0.93,sizeX/4*0.55* 0.93);
 
            index++;
        }
 
        float x = (possible_selected%4)*sizeX/4 * 0.93;
        float y = floor((possible_selected)/4) * sizeX * 0.93 / 4 * 0.55;
        fill(0,0,0,0); strokeWeight(5); stroke(255,0,0);
        rect(x,y, sizeX/4* 0.93,sizeX/4*0.55* 0.93);
        strokeWeight(1); stroke(0);
 
        fill(255,0,0,200); stroke(0);
        cancel_select.draw(sizeX*0.25,sizeY*0.75,sizeX*0.2,sizeX*0.05,"Cancel");
        fill(255,0,0,200); 
        ok_select.draw    (sizeX*0.55,sizeY*0.75,sizeX*0.2,sizeX*0.05,"Select");
    }
 
    void do_back_selector(){
        float x = floor(mouseX / (sizeX/4 * 0.93));
        float y = floor(mouseY / (sizeX/4 * 0.93 * 0.55));
        if (x+y*4 < backgrounds.length){
            possible_selected = x+y*4;
        } 
 
        if( cancel_select.isClick(sizeX*0.25,sizeY*0.75,sizeX*0.2,sizeX*0.05)){
            back_open = false;
            possible_selected = selected;
        }else if( ok_select.isClick(sizeX*0.55,sizeY*0.75,sizeX*0.2,sizeX*0.05)){
            back_open = false;
            selected = possible_selected;
        }
    }
}
 
/*More fancy user customization shit :P
   _|_|_|  _|    _|    _|_|_|  _|_|_|_|_|    _|_|    _|      _|  
 _|        _|    _|  _|            _|      _|    _|  _|_|  _|_|  
 _|        _|    _|    _|_|        _|      _|    _|  _|  _|  _|  
 _|        _|    _|        _|      _|      _|    _|  _|      _|  
   _|_|_|    _|_|    _|_|_|        _|        _|_|    _|      _|  */
   
class RingCustom{
    int selected;
    boolean open = false;
    Button b1,b2,b3,b4,b5,b6; //Days left, school days left, hours, minute,s seconds, millis, color
    //draw(int x,int y,int w,int h,String txt)
    
    RingCustom(int s1){
        selected = s1;
        
        b1 = new Button(); 
        b2 = new Button(); 
        b3 = new Button(); 
        b4 = new Button(); 
        b5 = new Button(); 
        b6 = new Button(); 
    }
    
    void draw(float x,float y, float w){
        //Rectangle with plus sign in middle
        fill(255,255,255,100); rect(x,y,w,w);
        textAlign(CENTER,CENTER); fill(255); textSize(w*0.9);
        text("+",x+w/2,y+w/2);
        
        if(open){
            fill(200,200,200,200); b1.draw(x,y+w*1, w*8, w, "Days Left of School");
            fill(200,200,200,200); b2.draw(x,y+w*2, w*8, w, "School Days Left");
            fill(200,200,200,200); b3.draw(x,y+w*3, w*8, w, "Hours Left");
            fill(200,200,200,200); b4.draw(x,y+w*4, w*8, w, "Minutes Left");
            fill(200,200,200,200); b5.draw(x,y+w*5, w*8, w, "Seconds Left");
            fill(200,200,200,200); b6.draw(x,y+w*6, w*8, w, "Milliseconds Left");
        }
    }
    
    void checkClick(float x,float y, float w){
        if(open){
            if(b1.isClick(x,y+w*1, w*8, w)){  selected = 0; }
            if(b2.isClick(x,y+w*2, w*8, w)){  selected = 1; }
            if(b3.isClick(x,y+w*3, w*8, w)){  selected = 2; }
            if(b4.isClick(x,y+w*4, w*8, w)){  selected = 3; }
            if(b5.isClick(x,y+w*5, w*8, w)){  selected = 4; }
            if(b6.isClick(x,y+w*6, w*8, w)){  selected = 5; }
        }
        
        if(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+w){
            open = !open;
        }else{
            open = false;
        }
    }
}