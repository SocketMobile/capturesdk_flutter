#!/usr/bin/python
import sys
import imp
import filecmp
import os

def main(projectDir):
    print('testing python scripts')

    # device types
    createDeviceTypes.main(['', 'csharp', projectDir + '../deviceTypes.json', projectDir + 'deviceTypesTemplate.cs', projectDir + 'build/resultdevicetypes.cs', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdevicetypes.cs', projectDir + 'resultdevicetypescompare.cs') == False:
        print('ERROR: createDeviceTypes for CSharp does not match with the expected result')
        exit(-1)

    createDeviceTypes.main(['', 'c', projectDir + '../deviceTypes.json', projectDir + 'deviceTypesTemplate.h', projectDir + 'build/resultdevicetypes.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdevicetypes.h', projectDir + 'resultdevicetypescompare.h') == False:
        print('ERROR: createDeviceTypes for C does not match with the expected result')
        exit(-1)

    createDeviceTypes.main(['', 'ObjectiveC', projectDir + '../deviceTypes.json', projectDir + 'deviceTypesTemplateObjc.h', projectDir + 'build/resultdevicetypesobjc.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdevicetypesobjc.h', projectDir + 'resultdevicetypesobjccompare.h') == False:
        print('ERROR: createDeviceTypes for ObjectiveC does not match with the expected result')
        exit(-1)

    createDeviceTypes.main(['', 'Typescript', projectDir + '../deviceTypes.json', projectDir + 'deviceTypesTemplate.ts', projectDir + 'build/resultdevicetypes.ts', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdevicetypes.ts', projectDir + 'resultdevicetypescompare.ts') == False:
        print('ERROR: createDeviceTypes for Typescript does not match with the expected result')
        exit(-1)

    createDeviceTypes.main(['', 'Dart', projectDir + '../deviceTypes.json', projectDir + 'device_types_template.dart', projectDir + 'build/resultdevicetypes.dart', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdevicetypes.dart', projectDir + 'resultdevicetypescompare.dart') == False:
        print('ERROR: createDeviceTypes for Dart does not match with the expected result')
        exit(-1)

    # property
    createPropertyIds.main(['', 'csharp', projectDir + '../propertyIDs.json', projectDir + 'propertiesTemplate.cs', projectDir + 'build/resultproperties.cs', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultproperties.cs', projectDir + 'resultpropertiescompare.cs') == False:
        print('ERROR: createPropertyIds for CSharp does not match with the expected result')
        exit(-1)

    createPropertyIds.main(['', 'c', projectDir + '../propertyIDs.json', projectDir + 'propertiesTemplate.h', projectDir + 'build/resultproperties.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultproperties.h', projectDir + 'resultpropertiescompare.h') == False:
        print('ERROR: createPropertyIds for C does not match with the expected result')
        exit(-1)

    createPropertyIds.main(['', 'ObjectiveC', projectDir + '../propertyIDs.json', projectDir + 'propertiesTemplateObjc.h', projectDir + 'build/resultpropertiesobjc.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultpropertiesobjc.h', projectDir + 'resultpropertiesobjccompare.h') == False:
        print('ERROR: createPropertyIds for ObjectiveC does not match with the expected result')
        exit(-1)

    createPropertyIds.main(['', 'typescript', projectDir + '../propertyIDs.json', projectDir + 'propertiesTemplate.ts', projectDir + 'build/resultproperties.ts', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultproperties.ts', projectDir + 'resultpropertiescompare.ts') == False:
        print('ERROR: createPropertyIds for Typescript does not match with the expected result')
        exit(-1)

    createPropertyIds.main(['', 'dart', projectDir + '../propertyIDs.json', projectDir + 'properties_template.dart', projectDir + 'build/resultproperties.dart', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultproperties.dart', projectDir + 'resultpropertiescompare.dart') == False:
        print('ERROR: createPropertyIds for Dart does not match with the expected result')
        exit(-1)

    # errors
    createErrors.main(['', 'csharp', projectDir + '../errors.json', projectDir + 'errorsTemplate.cs', projectDir + 'build/resulterrors.cs', 'ble'])
    if filecmp.cmp(projectDir + 'build/resulterrors.cs', projectDir + 'resulterrorscompare.cs') == False:
        print('ERROR: createErrors for CSharp does not match with the expected result')
        exit(-1)

    createErrors.main(['', 'c', projectDir + '../errors.json', projectDir + 'errorsTemplate.h', projectDir + 'build/resulterrors.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultproperties.h', projectDir + 'resultpropertiescompare.h') == False:
        print('ERROR: createErrors for C does not match with the expected result')
        exit(-1)

    createErrors.main(['', 'ObjectiveC', projectDir + '../errors.json', projectDir + 'errorsTemplateObjc.h', projectDir + 'build/resulterrorsobjc.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resulterrorsobjc.h', projectDir + 'resulterrorsobjccompare.h') == False:
        print('ERROR: createErrors for ObjectiveC does not match with the expected result')
        exit(-1)

    createErrors.main(['', 'typescript', projectDir + '../errors.json', projectDir + 'errorsTemplate.ts', projectDir + 'build/resulterrors.ts', 'ble'])
    if filecmp.cmp(projectDir + 'build/resulterrors.ts', projectDir + 'resulterrorscompare.ts') == False:
        print('ERROR: createErrors for Typescript does not match with the expected result')
        exit(-1)
    
    createErrors.main(['', 'Dart', projectDir + '../errors.json', projectDir + 'errors_template.dart', projectDir + 'build/resulterrors.dart', 'ble'])
    if filecmp.cmp(projectDir + 'build/resulterrors.dart', projectDir + 'resulterrorscompare.dart') == False:
        print('ERROR: createErrors for Dart does not match with the expected result')
        exit(-1)

    # data sources
    createDataSources.main(['', 'csharp', projectDir + '../dataSourceIds.json', projectDir + 'dataSourcesTemplate.cs', projectDir + 'build/resultdatasources.cs', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdatasources.cs', projectDir + 'resultdatasourcescompare.cs') == False:
        print('ERROR: createDataSources for CSharp does not match with the expected result')
        exit(-1)

    createDataSources.main(['', 'c', projectDir + '../dataSourceIds.json', projectDir + 'dataSourcesTemplate.h', projectDir + 'build/resultdatasources.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdatasources.h', projectDir + 'resultdatasourcescompare.h') == False:
        print('ERROR: createDataSources for C does not match with the expected result')
        exit(-1)

    createDataSources.main(['', 'ObjectiveC', projectDir + '../dataSourceIds.json', projectDir + 'dataSourcesObjCTemplate.h', projectDir + 'build/resultdatasourcesobjc.h', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdatasourcesobjc.h', projectDir + 'resultdatasourcesobjccompare.h') == False:
        print('ERROR: createDataSources for ObjectiveC does not match with the expected result')
        exit(-1)

    createDataSources.main(['', 'Typescript', projectDir + '../dataSourceIds.json', projectDir + 'dataSourcesTemplate.ts', projectDir + 'build/resultdatasources.ts', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdatasources.ts', projectDir + 'resultdatasourcescompare.ts') == False:
        print('ERROR: createDataSources for Typescript does not match with the expected result')
        exit(-1)

    createDataSources.main(['', 'Dart', projectDir + '../dataSourceIds.json', projectDir + 'datasources_template.dart', projectDir + 'build/resultdatasources.dart', 'ble'])
    if filecmp.cmp(projectDir + 'build/resultdatasources.dart', projectDir + 'resultdatasourcescompare.dart') == False:
        print('ERROR: createDataSources for Dart does not match with the expected result')
        exit(-1)

    # events
    createEventIds.main(['', 'csharp', projectDir + '../eventIDs.json', projectDir + 'eventsTemplate.cs', projectDir + 'build/resultevents.cs', 'pcsc'])
    if filecmp.cmp(projectDir + 'build/resultevents.cs', projectDir + 'resulteventscompare.cs') == False:
        print('ERROR: createEventIds for CSharp does not match with the expected result')
        exit(-1)

    createEventIds.main(['', 'c', projectDir + '../eventIDs.json', projectDir + 'eventsTemplate.h', projectDir + 'build/resultevents.h', 'pcsc'])
    if filecmp.cmp(projectDir + 'build/resultevents.h', projectDir + 'resulteventscompare.h') == False:
        print('ERROR: createEventIds for C does not match with the expected result')
        exit(-1)

    createEventIds.main(['', 'ObjectiveC', projectDir + '../eventIDs.json', projectDir + 'eventsTemplateObjc.h', projectDir + 'build/resulteventsobjc.h', 'pcsc'])
    if filecmp.cmp(projectDir + 'build/resulteventsobjc.h', projectDir + 'resulteventsobjccompare.h') == False:
        print('ERROR: createEventIds for ObjectiveC does not match with the expected result')
        exit(-1)

    createEventIds.main(['', 'typescript', projectDir + '../eventIDs.json', projectDir + 'eventsTemplate.ts', projectDir + 'build/resultevents.ts', 'pcsc'])
    if filecmp.cmp(projectDir + 'build/resultevents.ts', projectDir + 'resulteventscompare.ts') == False:
        print('ERROR: createEventIds for Typescript does not match with the expected result')
        exit(-1)

    createEventIds.main(['', 'dart', projectDir + '../eventIDs.json', projectDir + 'events_template.dart', projectDir + 'build/resultevents.dart', 'pcsc'])
    if filecmp.cmp(projectDir + 'build/resultevents.dart', projectDir + 'resulteventscompare.dart') == False:
        print('ERROR: createEventIds for Dart does not match with the expected result')
        exit(-1)

    exit(0)

if __name__ == '__main__':
    path = sys.argv[0]
    path = os.path.dirname(path)
    createDeviceTypes = imp.load_source('d', path + '/../buildscripts/createDeviceTypes.py')
    createPropertyIds = imp.load_source('p', path + '/../buildscripts/createPropertyIds.py')
    createErrors = imp.load_source('e', path + '/../buildscripts/createErrors.py')
    createDataSources = imp.load_source('ds', path + '/../buildscripts/createDataSources.py')
    createEventIds = imp.load_source('ev', path + '/../buildscripts/createEventIds.py')

    main(path + '/')
