use <connector.scad>;

$fa=1;
$fs=0.4;

cHeight=11 ;
cWidth=10 ;
bHeight=2;

gap =2.5;

//basic modules
//##############
module  hole (d,h) {
  cylinder (d=d,h=h) ;
}

module M3hole (h) {
  hole (3.6,h);
}

//part definiton
//##############
//base
module base (thickness) {
  //scale to 1cm thickness
  scale ([1,1,thickness*10]) {
    //move slice to z=0
    translate ([0,0,-0.5]) {
      //remove top & bottom
      difference () {
        //keep
        union (){
          import ("imports/MPSM_Cable_Brace.stl", convexity=10);
          //close hole
          translate ([-4,-4,0]) {
            cube ([10,8.6,10]) ;
          }
        }
        //cut
        union () {
          //cut above
          translate ([-15,-30,0.6]) {
            cube ([30,40,50]) ;
          }
          //cut below
          translate ([-15,-30,-1]) {
            cube ([30,40,1.5]) ;
          }
        }
      }
    }
  }
}

union () {
  base(bHeight);
  translate ([0,-5,0.1]) {
  connector2x (cWidth,cHeight,gap);
}
}
