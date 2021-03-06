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

package com.freshplanet.ane.AirAmazonMP3.functions;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirAmazonMP3.AirAmazonMP3Extension;
import com.freshplanet.ane.AirAmazonMP3.AirAmazonMP3ExtensionContext;

public class ShowAlbumDetailsFunction extends BaseFunction {
	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		super.call(context, args);


		String albumASIN = getStringFromFREObject(args[0]);
		String autoPlayTrackASIN = args[1] != null ? getStringFromFREObject(args[1]) : null;
		String referrerName = args[2] != null ? getStringFromFREObject(args[2]) : null;

		Intent intent = new Intent();
		intent.setAction(AirAmazonMP3ExtensionContext.ACTION_EXTERNAL_EVENT);
		intent.putExtra(AirAmazonMP3ExtensionContext.EXTRA_EXTERNAL_EVENT_TYPE, AirAmazonMP3ExtensionContext.TYPE_SHOW_ALBUM_DETAIL);
		intent.putExtra(AirAmazonMP3ExtensionContext.EXTRA_ALBUM_ASIN, albumASIN);

		String logMessage = "Show album details - Album ASIN: " + albumASIN;

		if (autoPlayTrackASIN != null) {
			intent.putExtra(AirAmazonMP3ExtensionContext.EXTRA_AUTO_PLAY_TRACK_ASIN, autoPlayTrackASIN);
			logMessage += " - Track ASIN: " + autoPlayTrackASIN;
		}

		if (referrerName != null) {
			intent.putExtra(AirAmazonMP3ExtensionContext.EXTRA_REFERRER_NAME, referrerName);
			logMessage += " - Referrer name: " + referrerName;
		}

		context.getActivity().startActivity(intent);

		AirAmazonMP3Extension.log(logMessage);

		
		return null;
	}
}
