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

package com.freshplanet.ane.AirAmazonMP3;

import java.util.HashMap;
import java.util.Map;

import android.view.ViewGroup;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.freshplanet.ane.AirAmazonMP3.functions.HasAmazonMP3AppFunction;
import com.freshplanet.ane.AirAmazonMP3.functions.SearchFunction;
import com.freshplanet.ane.AirAmazonMP3.functions.ShowAlbumDetailsFunction;

public class ExtensionContext extends FREContext
{
	public static final String ACTION_EXTERNAL_EVENT = "com.amazon.mp3.action.EXTERNAL_EVENT";
	public static final String TYPE_SHOW_ALBUM_DETAIL = "com.amazon.mp3.type.SHOW_ALBUM_DETAIL";
	public static final String TYPE_SEARCH = "com.amazon.mp3.type.SEARCH";
	public static final String EXTRA_EXTERNAL_EVENT_TYPE = "com.amazon.mp3.extra.EXTERNAL_EVENT_TYPE";
	public static final String EXTRA_ALBUM_ASIN = "com.amazon.mp3.extra.ALBUM_ASIN";
	public static final String EXTRA_TRACK_ASIN = "com.amazon.mp3.extra.TRACK_ASIN";
	public static final String EXTRA_AUTO_PLAY_TRACK_ASIN = "com.amazon.mp3.extra.AUTO_PLAY_TRACK_ASIN";
	public static final String EXTRA_SEARCH_STRING = "com.amazon.mp3.extra.SEARCH_STRING";
	public static final String EXTRA_SEARCH_TYPE = "com.amazon.mp3.extra.SEARCH_TYPE";
	public static final String EXTRA_REFERRER_NAME = "com.amazon.mp3.extra.REFERRER_NAME";
	
	@Override
	public void dispose() {}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		
		functions.put("hasAmazonMP3App", new HasAmazonMP3AppFunction());
		functions.put("showAlbumDetails", new ShowAlbumDetailsFunction());
		functions.put("search", new SearchFunction());
		
		return functions;
	}
	
	public ViewGroup getRootContainer()
	{
		return (ViewGroup)((ViewGroup)getActivity().findViewById(android.R.id.content)).getChildAt(0);
	}
}
