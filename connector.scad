$fa=1;
$fs=0.5;

//basic modules
//##############
module  hole (d,h) {
  cylinder (d=d,h=h) ;
}

module M3hole (h) {
  hole (3.6,h);
}



module connector2x (cWidth,cHeight,gap) {
  module outerShape() {
    union () {
      translate ([0,0,cWidth]) {
        rotate ([90,0,0]) {
          cylinder (d=cWidth,h=cHeight) ;
        }
      }
      translate ([-cWidth/2,-cHeight,0]) {
        cube  ([cWidth,cHeight,cWidth]) ;
      }
    }
  }
  module connectorGaps() {
    union () {
      for ( i = [0:2+gap:cHeight] ) {
        translate ([-cWidth/2-1,-2-i-0.01,-0.1]) {
          cube ([cWidth+2,gap,cHeight*2]);
        }
      }
    }
  }
  module boltHole() {
    translate ([0,1,cWidth*1]) {
      rotate ([90,0,0]) {
        M3hole(cHeight+2) ;
      }
    }
  }

  translate ([0,cWidth/2,0]){
  difference () {
    union () {
      outerShape () ;
    }
    union () {
      boltHole();
      connectorGaps() ;
    }
  }
  }
}


color ("lime",0.5) {
connector2x (11,10,2.5);
}

color ("orange",0.5) {
}
