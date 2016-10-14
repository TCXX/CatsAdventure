package 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author TCXX
	 */
	public class Box extends Animal 
	{
		public function Box(_speed:int=2) {
			this.speed=_speed;
		}
		
		public override function shoot() {
			var t:BullType;
			var t_:BullType;
			
			var n:int = Math.floor(Math.random() * 15);
			
			switch (n)
			{
				case 0 :
				case 3 :
				case 4 :	
				case 1 :
				case 12:
					t = Main.bull4;
					var b:Bull = new Bull(new Point(this.x, this.y), new Point(1,0), t);
			        b.owner = this;
		         	var c:Bull = new Bull(new Point(this.x, this.y), new Point(-1,0), t);
			        c.owner = this;
					t = Main.bull5;
			        var d:Bull = new Bull(new Point(this.x, this.y), new Point(0,1), t);
			        d.owner = this;
			        var e:Bull = new Bull(new Point(this.x, this.y), new Point(0,-1), t);
			        e.owner = this;
					
					t_ = Main.bull3;
					var $b:Bull = new Bull(new Point(this.x, this.y), new Point(1,1), t_);
			        $b.owner = this;
		         	var $c:Bull = new Bull(new Point(this.x, this.y), new Point(-1,1), t_);
			        $c.owner = this;
					t_ = Main.bull6;
			        var $d:Bull = new Bull(new Point(this.x, this.y), new Point(1,-1), t_);
			        $d.owner = this;
			        var $e:Bull = new Bull(new Point(this.x, this.y), new Point(-1,-1), t_);
			        $e.owner = this;
					break;
				case 2 :
					t = Main.bull1;
					var b2:Bull = new Bull(new Point(this.x, this.y), new Point(Main.player1.x - this.x, Main.player1.y - this.y), t);
					b2.owner = this;
					break;
				
					
				case 5 :
					t = Main.bull2;
					var b6:Bull = new Bull(new Point(this.x, this.y), new Point(Main.player1.x - this.x, Main.player1.y - this.y), t);
					b6.owner = this;
					break;
					
				case 6 :	
				case 7 :
					t = Main.bull3;
					var b7:Bull = new Bull(new Point(this.x, this.y), new Point(Main.player1.x - this.x, Main.player1.y - this.y), t);
					b7.owner = this;
					break;
					
				case 8 :	
				case 9 :	
				case 10 :
				case 11 :
					t = Main.bull4;
					var b8:Bull = new Bull(new Point(this.x, this.y), new Point(Main.player1.x - this.x, Main.player1.y - this.y), t);
					b8.owner = this;
					break;	
					
					
					
				case 13:	
				case 14 :
					t = Main.bull5;
					var b9:Bull = new Bull(new Point(this.x, this.y), new Point(Main.player1.x - this.x, Main.player1.y - this.y), t);
					b9.owner = this;
					break;
				case 15 :
					t = Main.bull6;
					var b10:Bull = new Bull(new Point(this.x, this.y), new Point(Main.player1.x - this.x, Main.player1.y - this.y), t);
					b10.owner = this;
					break;		
			}


			
		}
	}
	
}