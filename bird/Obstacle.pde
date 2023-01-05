


class Obstacle {

  PVector position;
  float w,h;
  color colorfill;
  
  Obstacle(float x, float y, float w_, float h_) {
    position = new PVector(x,y);
    w = w_;
    h = h_;
    colorfill = 255;
  }

  void display() {
    noStroke();
    fill(colorfill);
    strokeWeight(2);
    ellipseMode(CORNER);
    ellipse(position.x,position.y,w,h);
  }

  boolean contains(PVector spot) {
    if (spot.x > position.x && spot.x < position.x + w && spot.y > position.y && spot.y < position.y + h) {
      return true;
    } else {
      return false;
    }
  }
  
  void setColorFill( color fill_ ) {
    colorfill = fill_;
  }

}
