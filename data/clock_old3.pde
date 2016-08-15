//WIP
//Add custom selection for day

Timer hoursEnd, minutesEnd, secondsEnd;
SchoolEnd school;

int sizeX, sizeY;
int state = 0; // 0 = school countdown
int m,h,s,result;
classroom classr;

void setup(){
 // size(window.innerWidth,window.innerHeight);
  size(window.innerWidth, window.innerHeight);
  sizeX = window.innerWidth;
  sizeY = window.innerHeight;
  
  hoursEnd = new Timer(color(100,255,0),60,sizeX*0.18,sizeX*0.15,sizeY*0.5,"Hours");
  minutesEnd = new Timer(color(255,100,0),60,sizeX*0.18,sizeX*0.38,sizeY*0.5,"Minutes"); //color(255,100,0)
  secondsEnd = new Timer(color(0,100,255),1000,sizeX*0.18,sizeX*0.62,sizeY*0.5,"Seconds");
  millisEnd = new Timer(color(255,255,0),100,sizeX*0.18,sizeX*0.85,sizeY*0.5,"Milliseconds");
  school = new SchoolEnd();
  classr = new classroom();
}

void draw(){
  background(30);
  
  
  //Temp for now
  if(state == 0){    //ScHOOL COUNTDOWN DEFAULT
    Date now = new Date();
    textAlign(CENTER,TOP); 
    textSize(sizeX/20); fill(200);
    text("School Countdown Timer",sizeX/2,0);
    textSize(sizeX/50); 
    text("(Times are only accurate within 10 seconds)",sizeX/2,sizeX/20);
    
    pushMatrix(); translate(0,-0.15*sizeY);
    
    textSize(sizeX/50); fill(200);
    text(now,sizeX/2,sizeY*0.77);
    text("Real time: "+realTime() + "  School Time: " + school.schoolTime(),sizeX/2,sizeY*0.79+sizeX/100);
    text("Today is an " + classr.getDay() + " day and the schedule is "+classr.getSchedule(),sizeX/2,sizeY*0.85);
    //text("Today's block schedule is [NOT HERE]",sizeX/2,sizeY*0.94);
    textSize(sizeX/30); fill(255);
    text("Time till class starts/ends: " + classr.timeTillClass(school) ,sizeX/2,sizeY*0.9);
    
    result = school.getTimeRemaining();
    h = floor(result/3600); m = floor((result - h*3600)/60); s = result - m*60 - h*3600;
    hoursEnd.draw(m,h);
    minutesEnd.draw(s,m);
    secondsEnd.draw(now.getMilliseconds(),s);
    if (result > 0){  millisEnd.draw(now.getMilliseconds(),