package com.freshplanet.ane.AirAmazonMP3.functions;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirAmazonMP3.Extension;
import com.freshplanet.ane.AirAmazonMP3.ExtensionContext;

public class SearchFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		try
		{
			String searchString = args[0].getAsString();
			String referrerName = args[1] != null ? args[1].getAsString() : null;
			
			Intent intent = new Intent();
			intent.setAction(ExtensionContext.ACTION_EXTERNAL_EVENT);
			intent.putExtra(ExtensionContext.EXTRA_EXTERNAL_EVENT_TYPE, ExtensionContext.TYPE_SEARCH);
			intent.putExtra(ExtensionContext.EXTRA_SEARCH_STRING, searchString);
			
			String logMessage = "Search - String: " + searchString;
			
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
