s3eAdColony
===========

Marmalade EDK extension for using AdColony 2.0.1.32 in iOS devices.

In order to use this extension you have to be registered at http://adcolony.com/

Because the adColonyApplicationID and the ZoneIDs are embedded in the extension,
you will have to compile the extension with your own adColonyApplicationID and ZoneIDs.

You can find a .pdf file about how AdColony works at https://github.com/AdColony/AdColony-iOS-SDK

This extension has been compiled and tested with the Marmalade SDK 6.2.1

How to use it
=============

+ Check extension availability

	bool extensionAvailable = ( s3eAdColonyAvailable() == S3E_TRUE );

+ Register callbacks

	s3eAdColonyRegister( S3E_ADCOLONY_VIRTUAL_CURRENCY_AWARDED_BY_ZONE,
      VirtualCurrencyAwardedByZoneCallback, NULL );

    s3eAdColonyRegister( S3E_ADCOLONY_TAKEOVER_BEGAN_FOR_ZONE,
      TakeoverBeganForZoneCallback, NULL );

    s3eAdColonyRegister( S3E_ADCOLONY_TAKEOVER_ENDED_FOR_ZONE,
      TakeoverEndedForZoneCallback, NULL );

    s3eAdColonyRegister( S3E_ADCOLONY_TAKEOVER_NOT_SERVED_FOR_ZONE,
      TakeoverNotServedForZoneCallback, NULL );
	  
The callbacks registered must have this signature:

  int32 CallbackName( void* systemData, void* userData );

+ Init the extension

	s3eAdColonyStart();

+ Play AdColony videos

	s3ePlayVideoAdForSlot( 1 );
	s3ePlayV4VCForSlot( 1, S3E_FALSE, S3E_TRUE );
	
AdColony will call the callbacks registered when playing videos. So for instance,
when the video begins the callback registered under S3E_ADCOLONY_TAKEOVER_BEGAN_FOR_ZONE
will be called and you should pause your game music/fx. After the video has been played the
callback registered under S3E_ADCOLONY_TAKEOVER_ENDED_FOR_ZONE will be called and you should
restore your game music/fx.

+ Unregister callbacks

	s3eAdColonyUnRegister( S3E_ADCOLONY_VIRTUAL_CURRENCY_AWARDED_BY_ZONE,
      VirtualCurrencyAwardedByZoneCallback );

    s3eAdColonyUnRegister( S3E_ADCOLONY_TAKEOVER_BEGAN_FOR_ZONE,
      TakeoverBeganForZoneCallback );

    s3eAdColonyUnRegister( S3E_ADCOLONY_TAKEOVER_ENDED_FOR_ZONE,
      TakeoverEndedForZoneCallback );

    s3eAdColonyUnRegister( S3E_ADCOLONY_TAKEOVER_NOT_SERVED_FOR_ZONE,
      TakeoverNotServedForZoneCallback );