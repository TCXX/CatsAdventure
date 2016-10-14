/*

TCXX
http://blog.sina.com.cn/1cindy2candy

File: Player.as
Created: 2012-12-7 21:07:31
Modified: 2012-12-7 21:36:12
Size: 424 bytes
*/

package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Player extends MC
	{
		var shooting:Boolean = true;
		
		var MAX_FALLING_SPEED = 7;
		var MAX_WALKING_SPEED = 4;
		
		var jumpForce:Number=10; 
		var dragForce:Number=3; 
		var friction:Number = .5;
		
		var status:int=0;
		var animalAttacking:Boolean;
		
		var keyLeftPressed:Boolean = false;
		var keyRightPressed:Boolean = false;
		var t:BullType;
		
		
		public function Player() {
			tempX=this.x;
			tempY=this.y;
		}
		
		
		public function shoot() {
		  if(t==Main.bull2){
			var dir:Point = new Point(-1, -2);
			if (this.scaleX == -1) {
				dir = new Point(1, -2);
			}
			var b_:Bull = new Bull(new Point(this.x,this.y),dir, this.t);
			b_.owner = this;
			
		    }else {
			var b:Bull = new Bull(new Point(this.x, this.y), new Point(1,0), this.t);
			b.owner = this;
		    var c:Bull = new Bull(new Point(this.x, this.y), new Point(-1,0), this.t);
			c.owner = this;
			var d:Bull = new Bull(new Point(this.x, this.y), new Point(0,1), this.t);
			d.owner = this;
			var e:Bull = new Bull(new Point(this.x, this.y), new Point(0,-1), this.t);
			e.owner = this;
			var $b:Bull = new Bull(new Point(this.x, this.y), new Point(1,1),this.t);
			$b.owner = this;
		    var $c:Bull = new Bull(new Point(this.x, this.y), new Point(-1,1), this.t);
			$c.owner = this;
			var $d:Bull = new Bull(new Point(this.x, this.y), new Point(1,-1), this.t);
			$d.owner = this;
			var $e:Bull = new Bull(new Point(this.x, this.y), new Point(-1,-1), this.t);
			$e.owner = this; 
			}
		}
		
	}
	
}