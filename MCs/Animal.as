/*

TCXX
http://tcxx.info


File: Animal.as
Created: 2012-12-7 21:41:01
Modified: 2012-12-7 21:47:44
Size: 198 bytes

*/


package 
{

	import flash.display.MovieClip;
	
	public class Animal extends MC
	{
		var speed:Number;
		var direction:Boolean=true;
		
		public function Animal(_speed:int=2) {
			this.speed = _speed;
		}
		
		public function shoot() {
			
		}
	}
	
}