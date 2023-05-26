// This code utilizes the OpenAI ChatGPT model for assistance with natural language processing.
// Visit https://openai.com to learn more about ChatGPT.
// Concept and Co-Authored by mohamedsuhail.1990@gmail.com

float circleRadius = 5;    // Circle radius
float padding = 20;        // Padding at the bottom of the screen
float jumpVelocity;        // Random jump velocity
float maxHeight;           // Maximum height for the jump
float gravity = 0.2;       // Gravity value
float velocity = 0;        // Velocity for the fall

// Pause icon variables
float pauseIconSize = 30;
float pauseIconMargin = 10;

// Stop icon variables
float stopIconSize = 30;
float stopIconMargin = 10;

ArrayList<Particle> particles;    // Array list to store particles
boolean isPaused = false;         // Flag to track pause state
boolean showStopIcon = false;     // Flag to track if the stop icon should be displayed

void setup() {
  fullScreen();
  jumpVelocity = random(-25, -15);             // Random jump velocity with a higher range
  
  particles = new ArrayList<Particle>();
  
  // Create particles to fill the width of the screen
  for (int i = 0; i < width / (circleRadius * 2); i++) {
    Particle particle = new Particle(i * (circleRadius * 2), height - circleRadius - padding);
    particles.add(particle);
  }
}

void draw() {
  background(0);    // Set black background
  
  // Update and display all particles
  for (Particle particle : particles) {
    if (!isPaused) {
      particle.update();
    }
    particle.display();
  }
  
   // Display pause icon if paused
  if (isPaused) {
    drawPauseIcon();
  }
  
   // Display stop icon if requested
  if (showStopIcon) {
    drawStopIcon();
  }
}

void keyPressed() {
  // Check if the "S" key is pressed
  if (key == 's' || key == 'S') {
    showStopIcon = !showStopIcon;
    // Toggle the canJump flag for all particles
    for (Particle particle : particles) {
      particle.canJump = !particle.canJump;
    }
  }
  
  // Check if the "P" key is pressed
  if (key == 'p' || key == 'P') {
    isPaused = !isPaused;    // Toggle the pause state
  }
}

void drawStopIcon() {
  // Calculate the coordinates for drawing the stop icon
  float iconX = width - stopIconSize - stopIconMargin;
  float iconY = stopIconMargin;
  
  // Set the color and stroke properties for the stop icon
  fill(255);
  stroke(255);
  strokeWeight(2);
  
  // Draw the stop icon
  rect(iconX, iconY, stopIconSize, stopIconSize);
}

void drawPauseIcon() {
  // Calculate the coordinates for drawing the pause icon
  float iconX = width - pauseIconSize - pauseIconMargin;
  float iconY = pauseIconMargin;
  
  // Set the color and stroke properties for the pause icon
  fill(255);
  stroke(255);
  strokeWeight(2);
  
  // Draw the pause icon
  rect(iconX, iconY, pauseIconSize / 3, pauseIconSize);
  rect(iconX + (pauseIconSize * 2) / 3, iconY, pauseIconSize / 3, pauseIconSize);
}

class Particle {
  float x;            // X-coordinate of the particle
  float y;            // Current y-coordinate of the particle
  float initialY;     // Initial y-coordinate for the particle
  float jumpVelocity; // Random jump velocity for the particle
  float maxHeight;    // Maximum height for the jump
  float velocity;     // Velocity for the fall
  boolean canJump;    // Flag to determine if the particle can jump
  String number;      // Random number displayed by the particle
  
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    this.initialY = y;
    this.jumpVelocity = random(-25, -15);
    this.maxHeight = height * 0.1;
    this.velocity = 0;
    this.canJump = true;
    this.number = String.valueOf(floor(random(9)));
  }
  
  void update() {
    // Check if the particle can jump
    if (canJump) {
      // Check if the particle is at the ground level
      if (y >= height - circleRadius - padding) {
        // Assign a new random jump velocity
        jumpVelocity = random(-18, -10);
      }
      
      // Apply jump velocity
      y += jumpVelocity;
      
      // Check if the particle has reached the maximum height
      if (y <= maxHeight) {
        // Start reducing the jump velocity gradually
        jumpVelocity = 0;
        velocity = 0;
      }
    }
    
    // Apply gravity
    velocity += gravity;
    y += velocity;
    
    // Check if the particle has reached the ground
    if (y >= height - circleRadius - padding) {
      // Reset to initial position and velocity
      y = height - circleRadius - padding;
      velocity = 0;
    }
  }
  
  void display() {
    // Calculate the color and opacity based on the particle's height
    float colorProgress = map(y, maxHeight, height - circleRadius - padding, 0, 1);
    color particleColor = lerpColor(color(255, 0, 0), color(0, 255, 0), colorProgress);
    
    textSize(18);
    textAlign(CENTER, CENTER);
    fill(particleColor);
    text(number, x, y);
  }
  
  
}
