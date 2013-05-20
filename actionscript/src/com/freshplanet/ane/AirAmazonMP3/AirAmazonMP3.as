//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////

package com.freshplanet.ane.AirAmazonMP3
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class AirAmazonMP3 extends EventDispatcher
	{
		// --------------------------------------------------------------------------------------//
		//																						 //
		// 									   PUBLIC API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		/** AirAmazonMP3 is supported on Android devices. */
		public static function get isSupported() : Boolean
		{
			var isAndroid:Boolean = (Capabilities.manufacturer.indexOf("Android") != -1)
			return isAndroid;
		}
		
		public function AirAmazonMP3()
		{
			if (!_instance)
			{
				_context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				if (!_context)
				{
					log("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
					return;
				}
				_context.addEventListener(StatusEvent.STATUS, onStatus);
				
				_instance = this;
			}
			else
			{
				throw Error("This is a singleton, use getInstance(), do not call the constructor directly.");
			}
		}
		
		public static function getInstance() : AirAmazonMP3
		{
			return _instance ? _instance : new AirAmazonMP3();
		}
		
		public var logEnabled : Boolean = true;
		
		public function get hasAmazonMP3App():Boolean
		{
			return isSupported ? _context.call("hasAmazonMP3App") as Boolean : false;
		}
		
		public function showAlbumDetails(albumASIN:String, autoPlayTrackASIN:String = null, referrerName:String = null):void
		{
			if (isSupported && hasAmazonMP3App && albumASIN)
			{
				_context.call("showAlbumDetails", albumASIN, autoPlayTrackASIN, referrerName);
			}
		}

		public function search(searchString:String, referrerName:String = null):void
		{
			if (isSupported && hasAmazonMP3App && searchString)
			{
				_context.call("search", searchString, referrerName);
			}
		}
		

		
		// --------------------------------------------------------------------------------------//
		//																						 //
		// 									 	PRIVATE API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		private static const EXTENSION_ID : String = "com.freshplanet.AirAmazonMP3";
		
		private static var _instance : AirAmazonMP3;
		
		private var _context : ExtensionContext;
		
		private function onStatus( event : StatusEvent ) : void
		{
			if (event.code == "LOGGING") // Simple log message
			{
				log(event.level);
			}
		}
		
		private function log( message : String ) : void
		{
			if (logEnabled) trace("[AirAmazonMP3] " + message);
		}
	}
}