package 
{

	import flash.display.MovieClip;
	
	public class Item extends MovieClip
	{
		var _points:int;
		var _type:String;
		
		public function Item() {
			
		}
		
		function collectPoints() {
			//trace(this._type);
			switch(this._type) {
				//case Xin:Object(Main).nextLevel();
				    //break;
					
				case "Love":Main.life+=1;
				    break;	
				case "Sand":Main.player1.t=Main.bull6;
				    break;
				case "BBQ":Main.time+=100;
				    break;	
				throw new Error("This is a exception of item!");	
			}
		}
	}
	
}