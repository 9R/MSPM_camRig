
$fa=1;
$fs=0.1;

width =  2+3+12 ;
height = 23 ;
//profile
pWidth  = 8;
pHeight = 3;


module  shape () {
  union () {
    //VertiArm
    cube ([pWidth,pHeight,height]);
    //horizArm
    cube ([pWidth,width,pHeight]);
    // vertiTip
    translate ([pWidth/2, width,0]) {
      cylinder (d=pWidth, h=pHeight) ;
    }
    // horizTip
    translate ([pWidth/2, 0,height]) {
      rotate ([-90,0,0]) {
        cylinder (d=pWidth, h=pHeight) ;
      }
    }
  }
}

module holeM3 (h) {
  cylinder (r=3.6/2, h=h) ;
}

module gimbal () {
  difference () {
    union () {
      shape() ;
    }
    union () {
      // vertHole
      translate ([pWidth/2, width,-1]) {
        holeM3(pHeight+2) ;
      }
      // horizHole
      translate ([pWidth/2, -1,height]) {
        rotate ([-90,0,0]) {
          holeM3(pHeight+2) ;
        }
      }
    }
  }
}


gimbal();
