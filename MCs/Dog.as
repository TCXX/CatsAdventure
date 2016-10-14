package 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Dog extends Animal 
	{
		public function Dog(_speed:int=2) {
			this.speed=_speed;
		}
		
		public override function shoot() {
			var t:BullType =Main.bull6;
			var b:Bull = new Bull(new Point(this.x,this.y-10+Math.random()*5),new Point(Main.player1.x-this.x, Main.player1.y-this.y),t);
			b.owner = this;
			
		}
	}
	
}