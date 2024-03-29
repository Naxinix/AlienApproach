package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_9 extends SceneScript
{
	public var _counter:Float;
	public var _lives:Float;
	public var _HitCount:Float;
	public var _frameCounter:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("counter", "_counter");
		_counter = 0.0;
		nameMap.set("lives", "_lives");
		_lives = 0.0;
		nameMap.set("HitCount", "_HitCount");
		_HitCount = 0.0;
		nameMap.set("frameCounter", "_frameCounter");
		_frameCounter = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		stopAllSounds();
		playSound(getSound(68));
		loopSound(getSound(65));
		_counter = 0;
		_frameCounter = 0;
		
		/* =========================== Any Key ============================ */
		addAnyKeyPressedListener(function(event:KeyboardEvent, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				trace(charFromCharCode(event.charCode));
				trace(event.keyCode);
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_counter == 24))
				{
					switchScene(GameModel.get().scenes.get(4).getID(), null, createCrossfadeTransition(1));
				}
			}
		});
		
		/* ======================= Member of Group ======================== */
		addWhenTypeGroupKilledListener(getActorGroup(4), function(eventActor:Actor, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_counter += 1;
			}
		});
		
		/* ========================= Type & Type ========================== */
		addSceneCollisionListener(getActorType(1).ID, getActorType(42).ID, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_frameCounter = (_frameCounter + 1);
				getActor(30).setAnimation("" + _frameCounter);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}