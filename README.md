Air Native Extension for Amazon MP3 (Android)
======================================

This is an [Air native extensions](http://www.adobe.com/devnet/air/native-extensions-for-air.html) to interact with the Amazon MP3 application on Android. It has been developed by [FreshPlanet](http://freshplanet.com) and is used in the game [SongPop](http://songpop.fm).


Installation
---------

The ANE binary (AirAmazonMP3.ane) is located in the *bin* folder. You should add it to your application project's Build Path and make sure to package it with your app (more information [here](http://help.adobe.com/en_US/air/build/WS597e5dadb9cc1e0253f7d2fc1311b491071-8000.html)).


Usage
-----

	Only two interactions are supported at this time:
	* show album detail
	* search

	If the Amazon MP3 is not installed, it is your responsibility to fallback on the Amazon web store.
    
    ```actionscript
    // Check if the Amazon MP3 app is installed
    var hasAmazonMP3App:Boolean = AirAmazonMP3.getInstance().hasAmazonMP3App;

    if (hasAmazonMP3App)
    {
    	// Show an album detail and autoplay a track
    	AirAmazonMP3.getInstance().showAlbumDetail("SOME_ALBUM_ASIN", "SOME_TRACK_ASIN", "MY_REFERRER_NAME");

    	// Perform a search
    	AirAmazonMP3.getInstance().search("MY_SEARCH_STRING", "MY_REFERRER_NAME");
    }
    ```


Build script
---------

Should you need to edit the extension source code and/or recompile it, you will find an ant build script (build.xml) in the *build* folder:

    cd /path/to/the/ane/build
    mv example.build.config build.config
    #edit the build.config file to provide your machine-specific paths
    ant

Authors
------

This ANE has been written by [Alexis Taugeron](http://alexistaugeron.com). It belongs to [FreshPlanet Inc.](http://freshplanet.com) and is distributed under the [Apache Licence, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).