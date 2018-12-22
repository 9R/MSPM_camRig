
$fa=1;
$fs=0.1;

module screwhole() {
  cylinder (r=1.5,h=20);
}

module nuthole() {
  union () {
    cube ([10,2.5,6]);
    translate ([5,9,3]) {
      rotate ([90,0,0]){
        cylinder (r=3.5/2,h=10);
      }
    }
  }

}

module camIC() {
  cylinder (r=23.5/2, h=20);
}
module componentGap () {
  union () {
    cube ([20,21,11]);
    translate ([1,2,-3]) {
      cube ([18,17,11]);
    }
  }
}

module mainCutout () {
  union () {
    camIC();
    translate ([-10,-10.5,-1.5]){
      componentGap();
    }
    translate ([-10,-15,1]){
      cube (20,10,10);
    }
    translate ([0,-8.5,-15]) {
      screwhole ();
      translate ([0,17,0]) {
        screwhole ();
      }
    }
  }
}

// combination
difference () {
  cube ([8,30,13]);
  union ()  {
    translate ([4,13,7]) {
      mainCutout() ;
    }
    translate ([-1,26,6]) {
      nuthole();
    }
  }
}


//test viz
translate ([50,50,0]) {
//  mainCutout();
}

