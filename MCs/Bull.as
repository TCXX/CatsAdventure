package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Bull
	{
		public var vx:Number;
		public var vy:Number;
		public var type:BullType;
		public var owner:DisplayObject;
		
		
		public function Bull(_pos:Point, _direction:Point, _type:BullType) {
			type = _type;
			var speed:Point = bullSpeedTrans(_direction, _type.speed);
			vx = speed.x;
			vy = speed.y;
			
			
			//colors-----------------------------------------------------
			
			var c:ColorTransform = new ColorTransform();
			
			
			switch (_type)
			{
				case Main.bull1:
					c.color = 0x33FFFF;
					break;
				case Main.bull2:
					c.color = 0x999999;
					break;
				case Main.bull3:
					c.color = 0xFFFF33;
					break;
				case Main.bull4:
					c.color = 0xFF6600;
					break;	
				case Main.bull5:
					c.color = 0xFF0000;
					break;
				case Main.bull6:
					c.color = 0x660000;
					break;	
			}
			
			
			
			var b:Bull0 = new Bull0();
			b.x = _pos.x;
			b.y = _pos.y;
			b.transform.colorTransform = c;
			b.origin = this;
			
			//b
			Main.bulls.push(b);
			Main.bullLevel.addChild(b);
		}
		
		protected function bullSpeedTrans(_direction:Point,_speed:Number):Point {
			var dx:Number = _direction.x;
			var dy:Number = _direction.y;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			var rat:Number = _speed / distance;
			var ans:Point = new Point(dx*rat,dy*rat);
			return ans;
		}
		
		
		
	}
	
}