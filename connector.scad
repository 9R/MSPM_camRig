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
    translate ([0,1,cWidth]) {
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

module connector3x (cHeight,cWidth,gap) {
    module outerShape () {
      //roundedEnd
      translate ([0,0,cWidth/2]) {
        rotate ([-90,0,0]) {
          cylinder (d=cWidth, h=cHeight) ;
        }
      }
      //connection
      cube ([cWidth+2,cHeight,cWidth]) ;
      //connection round
      translate ([cWidth+2,cHeight/2,0]){
        cylinder (d=cHeight,h=cWidth);
      }

    }
    module connectorGaps () {
      //connectorSlits
      for ( i = [0:2+gap:5] ) {
        translate ([-cWidth/2,2+i,-1]){
          cube ([cWidth+1,gap,cWidth+2]);
        }
      }

    }
    module screwHoles () {
      //screwhole
      translate ([0,-1,cWidth/2]) {
        rotate ([-90,0,0]){
          M3hole (cHeight+2);
        }
      }
    }
  
  translate ([0,-cWidth/2-.2,-cWidth/2+cHeight]) {
    difference () {
      union () {
        outerShape ();
      }

      union () {
        connectorGaps();
        screwHoles() ;
      }
    }
  }
}

color ("lime",0.5) {
  connector2x (11,10,2.5);
}

color ("orange",0.5) {
  connector3x (11,10,2.5);
}
