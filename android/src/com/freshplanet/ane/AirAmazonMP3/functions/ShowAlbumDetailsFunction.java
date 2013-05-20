package com.freshplanet.ane.AirAmazonMP3.functions;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirAmazonMP3.Extension;
import com.freshplanet.ane.AirAmazonMP3.ExtensionContext;

public class ShowAlbumDetailsFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		try
		{
			String albumASIN = args[0].getAsString();
			String autoPlayTrackASIN = args[1] != null ? args[1].getAsString() : null;
			String referrerName = args[2] != null ? args[2].getAsString() : null;
			
			Intent intent = new Intent();
			intent.setAction(ExtensionContext.ACTION_EXTERNAL_EVENT);
			intent.putExtra(ExtensionContext.EXTRA_EXTERNAL_EVENT_TYPE, ExtensionContext.TYPE_SHOW_ALBUM_DETAIL);
			intent.putExtra(ExtensionContext.EXTRA_ALBUM_ASIN, albumASIN);
			
			String logMessage = "Show album details - Album ASIN: " + albumASIN;
			
			if (autoPlayTrackASIN != null)
			{
				intent.putExtra(ExtensionContext.EXTRA_AUTO_PLAY_TRACK_ASIN, autoPlayTrackASIN);
				logMessage += " - Track ASIN: " + autoPlayTrackASIN;
			}
			
			if (referrerName != null)
			{
				intent.putExtra(ExtensionContext.EXTRA_REFERRER_NAME, referrerName);
				logMessage += " - Referrer name: " + referrerName;
			}
			
			context.getActivity().startActivity(intent);
			
			Extension.log(logMessage);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		
		return null;
	}
}
