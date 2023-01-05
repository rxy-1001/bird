

int lifetime;  // How long should each generation live

Population population;  // Population

int lifecycle;          // Timer for cycle of generation
int recordtime;         // Fastest time to target

Obstacle target;        // Target position

//int diam = 24;          // Size of target

ArrayList<Obstacle> obstacles;  //an array list to keep track of all the obstacles!
PVector obstacleNew;  //新的障碍物坐标

void setup() {
  size(600, 1000);
  // The number of cycles we will allow a generation to live
  lifetime = 800;

  // Initialize variables
  lifecycle = 0;
  recordtime = lifetime;
  
  target = new Obstacle(width/2-50, 24, 100, 100);
  target.setColorFill( #fc5185 );

  // Create a population with a mutation rate, and population max
  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);

  // Create the obstacle course  
  obstacles = new ArrayList<Obstacle>();
  obstacleNew = new PVector(0,0,0);
  
}

void draw() {
  background(135,206,250);

  // Draw the start and target positions
  target.display();


  // If the generation hasn't ended yet
  if (lifecycle < lifetime) {
    population.live(obstacles);
    if ((population.targetReached()) && (lifecycle < recordtime)) {
      recordtime = lifecycle;
    }
    lifecycle++;
    // Otherwise a new generation
  } 
  else {
    lifecycle = 0;
    population.fitness();
    population.selection();
    population.reproduction();
  }

  // Draw the obstacles
  for (Obstacle obs : obstacles) {
    obs.display();
  }
  if( obstacleNew.z == 1 ){
        obstacleNew.z = 0;
        obstacles.add(new Obstacle(-20,0,20,height));
        obstacles.add(new Obstacle(width,0,20,height));
        obstacles.add(new Obstacle(0,-20,width,20));
        for(int i=0;i<8;i++){
          obstacles.add(new Obstacle(obstacleNew.x+random(-300,200), obstacleNew.y+i*90,random(100,200),random(30,50)));
        }
  }

  // Display some info
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  text("Cycles left: " + (lifetime-lifecycle), 10, 36);
  text("Record cycles: " + recordtime, 10, 54);
  
  //适应度最高的火箭轨迹
  fill(color(200,50,50));
  noStroke();
  ellipseMode(CENTER);
  for( PVector[] maxTrail : population.getMaxFitnessTrail() ){
    for( PVector one : maxTrail ){
      circle(one.x, one.y, 1);
    }
  }
}

// Move the target if the mouse is pressed
// System will adapt to new target
void mousePressed() {
  if ( mouseButton == LEFT) {
    target.position.x = mouseX-50;
    target.position.y = mouseY-50;
    recordtime = lifetime;
  } else if ( mouseButton == RIGHT ) {
    for(int i=0;i<10;i++){
      obstacleNew.x = random(4*width/5);
      obstacleNew.y = random(0,height/6);
      obstacleNew.z = 1;
    }
  }
}
