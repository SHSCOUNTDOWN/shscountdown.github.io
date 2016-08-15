/*@pjs font='font.otf';*/
/*The source for the new countdown timer
New style and animations!

TODO: Make exceptions based on the text file!`*/

PFont font;


void setup(){
    size(window.innerWidth, window.innerHeight, P2D);
    font = createFont("font.otf",32);
    textFont(font);
    

}

void draw(){
    size(window.innerWidth, window.innerHeight, P2D);
    background(30);

    //Draw the background
    /*Insert idea here*/
    textAlign(CENTER,CENTER);
    text( "00:00:00" ,width/2,height/2);
    
}

//Draw the background
void draw_3d_cube(float x,float y,float w, float h){
    beginShape();
    vertex(x,y);
    vertex(x + w/2 ,y + h/4);
    vertex(x + w, y);
    vertex(x + w/2, y - h/4);
    endShape();
    
    beginShape();
    vertex(x,y);
    vertex(x + w/2, y + h/4);
    vertex(x + w, y);
    
    vertex(x + w, y+ h/2);
    vertex(x + w/2, y + h/4 + h/2);
    vertex(x, y + h/2);
    endShape();
}


//Time stuff copied over, too lazy to translate the better version to javascript
// class Time{
//     String[] options;
//     boolean sync_success = false;
    
//     int TIMESHIFT;
    
//     //Month/day format
//     String day_school_ends;
//     String day_school_starts = "09/" + (get_labor_day()+1);
//     boolean app_open = false;
    
//     ArrayList<Day> exceptions = new ArrayList<Day>();
//     String day_master = "DEFAULT";
            
//     String[] day_weeks = {"SUN","MON","TUE","WEN","THUR","FRI","SAT"};
//     String[] months = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SPT","OCT","NOV","DEC"};
        
//     ClassTime[][] schedules = { //Order: normal, e, half, midterm, parcc, parcc2
//         {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
//         {new ClassTime(27900, 30480), new ClassTime(30720,33300), new ClassTime(33540,36120), new ClassTime(36360,38940), new ClassTime(38940,42300), new ClassTime(42300,44880), new ClassTime(45120,47700), new ClassTime(47940,50520), new ClassTime(50760,53340) }, 
//         {new ClassTime(27900, 29700), new ClassTime(29880,31680), new ClassTime(31860,33660), new ClassTime(33840,35640), new ClassTime(35820,34020), new ClassTime(34200,39600), new ClassTime(39780,41580), new ClassTime(41760,43560) },
//         {new ClassTime(28800, 36000), new ClassTime(37800,45000) },
//         {new ClassTime(27900,35100), new ClassTime(37800,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) },
//         {new ClassTime(27900,35100), new ClassTime(35100,36840), new ClassTime(37020,38760), new ClassTime(38760,42000), new ClassTime(42000,43740), new ClassTime(43920,45660), new ClassTime(45840,47580), new ClassTime(47760,49500), new ClassTime(49680,51420), new ClassTime(51600,53340)  }
//     };
    
//     Time(){
    
//         //Attempt to load options
//         try{
//             options = loadStrings(DIR+SAVE);
//             assert options[0] != null: options[0]; //Test if it's not null, if it is well lets make up some data.
//         }catch(Exception e){  //Attempt to load options from cache first, otherwise create
//             try{
//                 String[] data = {
//                     "//Time shift, how slow school time is in seconds. Negative means faster", "TIMESHIFT:179", "//Exceptions to school year formatting", "//FORMATTED AS FOLLOWS:", "//[day name]: [month]/[day]", "//Example: PARCC: 5/7", "//Daynames are: A,B,C,D,E,HALF,MIDTERM,PARCC,PARCC2,NOSCHOOL,MODIFIED", "PARCC:4/19", "PARCC:4/20", "PARCC:4/21", "PARCC:4/22", "PARCC:4/27", "PARCC:4/28", "PARCC2:4/29", "E:9/8", "E:9/10", "E:9/11", "A:9/18", "A:9/25", "MODIFIED:10/14", "MODIFIED:10/15", "A:10/16", "E:11/2", "E:11/3", "E:11/4", "E:12/21", "E:12/22", "A:1/22", "E:2/17", "E:2/18", "E:2/19", "A:6/3", "E:6/13", "E:6/14", "HALF:11/25", "HALF:12/23", "HALF:1/29", "HALF:2/24", "MIDTERM:2/1", "MIDTERM:2/2", "MIDTERM:2/3", "MIDTERM:2/4", "MIDTERM:6/15", "MIDTERM:6/16", "MIDTERM:6/17", "MIDTERM:6/20", "NOSCHOOL:9/7", "NOSCHOOL:9/14", "NOSCHOOL:9/23", "NOSCHOOL:10/12", "NOSCHOOL:11/5", "NOSCHOOL:11/6", "NOSCHOOL:11/26", "NOSCHOOL:11/27", "//Christmas break", "NOSCHOOL:12/24", "NOSCHOOL:12/25", "NOSCHOOL:12/26", "NOSCHOOL:12/27", "NOSCHOOL:12/28", "NOSCHOOL:12/29", "NOSCHOOL:12/30", "NOSCHOOL:12/31", "NOSCHOOL:1/1", "NOSCHOOL:1/2", "NOSCHOOL:1/3", "NOSCHOOL:1/4", "NOSCHOOL:1/18", "NOSCHOOL:2/15", "NOSCHOOL:2/16", "//Spring break", "NOSCHOOL:4/11", "NOSCHOOL:4/12", "NOSCHOOL:4/13", "NOSCHOOL:4/14", "NOSCHOOL:4/15", "NOSCHOOL:5/30","SCHOOLEND:6/21","APPOPEN:FALSE"
//                 };
//                 saveStrings( DIR+SAVE, data);
//                 options = data;
                
//                 options = loadStrings(OPTIONS_URL);
//                 assert options[0] != null: options[0]; //Test if it's not null, if it is catch the error and make up data
//                 sync_success = true;
//                 try{
//                     String[] old = loadStrings(DIR+SAVE);
//                     //Don't replace timeshift if old save exists
//                     for(int i=0;i<options.length;i++){
//                         if(options[i].startsWith("TIMESHIFT")){
//                             for(String line:old){
//                                 if(line.startsWith("TIMESHIFT"))
//                                     options[i] = line;  break;
//                             }
//                         }
//                     }
//                     saveStrings( DIR+SAVE, options);
//                 }catch(Exception c){
//                     saveStrings( DIR+SAVE, options);
//                 }
//             }catch(Exception b){ //Well we have no clue where our data is, make up some
//                 String[] data = {
//                     "//Time shift, how slow school time is in seconds. Negative means faster", "TIMESHIFT:179", "//Exceptions to school year formatting", "//FORMATTED AS FOLLOWS:", "//[day name]: [month]/[day]", "//Example: PARCC: 5/7", "//Daynames are: A,B,C,D,E,HALF,MIDTERM,PARCC,PARCC2,NOSCHOOL,MODIFIED", "PARCC:4/19", "PARCC:4/20", "PARCC:4/21", "PARCC:4/22", "PARCC:4/27", "PARCC:4/28", "PARCC2:4/29", "E:9/8", "E:9/10", "E:9/11", "A:9/18", "A:9/25", "MODIFIED:10/14", "MODIFIED:10/15", "A:10/16", "E:11/2", "E:11/3", "E:11/4", "E:12/21", "E:12/22", "A:1/22", "E:2/17", "E:2/18", "E:2/19", "A:6/3", "E:6/13", "E:6/14", "HALF:11/25", "HALF:12/23", "HALF:1/29", "HALF:2/24", "MIDTERM:2/1", "MIDTERM:2/2", "MIDTERM:2/3", "MIDTERM:2/4", "MIDTERM:6/15", "MIDTERM:6/16", "MIDTERM:6/17", "MIDTERM:6/20", "NOSCHOOL:9/7", "NOSCHOOL:9/14", "NOSCHOOL:9/23", "NOSCHOOL:10/12", "NOSCHOOL:11/5", "NOSCHOOL:11/6", "NOSCHOOL:11/26", "NOSCHOOL:11/27", "//Christmas break", "NOSCHOOL:12/24", "NOSCHOOL:12/25", "NOSCHOOL:12/26", "NOSCHOOL:12/27", "NOSCHOOL:12/28", "NOSCHOOL:12/29", "NOSCHOOL:12/30", "NOSCHOOL:12/31", "NOSCHOOL:1/1", "NOSCHOOL:1/2", "NOSCHOOL:1/3", "NOSCHOOL:1/4", "NOSCHOOL:1/18", "NOSCHOOL:2/15", "NOSCHOOL:2/16", "//Spring break", "NOSCHOOL:4/11", "NOSCHOOL:4/12", "NOSCHOOL:4/13", "NOSCHOOL:4/14", "NOSCHOOL:4/15", "NOSCHOOL:5/30","SCHOOLEND:6/21","APPOPEN:FALSE"
//                 };
//                 saveStrings( DIR+SAVE, data);
//                 options = data;
//             }     
//         }
//         assign();
//     }
    
//     void assign(){
//         //Assign variables based on options
//         String[] types = {"A","B","C","D","E","HALF","MIDTERM","PARCC","PARCC2","NOSCHOOL","MODIFIED"};
//         for(String line:options){
//             if(!line.startsWith("//") && !line.startsWith(" ")){ //Ignore comments
//                 //TIMESHIFT
//                 if(line.startsWith("TIMESHIFT")){   
//                     TIMESHIFT = int(line.split(":")[1]);
//                 }
                 
//                 //DAY EXCEPTIONS
//                 else if( stringInList(line.split(":")[0],types) ){
//                     exceptions.add(   new Day( int(line.split(":")[1].split("/")[0]),  //It's a new day everyday :)
//                     int(line.split(":")[1].split("/")[1]), 
//                     line.split(":")[0]) );
//                 }    
                 
//                 else if( line.startsWith("SCHOOLEND") ){
//                       day_school_ends = line.split(":")[1];
//                 }
                 
//                 else if( line.startsWith("APPOPEN") ){
//                       app_open = line.split(":")[1].equals("TRUE") ? true : false;
//                       app_open = !app_open;
//                       //Make it true now
//                       try{
//                             String[] new_opt = loadStrings(DIR+SAVE);
//                             for(int i=0;i<new_opt.length;i++){
//                                 if(new_opt[i].startsWith("APPOPEN")){
//                                     new_opt[i] = "APPOPEN:TRUE";
//                                 }
//                             }
//                             saveStrings(DIR+SAVE,new_opt);
//                       }catch(Exception b){
//                           println("SAVE APP FAILED");
//                       }
//                 }
//             }
//         }
//     }
    
//     boolean sync_data(){ //Syncs options with web
//         try{
//             options = loadStrings(OPTIONS_URL);
//             assert options[0] != null: options[0]; //Test if it's not null, if it is catch the error and load from cache
//             assign();
//             return true;
//         }catch(Exception e){ 
//             return false; //Failed
//         }
//     }
    
//     //TIME BASED FUNCTIONS HERE
//     //----------------------------------------------------
//     String meta_format_time(String t){ //Adds pm and stuff
//         String prefix = int(t.split(":")[0]) > 12 ? " PM" : " AM";
//         if(prefix == " AM"){
//             return t + prefix;
//         }else{
//             int hour = int(t.split(":")[0]) - 12;
//             String h = hour<10 ? "0"+hour:hour+"";
//             return h+":"+t.split(":")[1]+":"+t.split(":")[2] + prefix;
//         }
//     }
    
//     int convertTime(int h,int min){
//         return h*3600+min*60;
//     }
    
//     int get_time(){
//         return hour()*3600+minute()*60+second();
//     }
    
//     String get_time_str(){
//         return meta_format_time(format_time(get_time())); //Because of 0s
//     }
    
    
//     int get_fake_time(){
//         return get_time() - TIMESHIFT;
//     }
    
//     String get_fake_time_str(){
//         return meta_format_time(format_time(get_fake_time()));
//     }
    
//     String get_date_str(){ // day of week, month day year
//         Date now = new Date();
//         Calendar calendar = Calendar.getInstance();
//         calendar.setTime(now);
//         int day = calendar.get(Calendar.DAY_OF_WEEK);

//         return day_weeks[day-1] + " " + months[month()-1] + " " + day() + " " + year();
//     }
    
//     String format_time(int t){
//       //Formats a number like 14125 to a nice format like 07:25
//         int hour = floor(t/3600);
//         t-= hour*3600;
//         int min = floor(t/60);
//         t-= min*60;
//         int sec = t;
        
//         String h = hour<10 ? "0"+hour:hour+"";
//         String m = min<10 ? "0"+min:min+"";
//         String s = sec<10 ? "0"+sec:sec+"";
//         return h+":"+m+":"+s;
//     }
    
//     int days_left(){
//         //day_school_ends, if after day school starts count day until end of year then new year to that day
//         SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
//         if(month() > int(day_school_ends.split("/")[0]) || (month() == int(day_school_ends.split("/")[0]) && day() >= int(day_school_ends.split("/")[1])) ){
//             //Somewhere in september/october/etc..
//             try{
//                 Date now = new Date();
//                 Date end = formatter.parse("31/12/"+year());
//                 Date start = formatter.parse("01/01/"+(year()+1));
//                 Date end2 = formatter.parse( day_school_ends.split("/")[1] + "/" +  day_school_ends.split("/")[0] + "/" + (year()+1) );
                
//                 Calendar c1 = Calendar.getInstance();
//                 Calendar c2 = Calendar.getInstance();
//                 Calendar c3 = Calendar.getInstance();
//                 Calendar c4 = Calendar.getInstance();
//                 c1.setTime(now);   c2.setTime(end);
//                 c3.setTime(start);   c4.setTime(end2);
//                 return daysBetween(c1,c2) + daysBetween(c3,c4);
//             }catch(Exception e){
//                 println(e);
//             }
//         }else{
//           try{
//                 Date now = new Date();
//                 Date end = formatter.parse( day_school_ends.split("/")[1] + "/" +  day_school_ends.split("/")[0] + "/" + (year()+1) );
//                 Calendar c1 = Calendar.getInstance();
//                 Calendar c2 = Calendar.getInstance();
//                 c1.setTime(now); c2.setTime(end);
//                 return daysBetween(c1,c2);
//           }catch(Exception e){
//                 println(e);
//           }
//         }
//         return 1; //wtf???
//     }
    
//     String days_left_str(){
//         long d = days_left();
//         if(d < 10)
//             return "00"+d;
//         else if(d<100)
//             return "0"+d;
//         return d+"";
//     }
    
//     int days_left_summer(){
//         SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
//         int smonth = int(day_school_ends.split("/")[0]);
//         int sday =   int(day_school_ends.split("/")[1]);
//         if(month() > smonth && month() < 9 || ( (month() == smonth && day() >= sday) && (month() == 9 && day() < int(day_school_ends.split("/")[1])) ) ){
//           try{
//                   Date now = new Date();
//                   Date end = formatter.parse( day_school_starts.split("/")[1] + "/" +  day_school_starts.split("/")[0] + "/" + year() );
//                   Calendar c1 = Calendar.getInstance();
//                   Calendar c2 = Calendar.getInstance();
//                   c1.setTime(now); c2.setTime(end);
//                   return daysBetween(c1,c2);
//             }catch(Exception e){
//                   println(e);
//             }
//         }return 0;
//     }
    
//     String days_left_summer_str(){
//         long d = days_left_summer();
//         if(d < 10)
//             return "00"+d;
//         else if(d<100)
//             return "0"+d;
//         return d+"";
//     }
    
//     /*stealz code from stackoverflow cuz laziness*/
//     int daysBetween(final Calendar startDate, final Calendar endDate)
//     {
//         //assert: startDate must be before endDate  
//         int MILLIS_IN_DAY = 1000 * 60 * 60 * 24;  
//         long endInstant = endDate.getTimeInMillis();  
//         int presumedDays = 
//           (int) ((endInstant - startDate.getTimeInMillis()) / MILLIS_IN_DAY); 
//         //SCrew DST and date rounding and stuff
//         /*Calendar cursor = (Calendar) startDate.clone();  
//         cursor.add(Calendar.DAY_OF_YEAR, presumedDays);  
//         long instant = cursor.getTimeInMillis();  
//         if (instant == endInstant)  
//           return presumedDays;
      
//         final int step = instant < endInstant ? 1 : -1;  
//         do {  
//           cursor.add(Calendar.DAY_OF_MONTH, step);  
//           presumedDays += step;  
//         } while (cursor.getTimeInMillis() <= endInstant);  */
//         return presumedDays+1;  
//     }
    
//     int get_labor_day(){
//         //Compute labor day, day before school starts
//         SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
//         int day = 1;
//         while (day <= 31){ //uhh how many days are in september again?
//             Date date;
//             try{ //WHY U MUST HANDLE ERRORS >:( IM LAZY
//                 date = formatter.parse(
//                   (day < 10 ? "0"+day : day+"") + "/" + "09" + "/" + year()
//                 );

//                 Calendar cal = Calendar.getInstance();
//                 cal.setTime(date);
//                 if (cal.get(Calendar.MONTH) == Calendar.SEPTEMBER
//                     && cal.get(Calendar.DAY_OF_WEEK_IN_MONTH) == 1
//                     && cal.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY) {
//                     return day;
//                 }
//                 day ++;
//             }catch(Exception e){
//                 println("Well something got fucked up.");
//             }
//         }return -1;
//     }
    
    
//     String get_day(){
//         //Get the type of day as a string
//         //A,B,C,D,E,HALF,MODIFIED,PARCC,PARCC2,MIDTERM,NOSCHOOL
//         if(day_master!="DEFAULT"){ //Custom set day
//             return day_master;
//         }for(Day i:exceptions){ //illiterate exceptions
//             if(month() == i.month && day() == i.day)
//                 return i.type;
//         }
//         Date now = new Date();
//         Calendar calendar = Calendar.getInstance();
//         calendar.setTime(now);
//         int day = calendar.get(Calendar.DAY_OF_WEEK);
//         String[] ds = {"NOSCHOOL","A","B","C","D","E","NOSCHOOL"};
//         return ds[day-1];
//     }
    
//     String get_day_1(){
//         String d = get_day();
//         //return first character
//         if(d == "MIDTERM"){
//             return "T";
//         } return d.charAt(0)+"";
//     }
    
//     String get_schedule(){
//         String d = get_day();
//         if(d=="NOSCHOOL"){
//             return "No schedule.";
//         }else if(d=="A"){
//             return "1,2,3,Lunch,6,7,8";
//         }else if(d=="B"){
//             return "2,3,4,Lunch,7,8,5";
//         }else if(d=="C"){
//             return "3,4,1,Lunch,8,5,6";
//         }else if(d=="D"){
//             return "4,1,2,Lunch,5,6,7";
//         }else if(d=="E"||d=="HALF"){
//             return "1,2,3,4,Lunch,5,6,7,8";
//         }else if(d=="MIDTERM"){
//             return "Exam,exam";
//         }else if(d=="PARCC"){
//             return "PARCC,3,Lunch,4,7,8";
//         }else if(d=="PARCC2"){
//             return "PARCC,1,2,3,4,5,6,7,8";
//         }else if(d=="MODIFIED"){
//             return "Modified schedule";
//         }return "Something went wrong.";
//     }
    
//     int time_end(){
//         String d = get_day();
//         if(d=="MIDTERM"){
//             return (convertTime(12,30) - get_fake_time()) > 0 ? (convertTime(12,30) - get_fake_time()) : 0;
//         }else if(d=="HALF"){
//             return (convertTime(12,6) - get_fake_time()) > 0 ? (convertTime(12,6) - get_fake_time()) : 0;
//         }else if(d=="NOSCHOOL"){
//             return 0;
//         }else{
//             return (convertTime(14,49) - get_fake_time()) > 0 ? (convertTime(14,49) - get_fake_time()) : 0;
//         }
//     }
    
//     String time_end_str(){
//         return format_time(time_end());
//     }
    
//     ClassTime[] get_schedule_list(){
//         String d = get_day();
//         ClassTime[] today = schedules[0];
//         if(d == "PARCC2")
//           return schedules[5];
//         if(d == "PARCC") 
//           return schedules[4];
//         if(d == "MIDTERM") 
//           return schedules[3];
//         if(d == "HALF") 
//           return  schedules[2];
//         if(d == "E") 
//           return schedules[1];     
//         return today;
//     }
    
//     float get_school_percent(){
//         ClassTime[] t = get_schedule_list();
//         float range = t[t.length - 1].end - t[0].start;
//         float time = get_fake_time() - t[0].start;
//         float returned = time/range;
//         if(returned > 1)
//             return 1;
//         return returned >= 0 ? returned : 0;
//     }
    
//     int class_time_end(){ //Time till class ends
//         String d = get_day();
//         if(d=="NOSCHOOL" || time_end() == 0)
//             return 0;
//         //Obtain class schedule for today
//         ClassTime[] today = get_schedule_list();
//         //Check if current time is between 2 classes
//         for(ClassTime c:today){
//             if( c.start <= get_fake_time() && get_fake_time() <= c.end )
//                 return c.end - get_fake_time();
//         }//Return smallest time difference to start of a class only if it is 7:30 or after. :)
//         int current = 9999999;
//         for(ClassTime c:today){
//             if( c.start - get_fake_time() < current && c.start - get_fake_time() >= 0 )
//                 current = c.start - get_fake_time();
//         }
//         current = current < 999999999 ? current : 0;
//         current = get_time() >= convertTime(7,30) ? current : 0;
//         return current;
//     }
    
//     String class_time_end_str(){
//         return format_time(class_time_end());
//     }
    
//     int lab_time_end(){
//         String d = get_day();
//         if(d == "A"||d=="B"||d=="C"||d=="D"){
//             int returned = 40620-240 - get_fake_time();
//             return returned > 0 ? returned : 0;
//         }return 0;
//     }
    
//     String lab_time_end_str(){
//         return format_time(lab_time_end());
//     }
    
    
// }
