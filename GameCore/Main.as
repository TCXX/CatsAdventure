/*

TCXX
http://tcxx.info

File: Main.as
Created: 2012-8-23 21:28:45
Modified: 2012-12-7 21:42:05
Size: 2929 bytes

*/

package 
{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.net.URLRequest;
    import flash.events.MouseEvent;
	//

	public class Main extends MovieClip
	{
		static const stage_x = 550;
		static const stage_y = 400;

		static var gameRunning:Boolean = false;
		static var gameTimer:Timer = new Timer(500);
		static var aniTimer:Timer = new Timer(1500);
		var lyricTimer:Timer = new Timer(33375);
        //var lyricTimer:Timer = new Timer(1000);
		
		static var gameMap:Maps = new Maps();

		static var player1:Player;
		static var bubble1:Bubble;
		//static var man1:Man;
		
		static var board1:Board = new Board();
		static var hintBoard1:HintBoard = new HintBoard();

		static var bgLevel:Sprite = new Sprite();
		static var blockLevel:Sprite = new Sprite();
		static var itemLevel:Sprite = new Sprite();
		static var playerLevel:Sprite = new Sprite();
		static var bullLevel:Sprite = new Sprite();
		static var buttonLevel:Sprite = new Sprite();
		static var hintLevel:Sprite = new Sprite();
		
		static var bgColor:BgColor = new BgColor();

		static var keyLeft:int = Keyboard.LEFT;
		static var keyRight:int = Keyboard.RIGHT;
		static var keyJump:int = Keyboard.UP;
		static var keyUse:int = Keyboard.DOWN;

		static var block_x:int = 20;
		static var block_y:int = 20;

		static var currentLevel:int;
		static var currentMap:GameMap;
		//关卡&地图

		static var score:int;
		static var time:int;
		static var life:int;
		static var suc:Boolean = false;

        static var snows:Vector.<Sprite> = new Vector.<Sprite>();
		static var bulls:Vector.<Bull0> = new Vector.<Bull0>();
		
		//(_size:int=10,_speed:Number=15,_power:int=5,_gravity:Boolean=true,_ifHard:Boolean=false)
		static var speedRate:Number = 0.3;
		static var bull1:BullType = new BullType(10,6*speedRate,1,true,false);
		static var bull2:BullType = new BullType(10,24*speedRate,5,true,false);
		static var bull3:BullType = new BullType(6,12*speedRate,10,false,false);
		static var bull4:BullType = new BullType(10,25*speedRate,25,true,true);
		static var bull5:BullType = new BullType(13,40*speedRate,45,true,true);
		static var bull6:BullType = new BullType(8,30*speedRate,60,false,true);

		public function Main()
		{
			//&&start
			


			block_x = (stage_x - 30) / 26;
			block_y = stage_y / 20;

			varInitial();
            
			addLevels();
            nextLevel();
			//man1=new Man();
			//hintLevel.addChild(man1);
			//trace("Man created");
			//trace("h",hintLevel);
			createSnow();
			createColorfulSnow(10);
			trace("h",hintLevel);
            
			
			
			trace(" ");

			bgLevel.addChild(bgColor);
			//stage.addEventListener(KeyboardEvent.KEY_UP, changeColor);
		}
		

			
		protected function varInitial()
		{

			currentLevel = 0;
			gameRunning = false;
			score = 0;
			time = 999;
			life = 9;

		}
		

		function addLevels()
		{

			addEventListener(TimerEvent.TIMER, updateTime);//keep it
			addEventListener(TimerEvent.TIMER, animalShoot);
			
			
			
			addChild(bgLevel);
			//addChild(blockLevel0);
			addChild(blockLevel);
			addChild(itemLevel);//&animal
			addChild(playerLevel);
			addChild(bullLevel);
			addChild(buttonLevel);
			addChild(hintLevel);
			
			trace("addLevels!");

			//keep it
			//--------------------------------

			bgLevel.x = 0;
			bgLevel.y = 0;

			blockLevel.x = 0;
			blockLevel.y = 0;

			itemLevel.x = 0;
			itemLevel.y = 0;

			playerLevel.x = 0;
			playerLevel.y = 0;
			
			bullLevel.x = 0;
			bullLevel.y = 0;

			buttonLevel.x = 0;
			buttonLevel.y = 0;

			hintLevel.x = 0;
			hintLevel.y = 0;

			//display objects

            player1 = new Player();
            playerLevel.addChild(player1);
            bubble1 = new Bubble();
			playerLevel.addChild(bubble1);	
			
			
			buttonLevel.addChild(board1);
		}

		public static function loadLevel()
		{
			hintBoard1.play();
			var r:int = Math.round(Math.random() * 3);
			if (r==1) {
				hintBoard1.play();
			}
			trace(currentMap, "loadLevel");
			trace(currentLevel);
			trace(gameMap.mapList);
			
			
			
			bulls = new Vector.<Bull0>(); 

			
			bubble1.x = currentMap.bubble_x;
			bubble1.y = currentMap.bubble_y;

			player1.x = currentMap.player_x;
			player1.y = currentMap.player_y;
			player1.tempX = player1.x;
			player1.tempY = player1.y;
			player1.t = bull2;
			
			player1.alpha = 1;
		
			for (var i:int = 0; i < currentMap.animalList.length; i++ ) {
				itemLevel.addChild(currentMap.animalList[i]);
				
			}
			
			for (var j:int = 0; j < currentMap.itemList.length; j++ ) {
				itemLevel.addChild(currentMap.itemList[j]);
			}


			for (var _i:String in currentMap.blockList)
			{
				for (var _j:String in currentMap.blockList[_i])
				{
					if (currentMap.blockList[_i][_j] == 1)
					{
						var block1:Earth = new Earth();
						block1.x = block_x * (Number(_j));//+block_x/2
						block1.y = block_y * (Number(_i));//+block_y/2
						blockLevel.addChild(block1);
					}
				}
			}
			//keep it

			trace("Level loaded!");
		}


		static function removeLevel()
		{
			trace("remove");			

			for (var _m = 0; _m < currentMap.itemList.length;_m++ )
			{
				itemLevel.removeChildAt(0);
			}

			for (var _n = 0; _n < currentMap.animalList.length;_n++ )
			{
				itemLevel.removeChildAt(0);
			}

			for (var _k = 0; _k < bulls.length;_k++ )
			{
				bullLevel.removeChildAt(0);
			}
			
			for (var _i:String in currentMap.blockList)
			{
				for (var _j:String in currentMap.blockList[_i])
				{
					if (currentMap.blockList[_i][_j] == 1)
					{
						blockLevel.removeChildAt(0);
					}
				}
			}
			
		}


		static function updateMC(mc:MC)
		{
			mc.x = mc.tempX;
			mc.y = mc.tempY;
			//trace(mc.y);
		}

		protected function startGame()
		{
			//add Listeners
			gameTimer.start();
			aniTimer.start();


			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, downHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, upHandler);
            stage.addEventListener(Event.ENTER_FRAME, flySnow);
			gameTimer.addEventListener("timer", updateTime);
			aniTimer.addEventListener("timer", animalShoot);

			gameRunning = true;
			trace("============Game starts!");
			//trace(gameRunning);
		}
        
		protected function stopGame()
		{
			//remove Listeners
			gameTimer.stop();
			aniTimer.stop();


			stage.removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, downHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, upHandler);


			gameRunning = false;
			trace("Game stops!");
		}

		public function gameOver()
		{
			stopGame();
			hintLevel.removeChild(hintBoard1);
			var form:Form = new Form();
			form.height = 359;
			form.weight = 510;
			hintLevel.addChild(form);
			if (!suc)
			{
				createSnow();
				createSnow();
				createSnow();
				createSnow();
				createSnow();
				createSnow();
				createSnow();
				createSnow();
			}
		}


		protected function downHandler(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case keyLeft :
					player1.keyLeftPressed = true;
					break;
				case keyRight :
					player1.keyRightPressed = true;
					break;
				case keyJump :
					CheckUps.playerJump(player1);
					trace("Jump!");
					break;
				case keyUse :
				    if (player1.shooting == true) {
					    player1.shooting = false;
				        player1.shoot();	
					}
					break;
				case 48:	
				    nextLevel();
					break;
			}

		}

		protected function upHandler(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case keyLeft :
					player1.keyLeftPressed = false;
					break;
				case keyRight :
					player1.keyRightPressed = false;
					break;
			}

		}
		
        function animalShoot(e:TimerEvent) {
			for each(var _ani:Animal in currentMap.animalList) {
				_ani.shoot();
				trace("Dog shoot");
			}
			
		}
		
		function updateTime(e:TimerEvent)
		{
			time -=  1;
			board1.me.bar.scaleX = time / 1000;
			
			if (time == 0) {
				gameOver();
			}
			
			player1.shooting = true;
			
		}

		function nextLevel()
		{
			stopGame();
			
			
			if (currentLevel > 0)
			{
				removeLevel();
			}
			
			currentLevel +=  1;
			//trace(gameMap.mapList);
			if (currentLevel > gameMap.mapList.length)
			{
				trace("successed");
				suc = true;
				gameOver();
				createColorfulSnow(500);
				return void;
			}
			currentMap = gameMap.mapList[currentLevel-1];
			loadLevel();
			startGame();
		}
		
		public function replayLevel()
		{//FIX ME
			life -=  1;
			
			stopGame();
			if (currentLevel > 0)
			{
				removeLevel();
			}
			
			//trace(gameMap.mapList);
			currentMap = gameMap.mapList[currentLevel-1];
			loadLevel();
			startGame();
		}

		protected function update(e:Event)
		{
			board1.txtLife.text = String(life);
			
			if (Main.player1.alpha<=0.02) {
				replayLevel();	
			}
			
			if (life<0) {
				gameOver();
			}
			
		    if ((player1.y > 260) || (player1.y < 0) || (player1.x < 0) || (player1.x > 550)) {
				replayLevel();
			}
			Physics.updateP();
			if(CheckUps.checkPlayerBubble(Main.player1,Main.bubble1)){
				trace("SUCCESSED!");
				
				//createColorfulSnow(300);
				//createSnow();
				if (gameRunning==true){
				   nextLevel();
			    }
		    }	
		}

		protected function snow(radius:Number=3):Sprite
		{
			var sp:Sprite=new Sprite();
			var c:uint = 0xFFFFFF;
			sp.graphics.clear();
			sp.graphics.moveTo(0, -radius);
			sp.graphics.beginFill(c, alpha);
			sp.graphics.lineStyle(0,c,0);
			for (var i = 1; i<=6; i++)
			{
				var a1 =  -  Math.PI / 6 + i * Math.PI / 3;
				var a2 = i * Math.PI / 3;
				sp.graphics.lineTo((radius/5)*Math.sin(a1), -(radius/5)*Math.cos(a1));
				sp.graphics.lineTo(radius*Math.sin(a2), -radius*Math.cos(a2));
			}
			sp.x =  Math.random() * 550;
			sp.y =  Math.random() * 400;
			sp.alpha = Math.random()*25+60;
			sp.rotation=Math.random()*1.57;
			//trace(sp);
			
			return sp;
		}
		
        protected function colorfulSnow(radius:Number=3):Sprite
		{
			var sp:Sprite=new Sprite();
			var c:uint = Math.random()*0xFFFFFF;
			sp.graphics.clear();
			sp.graphics.moveTo(0, -radius);
			sp.graphics.beginFill(c, alpha);
			sp.graphics.lineStyle(0,c,0);
			for (var i = 1; i<=6; i++)
			{
				var a1 =  -  Math.PI / 6 + i * Math.PI / 3;
				var a2 = i * Math.PI / 3;
				sp.graphics.lineTo((radius/5)*Math.sin(a1), -(radius/5)*Math.cos(a1));
				sp.graphics.lineTo(radius*Math.sin(a2), -radius*Math.cos(a2));
			}
			sp.x =  Math.random() * 550;
			sp.y =  Math.random() * 400;
			sp.alpha = Math.random()*25+60;
			sp.rotation=Math.random()*1.57;
			//trace(sp);
			
			return sp;
		}
		
		protected function createSnow()
		{
			var r:Number;
			for (var i = 0; i<=40; i++)
			{
				r=Math.random()*3+0.5;
				var s:Sprite=snow(r);
				snows.push(s);
				hintLevel.addChild(s);
			}

		}

		protected function createColorfulSnow(_num:int)
		{
			var r:Number;
			for (var i = 0; i<=_num; i++)
			{
				r=Math.random()*7+0.3;
				var s:Sprite=colorfulSnow(r);
				snows.push(s);
				hintLevel.addChild(s);
			}
		}


		function flySnow(e:Event)
		{
			//trace("function flySnow");
			for (var i = 0; i<snows.length; i++)
			{
				//trace("snow Moving");
				snows[i].x +=  Math.random() * 2;
				snows[i].y +=  Math.random() * 5;
				if (snows[i].x>stage_x){
					snows[i].x-=stage_x;
				}
				if(snows[i].y>stage_y){
					snows[i].y-=stage_y;
				}
			}
		}
	}
}