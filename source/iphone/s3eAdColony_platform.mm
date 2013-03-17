/*
 * iphone-specific implementation of the s3eAdColony extension.
 * Add any platform-specific functionality here.
 */
/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */
 
#include "s3eAdColony_internal.h"
#include "s3eEdk.h"
#include "AdColonyPublic.h"

@interface AdColonyDelegateBridge : NSObject<AdColonyDelegate>

- ( NSString * ) adColonyApplicationID;
- ( NSDictionary * ) adColonyAdZoneNumberAssociation;
- ( NSString * ) adColonyLoggingStatus;
- ( void ) adColonyVirtualCurrencyAwardedByZone:( NSString * )zone currencyName:( NSString * )name currencyAmount:( int )amount;

@end

@implementation AdColonyDelegateBridge

- ( NSString * ) adColonyApplicationID
{
	return @"INSERT YOUR ADCOLONY APPID HERE";
}

- ( NSDictionary * ) adColonyAdZoneNumberAssociation
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
		@"INSERT YOUR ZONE ID HERE", [NSNumber numberWithInt:1],
		nil];
}

- ( NSString * ) adColonyLoggingStatus
{
	// Use AdColonyLoggingOn to activate the logging
    return AdColonyLoggingOff;
}

- ( void ) adColonyVirtualCurrencyAwardedByZone:( NSString * )zone currencyName:( NSString * )name currencyAmount:( int )amount
{
	// Using the client-side currency ads implementation 
    s3eEdkCallbacksEnqueue( S3E_EXT_ADCOLONY_HASH, S3E_ADCOLONY_VIRTUAL_CURRENCY_AWARDED_BY_ZONE, &amount, sizeof( int ) );
}

@end

@interface AdColonyTakeoverAdDelegateBridge : NSObject<AdColonyTakeoverAdDelegate>

- ( void ) adColonyTakeoverBeganForZone:( NSString * )zone;
- ( void ) adColonyTakeoverEndedForZone:( NSString * )zone withVC:( BOOL )withVirtualCurrencyAward;
- ( void ) adColonyVideoAdNotServedForZone:( NSString * )zone;

@end

@implementation AdColonyTakeoverAdDelegateBridge

- ( void ) adColonyTakeoverBeganForZone:( NSString * )zone
{
    s3eEdkCallbacksEnqueue( S3E_EXT_ADCOLONY_HASH, S3E_ADCOLONY_TAKEOVER_BEGAN_FOR_ZONE );
}

- ( void ) adColonyTakeoverEndedForZone:( NSString * )zone withVC:( BOOL )withVirtualCurrencyAward
{
    s3eEdkCallbacksEnqueue( S3E_EXT_ADCOLONY_HASH, S3E_ADCOLONY_TAKEOVER_ENDED_FOR_ZONE );
}

- ( void ) adColonyVideoAdNotServedForZone:( NSString * )zone
{
    s3eEdkCallbacksEnqueue( S3E_EXT_ADCOLONY_HASH, S3E_ADCOLONY_TAKEOVER_NOT_SERVED_FOR_ZONE );
}

@end

static AdColonyDelegateBridge*           g_AdColonyDelegate           = NULL;
static AdColonyTakeoverAdDelegateBridge* g_AdColonyTakeoverAdDelegate = NULL;

s3eResult s3eAdColonyInit_platform()
{
    g_AdColonyDelegate = [[AdColonyDelegateBridge alloc] init];
    
    if ( !g_AdColonyDelegate )
    {
        return S3E_RESULT_ERROR;
    }
	
	g_AdColonyTakeoverAdDelegate = [[AdColonyTakeoverAdDelegateBridge alloc] init];

	if ( !g_AdColonyTakeoverAdDelegate )
    {
		[g_AdColonyDelegate release];
		g_AdColonyDelegate = NULL;

        return S3E_RESULT_ERROR;
    }

    return S3E_RESULT_SUCCESS;
}

void s3eAdColonyTerminate_platform()
{
    if ( !g_AdColonyDelegate )
    {
        return;
    }
	
	if ( !g_AdColonyTakeoverAdDelegate )
    {
		[g_AdColonyDelegate release];
		g_AdColonyDelegate = NULL;

        return;
    }
    
    [g_AdColonyDelegate release];
    g_AdColonyDelegate = NULL;

	[g_AdColonyTakeoverAdDelegate release];
    g_AdColonyTakeoverAdDelegate = NULL;
}

void s3eAdColonyStart_platform()
{
	[AdColony initAdColonyWithDelegate:g_AdColonyDelegate];
}

void s3ePlayVideoAdForSlot_platform( int slotNumber )
{
    [AdColony playVideoAdForSlot:slotNumber withDelegate:g_AdColonyTakeoverAdDelegate];
}

void s3ePlayVideoAdForZone_platform( const char* pszZoneID )
{
    [AdColony playVideoAdForZone:[NSString stringWithUTF8String:pszZoneID] withDelegate:g_AdColonyTakeoverAdDelegate];
}

void s3ePlayV4VCForSlot_platform( int slotNumber, s3eBool PrePopup, s3eBool PostPopup )
{
	[AdColony playVideoAdForSlot:slotNumber withDelegate:g_AdColonyTakeoverAdDelegate withV4VCPrePopup:PrePopup andV4VCPostPopup:PostPopup];
}

void s3ePlayV4VCForZone_platform( const char* pszZoneID, s3eBool PrePopup, s3eBool PostPopup )
{
	[AdColony playVideoAdForZone:[NSString stringWithUTF8String:pszZoneID] withDelegate:g_AdColonyTakeoverAdDelegate withV4VCPrePopup:PrePopup andV4VCPostPopup:PostPopup];
}

s3eBool s3eVideoAdCurrentlyRunning_platform()
{
	return [AdColony videoAdCurrentlyRunning];
}