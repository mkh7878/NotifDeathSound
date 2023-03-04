import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import processing.sound.*;

/*
* Prototype of game
*/

int firstTime = 1;

// Variables
color backgroundColor = color(188, 220, 255);        // Background colour

int totalNotifications = 20;
int notificationCounter = 0;

float seconds = 0;
float startingRate = 70;
float minRate = 50.;
float maxRate = 100.;
float rateMultiplier = 5;
float rate;
float timer;
String timerText;
SoundFile startupSound;

NotificationFactory notificationFactory;
ArrayList<Notification> notifications;

//ArrayList<String> notifNames = new ArrayList<String>(
//     Arrays.asList("Adobe", "Antivirus", "Captcha", "Congratulations", "CorruptedDrive", "Downloading", "DriveFull", "EmptyTrash", "ErrorWindow", "Facebook",
//     "HowDoYouWantToOpen", "Instagram", "InternetConnectionLost", "LowBattery", "Messenger", "msnMessenger", "NewsletterSignup", "Outlook", "Seats",
//     "SlackNewMessage", "Steam", "SystemMessage", "TaskFailed", "TextFromAmazon", "TextFromKevin", "TextFromTwinkBurnet", "TextFromUnknown", "Trash", 
//     "Twitter", "UnsecureWebsite", "UpdatePassword", "virus", "VPN", "Webcam"));




void setup() {
  
  SoundFile startupSound = new SoundFile(this, "Windows95Startup.aiff");
  startupSound.play();
  
  size(600, 500);   
  noStroke();

  notifications = new ArrayList<Notification>();
  notificationFactory = new NotificationFactory();
  //new sound file
  SoundFile file = new SoundFile(this, "Trash.aiff");
  PImage image = loadImage("notification.png");     // Load image
  
  // setup notifications
  for(int i=0; i < totalNotifications; i++) {
    Notification newNotification = notificationFactory.createNotification(image, file);
    notifications.add(newNotification);
  }
  
 
  
}


void draw() {
  

  
  // check if game is over
  if(gameOver())
  {
    textSize(20);
    text("Game over!", 200, 200);
    noLoop(); // break out of the draw loop 
  }
  
  
  
  // set up background + existing notifications
  background(backgroundColor);

  displayTimer();

  // draw existing notifications
  for(Notification notification : notifications) 
  {
    if(notification.getActive()) {
      notification.drawNotification();
      notification.playNotification(firstTime);
      firstTime++;
      
    }
  }
  

  
  // draw new ones!
  
  
  // this needs work lol
  seconds = int((millis() * frameRate) / 1000);
  
  int denominator = getNumActive() + 1;
  
  rate = constrain(int((startingRate / denominator) * rateMultiplier), minRate, maxRate);  
  if(seconds % rate == 0) {   
    notifications.get(notificationCounter).drawNotification();
    notificationCounter++;
  }
 
   // reset if counter goes above maximum 
   if(notificationCounter == notifications.size()) {
     notificationCounter = 0; 
   }


}

void mousePressed() {
    
  for(Notification notification : notifications) 
  {
    if(notification.checkIfClicked()) 
    {
      notification.onClick();
    }
  }
}

int getNumActive() 
{
  // there's a better way to do this but I can't think of it atm
  int numActive = 0;
  
  for(Notification notification : notifications) 
  {
    numActive = notification.getActive() ? numActive + 1 : numActive;
  }
  
  return numActive;
}

boolean gameOver() 
{
  return getNumActive() == notifications.size();
}

void displayTimer()
{
  // timer 
  int seconds = (millis() / 1000) % 60;
  int minutes = (millis() / 1000) / 60;
  String secondsFormat = (seconds < 10) ? "0" + seconds : str(seconds);
  timerText = "Timer: " + minutes + ":" + secondsFormat;
  
  textSize(20);
  textAlign(CENTER, BOTTOM);
  text(timerText, width * 0.1, height * 0.05);

} 
