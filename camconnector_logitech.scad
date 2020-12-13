use <MCAD/regular_shapes.scad>
use <nutsnbolts/cyl_head_bolt.scad>


$fa=1;
$fs=0.2 ;

boardRadius = 16   ;
boardHeight =  1.3 ;

boardClamX =  3 ;
boardClamY = 21 ;
boardClamZ =  3 ;

nutLockX = 6;
nutLockY = 8;

baseX = boardRadius*2;
baseY = boardClamX;
baseZ =  3;

cableLockX = 6;
cableLockY = baseY;
cableLockZ = 5;

cableHoleX = 3;
cableHoleY = baseY;
cableHoleZ = cableLockZ/2 ;

module camboard () {
  //octagon calc:
  sideLength = (boardRadius)/((1+sqrt(2))/2) ; 
  outerRadius=((sqrt(4+2*sqrt(2)))/2)*sideLength ;
  color("green",0.2) {
    translate ([0,0,-boardHeight/2]){
      rotate (-360/16) {
        linear_extrude (boardHeight) {
          octagon (outerRadius) ;
        }
      }
    }
  }
}

module rightBoardClam () {
  translate ([boardRadius-1.5,-boardClamY/2-5,-boardClamZ/2]) {
    cube ([boardClamX,boardClamY,boardClamZ+1]) ;
  }
}


module leftBoardClam () {
  union () {
    mirror ([1,0,0]) {
      rightBoardClam() ;
    }

    //gyroconnector
    translate ([-boardRadius-3,0,0]) {
      difference () {
        union () {
          translate ([-0.495,0,-0.5]) {
            minkowski () {
              cube ([nutLockX-1,nutLockY-2,boardClamZ+1],center=true) ;
#              cylinder (r=1);
            }
          }
          minkowski () {
            cube ([nutLockX,nutLockY,boardClamZ],center=true) ;
            sphere (1); 
          }
        }
        translate ([1.2,0,0]) {
          rotate ([180,270,0]) {
            nutcatch_sidecut (name ="M3",l= 5) ;
            hole_through (name= "M3") ;
          }
        }
      }
    }
  }
}

module boardClams () {
  rightBoardClam() ;
  leftBoardClam() ;
}

module base() {
  translate ([0,-boardRadius-1,0]) {
    union () {
      translate ([-boardRadius,0,-baseZ/2]) {
        cube ([baseX,baseY,baseZ+1]) ;
      }
      for (x=[-1:2:1]) {
        translate ([boardRadius*x,baseY/2,-baseZ/2]) {

          cylinder (d=baseY,h=baseZ+1, center=1) ;
        }
      }
    }
  }
}

module cableLock () {
  translate ([-cableLockX/2,-boardRadius-1,-4]) {
    difference () {
      cube ([cableLockX,cableLockY,cableLockZ]) ;
      translate ([cableHoleX/2,0,1]) {
        cube ([cableHoleX,cableHoleY,cableHoleZ]) ;
      }
    }
  }
}

module arm () {
  module vertArm() {
    difference () {
      union () {
        translate ([-30,-10,0]) {
          cube ([4,25,boardClamZ+2],center=true) ;
        }
        translate ([-30,2,0]) { 
          rotate ([90,90,90]) {
            cylinder (h=4,d=boardClamZ+2,center=true) ;
          }
        }
      }
      rotate ([0,90,0]) {
        hole_through (name ="M3") ;
      }

    }
  }
  module  horizArm () {
    difference () {
      translate ([-13,-22.5,0]) {
        cube ([34,4,boardClamZ+2],center=true) ;
      }
      translate ([0,-23.5,0]) {
        rotate ([90,-90,0]) {
          nutcatch_sidecut (name ="M3",l= 5) ;
        }
      }

      rotate ([-90,0,0]) {
        hole_through (name= "M3") ;
      }
    }
  }

  module corner () {
    translate ([-30,-22.5,0]) {
      cylinder (d=4,h=boardClamZ+2,center=true) ;
    }
  }

  union () {
    vertArm ();
    horizArm () ;
    corner ();
  }
}


%camboard() ;
arm() ;

difference () {
union () {
  base () ;
  boardClams () ;
  cableLock() ;
}
scale ([1.03,1.03,1.03]) {
camboard () ;
}
}
