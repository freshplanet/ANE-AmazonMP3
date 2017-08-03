/*
 * Copyright 2017 FreshPlanet
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.freshplanet.ane.AirAmazonMP3 {

	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.Capabilities;

	public class AirAmazonMP3 extends EventDispatcher {

		// --------------------------------------------------------------------------------------//
		//																						 //
		// 									   PUBLIC API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//

		public var logEnabled : Boolean = true;
		public var country : String = "us";

		/** AirAmazonMP3 is supported on Android devices. */
		public static function get isSupported() : Boolean {
			var isAndroid:Boolean = (Capabilities.manufacturer.indexOf("Android") != -1);
			return isAndroid;
		}

		/**
		 * AirAmazonMP3 instance
		 */
		public static function get instance() : AirAmazonMP3 {
			return _instance ? _instance : new AirAmazonMP3();
		}


		/**
		 * Is Amazon Music app installed on device
		 */
		public function get hasAmazonMP3App():Boolean {
			return isSupported ? _context.call("hasAmazonMP3App") as Boolean : false;
		}

		/**
		 * Shows album details
		 * @param albumASIN
		 * @param autoPlayTrackASIN
		 * @param referrerName
		 */
		public function showAlbumDetails(albumASIN:String, autoPlayTrackASIN:String = null, referrerName:String = null):void {

			if (isSupported && albumASIN) {

				if (hasAmazonMP3App) {
					albumASIN = sanitizeASIN(albumASIN);
					autoPlayTrackASIN = sanitizeASIN(autoPlayTrackASIN);

					_context.call("showAlbumDetails", albumASIN, autoPlayTrackASIN, referrerName);
				}
				else {
					var path:String = "/s?url=search-alias=digital-music&field-album="+albumASIN;
					openWebStore(path);
				}
			}
		}

		/**
		 * Shows track details
		 * @param trackASIN
		 * @param referrerName
		 */
		public function showTrackDetails(trackASIN:String, referrerName:String = null):void {

			if (isSupported && trackASIN) {
//				// As of 2013-05-20 there is no intent to show a track detail on the Amazon MP3 application.
				var path:String = "/s?url=search-alias=digital-music-track&field-keywords="+trackASIN;
				openWebStore(path);
			}
		}

		/**
		 * Perform Amazon Music search
		 * @param searchString
		 * @param referrerName
		 */
		public function search(searchString:String, referrerName:String = null):void {
			if (isSupported && searchString) {
				if (hasAmazonMP3App) {
					_context.call("search", searchString, referrerName);
				}
				else {
					var path:String = "/s?url=search-alias=digital-music&field-keywords="+searchString;
					openWebStore(path);
				}
			}
		}

		// --------------------------------------------------------------------------------------//
		//																						 //
		// 									 	PRIVATE API										 //
		// 																						 //
		// --------------------------------------------------------------------------------------//
		
		private static const EXTENSION_ID : String = "com.freshplanet.ane.AirAmazonMP3";
		
		private static var COUNTRY_TO_WEB_STORE : Object = {
			"us": "https://www.amazon.com",
			"gb": "https://www.amazon.co.uk",
			"de": "https://www.amazon.de",
			"fr": "https://www.amazon.fr",
			"es": "https://www.amazon.es",
			"it": "https://www.amazon.it",
			"jp": "http://www.amazon.co.jp"
		};
		
		private static var _instance : AirAmazonMP3 = null;
		private var _context : ExtensionContext = null;

		/**
		 * "private" singleton constructor
		 */
		public function AirAmazonMP3() {
			if (!_instance) {
				_context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
				if (!_context) {
					log("ERROR - Extension context is null. Please check if extension.xml is setup correctly.");
					return;
				}
				_context.addEventListener(StatusEvent.STATUS, onStatus);

				_instance = this;
			}
			else {
				throw Error("This is a singleton, use getInstance(), do not call the constructor directly.");
			}
		}
		
		private function sanitizeASIN(asin:String):String {
			if (asin) {
				return asin.replace(/\W|_/g, "").slice(0, 10);
			}
			else return null;
		}
		
		private function openWebStore(path:String):void {
			// Choose web store (default: us)
			var storeDomain:String = country in COUNTRY_TO_WEB_STORE ? COUNTRY_TO_WEB_STORE[country] : COUNTRY_TO_WEB_STORE["us"];
			navigateToURL(new URLRequest(storeDomain+path));
		}
		
		private function onStatus( event : StatusEvent ) : void {
			if (event.code == "log") { // Simple log message
				log(event.level);
			}
		}
		
		private function log( message : String ) : void {
			if (logEnabled) trace("[AirAmazonMP3] " + message);
		}
	}
}