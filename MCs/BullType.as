package 
{
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class BullType
	{
		public var size:int;
		public var speed:Number;
		public var power:int;
		public var ifGravity:Boolean;
		public var ifHard:Boolean;
		
		public function BullType(_size:int,_speed:Number,_power:int,_gravity:Boolean,_ifHard:Boolean) {
			this.size = _size;
			this.speed = _speed;
			this.power = _power;
			this.ifGravity = _gravity;
			this.ifHard = _ifHard;
		}
	}
	
}