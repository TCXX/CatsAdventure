package 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Diamond extends Animal 
	{
		public function Diamond(_speed:int=2) {
			this.speed=_speed;
		}
		
		public override function shoot() {
			var t:BullType =Main.bull1;
			var b:Bull = new Bull(new Point(this.x, this.y), new Point(1,0), t);
			b.owner = this;
			var c:Bull = new Bull(new Point(this.x, this.y), new Point(-1,0), t);
			c.owner = this;
			var d:Bull = new Bull(new Point(this.x, this.y), new Point(0,1), t);
			d.owner = this;
			var e:Bull = new Bull(new Point(this.x, this.y), new Point(0,-1), t);
			e.owner = this;
		}
	}
	
}