package 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	
	public class CheckUps
	{
		
		var block_x:int = 20;
		var block_y:int = 20;
		
		public function CheckUps()
		{
			
		}
		
	    public static function playerJump(_pla:Player){
			if(_pla.status==1){
				//_pla.vy=0;
				_pla.vy-=_pla.jumpForce;
				_pla.status=0;
			}
		}
	
		
	    static function checkBlockPlayer(_pla:Player) {
			_pla.status=0;
		    var playerPos:Point = gridOf(_pla);
			var walls:Vector.<Point> = getBlockVector(playerPos);
			//trace("walls in checkBlockPlayer",walls);
			var oldRect:Rectangle = _pla.getRect(_pla);
			oldRect.x=_pla.x;
			oldRect.y=_pla.y;
			var testRect:Rectangle = getMCRect(_pla);
			
			for each(var wall:Point in walls) {
				
				//trace("wall:",wall,"--is checking now...");
				var wallRect:Rectangle = new Rectangle();
				wallRect.width = Main.block_x;
				wallRect.height = Main.block_y;
				wallRect.x = Math.round(wall.x * Main.block_x);
				wallRect.y = Math.round(wall.y * Main.block_y);
				
				trace("wallRect",wallRect.top,wallRect.bottom,wallRect.left,wallRect.right);
				
				var intersect:Rectangle = wallRect.intersection(testRect);
				if (!intersect.width || !intersect.height) {
					continue;
				}
				if (wallRect.top >= oldRect.bottom) {
					testRect.y -= intersect.height;
					if (intersect.height){
					   //trace("wall is beneath");
					  if (Math.abs(_pla.vy) < 1.5) {
						_pla.vy = 0;
						_pla.status=1;
						//_pla.status=1;
					  }else {
						_pla.vy = _pla.vy*(-0.5);
						//trace("***status changed!***");
					  } 
					}  
				}
				intersect = wallRect.intersection(testRect);
				if (wallRect.right <= oldRect.left) {
					testRect.x += intersect.width;
					if (intersect.width){
						//trace("wall is on the left");
						_pla.vx = 0;
					
					}
				}
				intersect = wallRect.intersection(testRect);
				if (wallRect.left >= oldRect.right) {
					testRect.x -= intersect.width;
					if (intersect.width){
						//trace("wall is on the right");
						_pla.vx = 0;
					}
				}
				
				
				
				
				intersect = wallRect.intersection(testRect);
				if (wallRect.bottom <= oldRect.top) {
					testRect.y += intersect.height;
					if (intersect.height){
						//trace("wall is above");
						_pla.vy = _pla.vy*(-0.7);
						_pla.status=0;
					}
				}
				
				
				
				_pla.tempX = testRect.x;
				_pla.tempY = testRect.y;
				
			}
	    }
		
		static function checkAniBull(_ani:Animal, _bul:Bull0):Boolean {
			if (_bul.origin.owner!=Main.player1) {
				return false;
			}
			
			
		    var mcRect:Rectangle = _ani.getRect(_ani);
			var bulRect:Rectangle = _bul.getRect(_bul);
			mcRect.x = _ani.x;
			mcRect.y = _ani.y;
			bulRect.x = _bul.x;
			bulRect.y = _bul.y;
			if (rectSituationOf(mcRect,bulRect)) {
				return true;
			}
			return false;
	    }
		
	    static function checkPlayerBull(_pla:Player,_bul:Bull0):Boolean {
		    var mcRect:Rectangle = getMCRect(_pla);
			var bulRect:Rectangle = _bul.getRect(_bul);
			mcRect.x = _pla.tempX;
			mcRect.y = _pla.tempY;
			bulRect.x = _bul.x;
			bulRect.y = _bul.y;
			if (rectSituationOf(mcRect,bulRect)) {
				return true;
			}
			return false;
	    }
		
		/*static function checkPlayerAnimal(_pla:Player,_ani:Animal) {
		    //
	    }
	
	    static function checkPlayerItem(_pla:Player,_ite:Item) {
		    //
	    }*/
		
		static function checkIfOut(_pla:Player):Boolean {
			var mcRect:Rectangle = getMCRect(_pla);
			var stageRect:Rectangle = new Rectangle();
			mcRect.x = _pla.tempX;
			mcRect.y = _pla.tempY;
			stageRect.width = Main.block_x * Main.currentMap.width;
			stageRect.height = Main.block_y * Main.currentMap.height;
			stageRect.x = 0;
			stageRect.y = 0;
			if (rectSituationOf(mcRect,stageRect)) {
				return false;
			}
			return true;
	    }
		
		static function checkStatus(_pla:Player) {
		    //?
	    }
		
		protected static function getBlockVector(pos:Point):Vector.<Point> {
			var mapX = Main.currentMap.width-1;
			var mapY = Main.currentMap.height-1;
			var vec:Vector.<Point> = new Vector.<Point>();
			
			//trace(mapX,mapY,"map@@@");
			//trace(pos,"--_pos in getBlockVector");
			
			var hasLeft:Boolean = false;
			var hasRight:Boolean = false;
			var hasUp:Boolean = false;
			var hasDown:Boolean = false;
			
				hasLeft = true;
				hasRight = true;
				hasUp = true;
				hasDown = true;
			
			if (pos.x == 0) {
				hasLeft =false;
			}
			if (pos.x == mapX) {
				hasRight = false;
			}
			if (pos.y == 0) {
				hasUp = false;
			}
			if (pos.y == mapY) {
				hasDown = false;
			}
			
			
			
			//trace(hasLeft,hasRight,hasUp,hasDown,"-hases in getBlockVector");//true
			if (hasLeft && hasUp) {
				var p1:Point=new Point(pos.x - 1, pos.y - 1);
				if(Main.currentMap.blockList[p1.y][p1.x]==1){
					vec.push(p1);
				}				
			}
			if (hasRight && hasUp) {
				var p2:Point=new Point(pos.x + 1, pos.y - 1);
				if(Main.currentMap.blockList[p2.y][p2.x]==1){
					vec.push(p2);
					//trace(p2);
				}				
			}
			if (hasUp) {
				var p3:Point=new Point(pos.x, pos.y - 1);
				if(Main.currentMap.blockList[p3.y][p3.x]==1){
					vec.push(p3);
					//trace(p3);
				}				
			}
			if (hasLeft && hasDown) {
				var p4:Point=new Point(pos.x-1,pos.y+1);
				if(Main.currentMap.blockList[p4.y][p4.x]==1){
					vec.push(p4);
				}
			}
			if (hasRight && hasDown) {
				var p5:Point=new Point(pos.x+1,pos.y+1);
				if(Main.currentMap.blockList[p5.y][p5.x]==1){
					vec.push(p5);
				}				
			}
			if (hasDown) {
				
				var p6:Point=new Point(pos.x,pos.y+1);
				//trace(Main.currentMap.blockList[p6.x][p6.y],"p6");
				if(Main.currentMap.blockList[p6.y][p6.x]==1){
					vec.push(p6);
				}				
			}
			if (hasRight) {
				var p7:Point=new Point(pos.x+1,pos.y);
				if(Main.currentMap.blockList[p7.y][p7.x]==1){
					vec.push(p7);
				}				
			}
			if (hasLeft) {
				var p8:Point=new Point(pos.x-1,pos.y);
				//trace(Main.currentMap.blockList[p8.x][p8.y]);
				if(Main.currentMap.blockList[p8.y][p8.x]==1){
					vec.push(p8);
				}				
			}
			//trace(vec,"--vec in getBlockVector");
			return vec;
		}//vector available?
		
		static function checkPlayerBubble(_pla:Player,_bub:Bubble) {
		    var bubbleRect:Rectangle=_bub.getRect(_bub);
			bubbleRect.x=_bub.x;
			bubbleRect.y=_bub.y;
			var playerRect:Rectangle = _pla.getRect(_pla);
			playerRect.x=_pla.x;
			playerRect.y=_pla.y;
			var intersect:Rectangle=bubbleRect.intersection(playerRect);
			//trace("checkP&B");
			//traceRect(bubbleRect);
			//traceRect(playerRect);
			if (intersect.width && intersect.height) {
				return true;
			}
			return false;
	    }
		
		protected static function traceRect(rect:Rectangle){
			trace("rect",rect.top,rect.bottom,rect.left,rect.right);
		}
		
		protected static function circleSituationOf(ob1:Point,ob2:Point,distance:Number):Boolean {
			var dx:Number = ob1.x - ob2.x;
			var dy:Number = ob1.y - ob2.y;
			var dis:Number = dx * dx + dy * dy;
			if (dis < distance * distance) {
				return true;
			}
			return false;
		}
		
		
		public static function rectSituationOf(ob1:Rectangle,ob2:Rectangle):Boolean {
			var rect:Rectangle=ob1.intersection(ob2);
			if(rect.width && rect.height){
				return true;
			}
			return false;
		}
		
		protected static function gridOfBull(mc:Bull0):Point {
		    var mcRect:Rectangle = mc.getRect(mc);
			var centerX:Number = mcRect.x+mcRect.width/2//;
			var centerY:Number = mcRect.y+mcRect.height/2;//
			var xPos:int = Math.floor(centerX / Main.block_x);
			var yPos:int = Math.floor(centerY / Main.block_y);
			
			//trace(xPos,yPos,"gridOf---------");
			
			return new Point(xPos,yPos);
	    }
		
		protected static function gridOf(mc:MC):Point {
		    var mcRect:Rectangle = getMCRect(mc);
			var centerX:Number = mcRect.x+mcRect.width/2//;
			var centerY:Number = mcRect.y+mcRect.height/2;//
			var xPos:int = Math.floor(centerX / Main.block_x);
			var yPos:int = Math.floor(centerY / Main.block_y);
			
			//trace(xPos,yPos,"gridOf---------");
			
			return new Point(xPos,yPos);
	    }
		
		protected static function getMCRect(mc:MC):Rectangle {
			var rect:Rectangle = mc.getRect(mc);
			rect.x = mc.tempX;
			rect.y = mc.tempY;
			return rect;
		}
		
		protected static function getRectCenter(rect:Rectangle):Point {
			var centerX:Number = rect.x + rect.width / 2;
			var centerY:Number = rect.y + rect.height / 2;
			return new Point(centerX,centerY);
		}
	}
}
