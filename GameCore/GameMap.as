/*

A data structure to store map info.

*/

package 
{
	
	public class GameMap
	{
		var height:int;
		var width:int;
		
		var player_x:Number=25;
		var player_y:Number=25;
		var bubble_x:Number;
		var bubble_y:Number;
		var gravity:Number = 1;
		
		var blockList:Array = new Array();
		var itemList:Vector.<Item>=new Vector.<Item>;
		var animalList:Vector.<Animal>=new Vector.<Animal>;
		
		public function GameMap(_height:int, _width:int) {
            trace("a new GameMap has been created!");
			height = _height;
			width = _width;
			bubble_x = width;
			bubble_y = height;


		}

	}
	
}
