
$fa=1;
$fs=0.1;

length=90;

angle=30;

pHeight=11;
pWidth=10;

gap=2.5;

module  hole (d,h) {
  cylinder (d=d,h=h) ;
}

module M3hole (h) {
  hole (3.6,h);
}

module connector () {
  difference () {
    union () {
      //roundedEnd
      translate ([0,0,pWidth/2]) {
        rotate ([-90,0,0]) {
          cylinder (d=pWidth, h=pHeight) ;
        }
      }
      //connection
      cube ([pWidth+2,pHeight,pWidth]) ;
      //connection round
      translate ([pWidth+2,pHeight/2,0]){
        cylinder (d=pHeight,h=pWidth);
      }
    }
    union () {
      //screwhole
      translate ([0,-1,pWidth/2]) {
        rotate ([-90,0,0]){
          M3hole (pWidth+2);
        }
      }
      //connectorSlits
      for ( i = [0:2+gap:5] ) {
        translate ([-pWidth/2,2+i,-1]){
          cube ([pWidth+1,gap,pWidth+2]);
        }
      }
    }
  }
}


module connector180 () {
  translate ([pWidth+7,0,pWidth]){
    //translate ([pWidth+8,0,pWidth]){
    rotate ([0,180,0]){
      connector() ;
    }
  }
  }

  module arm () {
    union () {
      translate ([0,-pHeight/2,0]) {
        cube ([length, pHeight, pWidth]);

      }
    }
  }


  module platform () {
  }

  difference () {
    union () {
      connector () ;
      translate ([pWidth+2,pHeight/2,]) {
        rotate ([0,0,angle]) {
          arm() ;
        }
        translate ([cos(angle)*length-pWidth/2,sin(angle)*length-pHeight/2,0 ]) {
          //    cube ([pWidth,pHeight,pWidth]);
          connector180() ;   
        }
      }
    }
    union () {
      for ( i = [0:pHeight:length] ) {
        translate ([12,pHeight/2,-1]){
          rotate ([0,0,angle]) {
            translate ([i,0,0]) {
              cylinder (d=pHeight-2,h=pWidth+2);
              if ( i>0 && i<length-pWidth  ) {
              translate ([0,0,pHeight/2]) {
              rotate ([90,0,0]) {
              cylinder (d=pWidth-2,h=pWidth *2,center=true);
              }
              }
              }
            }
          }
        }
      }

    }
  }