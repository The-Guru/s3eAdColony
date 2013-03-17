/*
Generic implementation of the s3eAdColony extension.
This file should perform any platform-indepedentent functionality
(e.g. error checking) before calling platform-dependent implementations.
*/

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#include "s3eAdColony_internal.h"
s3eResult s3eAdColonyInit()
{
    //Add any generic initialisation code here
    return s3eAdColonyInit_platform();
}

void s3eAdColonyTerminate()
{
    //Add any generic termination code here
    s3eAdColonyTerminate_platform();
}

void s3eAdColonyStart()
{
	s3eAdColonyStart_platform();
}

void s3ePlayVideoAdForSlot( int slotNumber )
{
    s3ePlayVideoAdForSlot_platform( slotNumber );
}

void s3ePlayVideoAdForZone( const char* pszZoneID )
{
    s3ePlayVideoAdForZone_platform( pszZoneID );
}

void s3ePlayV4VCForSlot( int slotNumber, s3eBool PrePopup, s3eBool PostPopup )
{
  s3ePlayV4VCForSlot_platform( slotNumber, PrePopup, PostPopup );
}

void s3ePlayV4VCForZone( const char* pszZoneID, s3eBool PrePopup, s3eBool PostPopup )
{
  s3ePlayV4VCForZone_platform( pszZoneID, PrePopup, PostPopup );
}

s3eBool s3eVideoAdCurrentlyRunning()
{
  return s3eVideoAdCurrentlyRunning_platform();
}