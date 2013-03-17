/*
 * Internal header for the s3eAdColony extension.
 *
 * This file should be used for any common function definitions etc that need to
 * be shared between the platform-dependent and platform-indepdendent parts of
 * this extension.
 */

/*
 * NOTE: This file was originally written by the extension builder, but will not
 * be overwritten (unless --force is specified) and is intended to be modified.
 */


#ifndef S3EADCOLONY_INTERNAL_H
#define S3EADCOLONY_INTERNAL_H

#include "s3eTypes.h"
#include "s3eAdColony.h"
#include "s3eAdColony_autodefs.h"


/**
 * Initialise the extension.  This is called once then the extension is first
 * accessed by s3eregister.  If this function returns S3E_RESULT_ERROR the
 * extension will be reported as not-existing on the device.
 */
s3eResult s3eAdColonyInit();

/**
 * Platform-specific initialisation, implemented on each platform
 */
s3eResult s3eAdColonyInit_platform();

/**
 * Terminate the extension.  This is called once on shutdown, but only if the
 * extension was loader and Init() was successful.
 */
void s3eAdColonyTerminate();

/**
 * Platform-specific termination, implemented on each platform
 */
void s3eAdColonyTerminate_platform();
void s3eAdColonyStart_platform();
void s3ePlayVideoAdForSlot_platform( int slotNumber );
void s3ePlayVideoAdForZone_platform( const char* pszZoneID );
void s3ePlayV4VCForSlot_platform( int slotNumber, s3eBool PrePopup, s3eBool PostPopup );
void s3ePlayV4VCForZone_platform( const char* pszZoneID, s3eBool PrePopup, s3eBool PostPopup );
s3eBool s3eVideoAdCurrentlyRunning_platform();

#endif /* !S3EADCOLONY_INTERNAL_H */