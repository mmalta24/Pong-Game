import kinect4WinSDK.Kinect;
import kinect4WinSDK.SkeletonData;
PVector pos1, pos2;
PVector rightHandLeft, rightHandRight;
PVector leftHandLeft, leftHandRight;

Kinect kinect;
ArrayList <SkeletonData> bodies;
PImage imgRGB, imgDepth, imgBodies;
int body1, body2;
int numDetectedBodies;

float limiar;

void setupCV()
{
  kinect = new Kinect(this);

  imgRGB = new PImage(320, 240, RGB);
  imgDepth = new PImage(320, 240, RGB); 
  imgBodies = new PImage(320, 240, RGB);

  bodies = new ArrayList<SkeletonData>();

  pos1 = new PVector(); 
  pos2 = new PVector();
  rightHandLeft = new PVector();
  rightHandRight = new PVector();
  leftHandLeft = new PVector();
  leftHandRight = new PVector();
}

void updateCV() {
  imgRGB.copy(kinect.GetImage(), 0, 0, 640, 480, 0, 0, imgRGB.width, imgRGB.height);
  imgDepth.copy(kinect.GetDepth(), 0, 0, 640, 480, 0, 0, imgDepth.width, imgDepth.height);
  imgBodies.copy(kinect.GetMask(), 0, 0, 640, 480, 0, 0, imgBodies.width, imgBodies.height);

  numDetectedBodies = 0;

  for (int i=0; i<bodies.size (); i++) 
  {
    if (bodies.get(i).position.x * width > 5) {
      if (numDetectedBodies == 0) {
        pos1.set(width - bodies.get(i).position.x * width, bodies.get(i).position.y * height);
        body1 = i;
        numDetectedBodies = numDetectedBodies + 1;
      } else      if (numDetectedBodies == 1) {
        pos2.set(width - bodies.get(i).position.x * width, bodies.get(i).position.y * height);
        body2 = i;
        numDetectedBodies = numDetectedBodies + 1;
      }
    }
  }

  if (numDetectedBodies == 2) {

    if (pos1.x < pos2.x) {
      rightHandLeft.set(bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x * width, bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y * height);
      rightHandRight.set(bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x * width, bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y * height);
      leftHandLeft.set(bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].x * width, bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].y * height);
      leftHandRight.set(bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].x * width, bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].y * height);
    } else {
      rightHandLeft.set(bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x * width, bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y * height);
      rightHandRight.set(bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].x * width, bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_RIGHT].y * height);
      leftHandLeft.set(bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].x * width, bodies.get(body2).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].y * height);
      leftHandRight.set(bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].x * width, bodies.get(body1).skeletonPositions[Kinect.NUI_SKELETON_POSITION_HAND_LEFT].y * height);
    }
  }
}

void drawCV()
{
  background(0);
  image(imgRGB, 320, 0);
  image(imgDepth, 320, 240);
  image(imgBodies, 0, 240);

  smooth();



  for (int i=0; i<bodies.size (); i++) 
  {
    drawSkeleton(bodies.get(i));
    drawPosition(bodies.get(i));
  }


  rectMode(CENTER);
  if (numDetectedBodies == 2) {
    fill(255, 0, 0);
    circle(rightHandLeft.x, rightHandLeft.y, 20);
    square(leftHandLeft.x, leftHandLeft.y, 20);

    fill(0, 255, 0);
    circle(rightHandRight.x, rightHandRight.y, 20);
    square(leftHandRight.x, leftHandRight.y, 20);
  }
  rectMode(CORNER);
}

void drawPosition(SkeletonData _s) 
{
  noStroke();
  fill(0, 100, 255);
  String s1 = str(_s.dwTrackingID);
  text(s1, _s.position.x*width/2, _s.position.y*height/2);
}

void drawSkeleton(SkeletonData _s) 
{
  // Body
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HEAD, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_CENTER, 
    Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
    Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_SPINE);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SPINE, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_CENTER, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT);

  // Left Arm
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_LEFT, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_LEFT, 
    Kinect.NUI_SKELETON_POSITION_WRIST_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_WRIST_LEFT, 
    Kinect.NUI_SKELETON_POSITION_HAND_LEFT);

  // Right Arm
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_SHOULDER_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ELBOW_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_WRIST_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_HAND_RIGHT);

  // Left Leg
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_LEFT, 
    Kinect.NUI_SKELETON_POSITION_KNEE_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_KNEE_LEFT, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_LEFT, 
    Kinect.NUI_SKELETON_POSITION_FOOT_LEFT);

  // Right Leg
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_HIP_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_KNEE_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT);
  DrawBone(_s, 
    Kinect.NUI_SKELETON_POSITION_ANKLE_RIGHT, 
    Kinect.NUI_SKELETON_POSITION_FOOT_RIGHT);
}

void DrawBone(SkeletonData _s, int _j1, int _j2) 
{
  noFill();
  stroke(255, 255, 0);
  if (_s.skeletonPositionTrackingState[_j1] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED &&
    _s.skeletonPositionTrackingState[_j2] != Kinect.NUI_SKELETON_POSITION_NOT_TRACKED) {
    line(_s.skeletonPositions[_j1].x*width/2, 
      _s.skeletonPositions[_j1].y*height/2, 
      _s.skeletonPositions[_j2].x*width/2, 
      _s.skeletonPositions[_j2].y*height/2);
  }
}

void appearEvent(SkeletonData _s) 
{
  if (_s.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    bodies.add(_s);
  }
}

void disappearEvent(SkeletonData _s) 
{
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_s.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.remove(i);
      }
    }
  }
}

void moveEvent(SkeletonData _b, SkeletonData _a) 
{
  if (_a.trackingState == Kinect.NUI_SKELETON_NOT_TRACKED) 
  {
    return;
  }
  synchronized(bodies) {
    for (int i=bodies.size ()-1; i>=0; i--) 
    {
      if (_b.dwTrackingID == bodies.get(i).dwTrackingID) 
      {
        bodies.get(i).copy(_a);
        break;
      }
    }
  }
}
