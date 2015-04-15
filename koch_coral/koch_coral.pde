float nFrame = 0;
ArrayList<KochLine> lines;

class KochLine {
  PVector start;
  PVector end;
  
  KochLine(PVector a, PVector b) {
    start = a.get();
    end = b.get();
  }
  
  void display(){
    float r = map(noise(nFrame), 0, 1, 0, 255);
    float g = map(noise(nFrame + 100), 0, 1, 0, 255);
    float b = map(noise(nFrame + 200) , 0, 1, 0, 255);
    float weight = map(noise(nFrame/2), 0, 1, 1, 20);
    stroke(r, g, b);
    strokeWeight(weight);
    strokeJoin(MITER);
    line(start.x, start.y, end.x, end.y);
  }
  
  PVector kochA() {
    return start.get();
  }
  
  PVector kochB() {
    PVector v = PVector.sub(end, start);
    v.div(3);
    v.add(start);
    return v;
  }
  
  PVector kochC() {
    PVector a = start.get();
    PVector v = PVector.sub(end,start);
    
    v.div(3);
    a.add(v);
    v.rotate(-radians(60));
    a.add(v);
    
    return a;
  }
  
  PVector kochD() {
    PVector v = PVector.sub(end, start);
    v.mult(2/3.0);
    v.add(start);
    return v;
  }
  
  PVector kochE() {
    return end.get();
  }
}

void generate() {
  ArrayList next = new ArrayList<KochLine>();
  for (KochLine l : lines) {
    
    PVector a = l.kochA();
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();
    
    next.add(new KochLine(a,b));
    next.add(new KochLine(b,c));
    next.add(new KochLine(c,d));
    next.add(new KochLine(d,e));
  }
  lines = next;
}

void setup() {
    size(600, 300);
    lines = new ArrayList<KochLine>();
    PVector start = new PVector(0, 200);
    PVector end = new PVector(width, 200);
    
    lines.add(new KochLine(start,end));
}

void draw() {
  nFrame += 0.01;
  background(255);
  for (KochLine l: lines){
    l.display();
  }
}

void mouseClicked() {
  background(#FFFFFF);
  generate();
}
