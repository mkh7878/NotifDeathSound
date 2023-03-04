// NOTIFICATION OBJECT ------------------------------------------------------------------------------------------------------------


class Notification {
  
  public PImage notification;
  private float xpos;
  private float ypos;
  private float wid;
  private float len;
  private boolean active;
  private SoundFile soundEffect;
  
 
// Constructor ----------------------------------------------------------------------------------- 

  Notification(float xp, float yp, float w, float l, PImage image, SoundFile effect) {         // Takes the same 4 arguments as an image would
    xpos = xp;                                                 // Sets arguments as class parameters
    ypos = yp;
    wid = w;
    len = l;
    notification = image;     // Load image
    soundEffect = effect; //load Sound Effect   
    active = false;                                     // Set active as false
  }

  
  
  
// GETTERS ---------------------------------------------------------------------------------------  
  
  float getXPos() {
    return xpos;
  }
  
  float getYPos() {
    return ypos;
  }
  
  float getWidth() {
    return wid;
  }
  
  float getLength() {
    return len;
  }
  
  boolean getActive() {
    return active;
  }

// DRAW NOTIFICATION FUNCTION ----------------------------------------------------------------------
  void drawNotification() {                           
    image(notification, xpos, ypos, wid, len);    // Draw 'notification' at (xpos, ypos) with dimensions (wid/len)
    active = true;                                    // Set notification's active as true
  }
    
  boolean checkIfClicked() 
  {
    // check mouse is in range of the notification
    return (mouseX >= xpos) && (mouseX <= xpos + wid) && (mouseY >= ypos) && (mouseY <= ypos + len);
  }
  
  void onClick() { 
    active = false;
  }
  
  //play notification sound 
  void playNotification(int firstTime){
    if ((soundEffect.isPlaying() == false) && (firstTime == 1)){
      soundEffect.play();
    }
  }
}



  
