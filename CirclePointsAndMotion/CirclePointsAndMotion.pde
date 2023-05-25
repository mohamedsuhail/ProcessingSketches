
// This code utilizes the OpenAI ChatGPT model for assistance with natural language processing.
// Visit https://openai.com to learn more about ChatGPT.
// Concept and Co-Authored by mohamedsuhail.1990@gmail.com

import controlP5.*;

ControlP5 cp5;
float[] angles; // Array to store the current angles for each small circle
float[] speeds; // Array to store the rotation speeds for each small circle
int numCircles = 5; // Initial number of small circles
int centerX, centerY; // Center coordinates
int bigRadius = 300; // Radius of the bigger circle
int smallRadius = 3; // Radius of the smaller circles

void setup() {
  fullScreen(); // Create a full-screen window
  cp5 = new ControlP5(this);

  // Create the slider
  cp5.addSlider("numCircles")
    .setPosition(20, height - 50) // Position of the slider
    .setWidth(200) // Width of the slider
    .setRange(1, 100) // Minimum and maximum values of the slider
    .setValue(numCircles) // Initial value of the slider
    .setLabel("Number of Circles") // Label of the slider
    .setColorCaptionLabel(255) // Color of the label text
    .setColorForeground(color(255)) // Color of the slider foreground
    .setColorBackground(color(40)); // Color of the slider background

  initializeArrays();
  frameRate(60); // Set the frame rate to 60fps
}

void draw() {
  background(0); // Set the background color to black
  stroke(255); // Set the outline color to white
  noFill(); // Set the fill color to white

  centerX = width / 2; // Calculate the x-coordinate of the center
  centerY = height / 2; // Calculate the y-coordinate of the center

  // Draw the bigger circle at the center of the screen
  ellipse(centerX, centerY, bigRadius * 2, bigRadius * 2);

  // Calculate the position of each smaller circle on the circumference of the bigger circle
  for (int i = 0; i < numCircles; i++) {
    float angle = angles[i]; // Retrieve the angle for the current small circle
    float x = centerX + cos(angle) * bigRadius; // Calculate the x-coordinate of the smaller circle
    float y = centerY + sin(angle) * bigRadius; // Calculate the y-coordinate of the smaller circle

    // Draw the smaller circle at the calculated position
    ellipse(x, y, smallRadius * 2, smallRadius * 2);

    angles[i] += speeds[i]; // Update the angle with the assigned rotation speed to create the animation effect
  }

  // Connect the smaller circles with white lines
  beginShape(LINES);
  for (int i = 0; i < numCircles; i++) {
    float angle = angles[i]; // Retrieve the angle for the current small circle
    float x = centerX + cos(angle) * bigRadius; // Calculate the x-coordinate of the smaller circle
    float y = centerY + sin(angle) * bigRadius; // Calculate the y-coordinate of the smaller circle

    float nextAngle = angles[(i + 1) % numCircles]; // Retrieve the angle for the next small circle
    float nextX = centerX + cos(nextAngle) * bigRadius; // Calculate the x-coordinate of the next smaller circle
    float nextY = centerY + sin(nextAngle) * bigRadius; // Calculate the y-coordinate of the next smaller circle

    vertex(x, y); // Add the current smaller circle vertex
    vertex(nextX, nextY); // Add the next smaller circle vertex
  }
  endShape();
}

void initializeArrays() {
  angles = new float[numCircles]; // Initialize the angles array with the current number of small circles
  speeds = new float[numCircles]; // Initialize the speeds array with the current number of small circles
  for (int i = 0; i < numCircles; i++) {
    angles[i] = random(TWO_PI); // Assign a random initial angle between 0 and 2*PI to each small circle
    speeds[i] = random(-0.05, 0.05); // Assign a random rotation speed to each small circle
  }
}

void numCircles(float value) {
  numCircles = round(value); // Update the number of circles based on the slider value
  initializeArrays(); // Reinitialize the arrays with the new number of circles
}
