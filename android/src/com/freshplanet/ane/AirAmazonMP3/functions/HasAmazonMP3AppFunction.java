package com.freshplanet.ane.AirAmazonMP3.functions;

import android.content.pm.PackageManager;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

public class HasAmazonMP3AppFunction implements FREFunction
{
	@Override
	public FREObject call(FREContext context, FREObject[] args)
	{
		PackageManager packageManager = context.getActivity().getPackageManager();
		
		Boolean hasAmazonMP3App = false;
		try
		{
			packageManager.getPackageInfo("com.amazon.mp3", PackageManager.GET_ACTIVITIES);
			hasAmazonMP3App = true;
		}
		catch (PackageManager.NameNotFoundException e)
		{
			hasAmazonMP3App = false;
		}
		
		try
		{
			return FREObject.newObject(hasAmazonMP3App);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
}
