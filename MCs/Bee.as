package 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Bee extends Animal 
	{
		public function Bee(_speed:int=2) {
			this.speed=_speed;
		}
		
		public override function shoot() {
			var t:BullType =Main.bull3;
			var b:Bull = new Bull(new Point(this.x, this.y-3), new Point(1,0), t);
			b.owner = this;
			var c:Bull = new Bull(new Point(this.x, this.y-3), new Point(-1,0), t);
			c.owner = this;
			var d:Bull = new Bull(new Point(this.x-3, this.y), new Point(0,1), t);
			d.owner = this;
			var e:Bull = new Bull(new Point(this.x-3, this.y), new Point(0,-1), t);
			e.owner = this;
			//
			var f:Bull = new Bull(new Point(this.x, this.y+3), new Point(1,0), t);
			f.owner = this;
			var g:Bull = new Bull(new Point(this.x, this.y+3), new Point(-1,0), t);
			g.owner = this;
			var h:Bull = new Bull(new Point(this.x+3, this.y), new Point(0,1), t);
			h.owner = this;
			var i:Bull = new Bull(new Point(this.x+3, this.y), new Point(0,-1), t);
			i.owner = this;
		}
	}
	
}