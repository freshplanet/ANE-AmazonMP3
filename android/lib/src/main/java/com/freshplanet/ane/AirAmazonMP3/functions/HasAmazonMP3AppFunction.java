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

import android.content.pm.PackageManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;

public class HasAmazonMP3AppFunction extends BaseFunction {
	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		super.call(context, args);

		PackageManager packageManager = context.getActivity().getPackageManager();
		
		Boolean hasAmazonMP3App = false;
		try {
			packageManager.getPackageInfo("com.amazon.mp3", PackageManager.GET_ACTIVITIES);
			hasAmazonMP3App = true;
		}
		catch (PackageManager.NameNotFoundException e) {
			hasAmazonMP3App = false;
		}
		
		try {
			return FREObject.newObject(hasAmazonMP3App);
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
