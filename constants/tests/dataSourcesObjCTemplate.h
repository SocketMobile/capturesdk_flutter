/**
  @file SktCaptureDataSource.h
  @brief Define the Data Source object in Capture

  @copyright © 2022 Socket Mobile, Inc.

 */

#ifndef SktCaptureDataSource_h
#define SktCaptureDataSource_h

/**

 @brief idenfity a barcode symbology or a RFID/NFC Tag

 */
$DATASOURCES$

/**

 @brief define the data source status

 */
$DATASOURCESSTATUS$

/**

 @brief define the flag value of a data source structure

 */
$DATASOURCESFLAGS$

/**
 @class SKTCaptureDataSource

 @brief define a data source which has an ID, a name and a status. The flag is set to
 status because for now that is the only parameter the data source can have
 */
@interface SKTCaptureDataSource : NSObject

/**
 Get or Set the Data Source ID
 */
@property SKTCaptureDataSourceID ID;

/**
 contain the data source name
 */
@property (nullable, nonatomic, strong) NSString* Name;

/**
 contain the data source status (enabled or disable or not supported)
 */
@property SKTCaptureDataSourceStatus Status;

/**
 contain the flag that defines the data source argument, today always set to status
 */
@property SKTCaptureDataSourceFlags Flags;
@end
#endif /* SktCaptureDataSource_h */
