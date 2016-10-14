/*

TCXX
http://tcxx.info

File: Physics.as
Created: 2012-12-7 21:36:43
Modified: 2012-12-7 21:43:06
Size: 565 bytes

*/


package 
{
	import flash.display.*;
	import flash.geom.Rectangle;
	
	public class Physics
	{
		
		static var gravity:Number=.95;
		
		public function Physics()
		{
			//
		}
		
	
	    static function updateP() {
		    applyForces();
			//Main.man1.x=Main.player1.tempX;
			//Main.man1.y=Main.player1.tempY;
			moveObjects();
			//trace(Main.player1.tempX,Main.player1.tempY);
			checkUp();
			render();
			
			//trace("---------update done!!");
			
			
			//trace("status=",Main.player1.status);
			trace(" ");
	    }
	
	    protected static function applyForces() {
			
			playerApplyForces(Main.player1);
			
			//bull Apply Forces
		    for (var _bul:String in Main.bulls) {
				var i:int = Number(_bul);
				Main.bulls[i].x += Main.bulls[i].origin.vx;
				Main.bulls[i].y += Main.bulls[i].origin.vy;
				
				
				if (Main.bulls[i].origin.type.ifGravity==true) {
					Main.bulls[i].origin.vy += gravity*0.9;
				}

				if ((Main.bulls[i].x > 550)||(Main.bulls[i].x < 0)||(Main.bulls[i].y > 400)||(Main.bulls[i].y <0)) {
					Main.bullLevel.removeChild(Main.bulls[i]);
					Main.bulls.splice(i,1);
				}
			}
			
			for each(var _ani in Main.currentMap.animalList) {
				animalApplyForces(_ani);
			}
	    }
		
	    protected static function playerApplyForces(_pla:Player){
            //if(_pla.status==0){
				_pla.vy+=gravity;
			//}
            
            

            if(_pla.keyLeftPressed){
               _pla.vx-=_pla.dragForce;
            }
            if(_pla.keyRightPressed){
               _pla.vx+=_pla.dragForce;
            }
 
            if(_pla.vx>0){
                if(_pla.vx>_pla.friction){
                   _pla.vx-=_pla.friction;
                }else{
                    _pla.vx=0;
                }
            }else{
                if(_pla.vx<-_pla.friction){
                    _pla.vx+=_pla.friction;
                }else{
                    _pla.vx=0;
                }
            }

            if(_pla.vx>_pla.MAX_WALKING_SPEED){
                _pla.vx=_pla.MAX_WALKING_SPEED;
            }else{
                if(_pla.vx<-_pla.MAX_WALKING_SPEED){
                    _pla.vx=-_pla.MAX_WALKING_SPEED;
                }
            }

            if(_pla.vy>_pla.MAX_FALLING_SPEED){
                _pla.vy=_pla.MAX_FALLING_SPEED;
            }
			
			if(_pla.vx>0){
				_pla.scaleX = -1;
			}else if(_pla.vx<0){
				_pla.scaleX = 1;
			}
			//trace(_pla,":",_pla.vy,"-pla.vy in PlayerApplyF");
        }

	    protected static function animalApplyForces(_ani:Animal) {
		    /*if (_ani.direction == true) {
				_ani.tempX += _ani.speed;
			}else {
				_ani.tempX -= _ani.speed;
			}*/
	    }
		
		protected static function checkUp() {
			
			CheckUps.checkBlockPlayer(Main.player1);//1
			
			for (var k:int = 0; k < Main.currentMap.itemList.length; k++ ) {
			    if (!(Main.currentMap.itemList[k] is Item)) {
					continue;
				}
				var rect1:
				  Rectangle = Main.currentMap.itemList[k].getRect(Main.currentMap.itemList[k]);
				var rect2:
				  Rectangle = Main.player1.getRect(Main.player1);
				rect1.x = Main.currentMap.itemList[k].x;
				rect1.y = Main.currentMap.itemList[k].y;
				rect2.x = Main.player1.tempX;
				rect2.y = Main.player1.tempY;

				if (CheckUps.rectSituationOf(rect1, rect2)) {
					Main.currentMap.itemList[k].collectPoints();
					Main.itemLevel.removeChild(Main.currentMap.itemList[k]);
					Main.currentMap.itemList.splice(k, 1);
					
			      }
			} //4	
			
			CheckUps.checkStatus(Main.player1);//5
			//6
			
			for (var m:int = 0; m < Main.currentMap.animalList.length; m++ ) {
				if (!(Main.currentMap.animalList[m] is Animal)) {
					continue;
				}
				for (var n:int = 0; n < Main.bulls.length; n++ ) {
				  if (CheckUps.checkAniBull(Main.currentMap.animalList[m], Main.bulls[n])) {
					Main.currentMap.animalList[m].alpha-= (Main.bulls[n].origin.type.power)*0.01;
					Main.bullLevel.removeChild(Main.bulls[n]);
					Main.bulls.splice(n, 1);
					if (Main.currentMap.animalList[m].alpha<=0.03) {
						Main.itemLevel.removeChildAt(m);
						Main.currentMap.animalList.splice(m,1);
					}	
			      }
				}  
			}
			
			for (var i:int = 0; i < Main.bulls.length; i++ ) {
				if(Main.bulls[i].origin.owner!=Main.player1){
				  if (CheckUps.checkPlayerBull(Main.player1, Main.bulls[i])) {
					Main.player1.alpha-= (Main.bulls[i].origin.type.power)*0.01;
					Main.bullLevel.removeChild(Main.bulls[i]);
					Main.bulls.splice(i, 1);
					
				  }
			    }  
			}
	    }
		
		protected static function moveObjects() {
			
		    moveMC(Main.player1);
			//for each(var _ani in Main.currentMap.animalList) {
				//moveMC(_ani);
			//}
	    }
	
	    protected static function moveMC(mc:MC) {
		    mc.tempX += mc.vx;
			mc.tempY += mc.vy;
			//trace("mc",mc);
	    }
		
		protected static function render() {
		
				
		    Main.updateMC(Main.player1);
				//trace("Render done!");
			
		    
			//for each(var _ani in Main.currentMap.animalList) {
				//Main.updateMC(_ani);
			//}
	    }
	}
}