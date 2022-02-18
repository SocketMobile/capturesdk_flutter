# createEventIds.py
# Python script to transform the JSON Event IDs to
# header file
#
# Just add the tag $EVENTIDS$ in your template file
# and this script will replace this tag with all the
# events found in the eventIDs.json file
#
#
#  The only option supported is ObjectiveC to import
#  the properties in a header file designed for ObjectiveC
#
# (c) 2022 Copyright Socket Mobile, Inc.
import sys
import json
import re # regular expression
import os
import subprocess
import tempfile

def getValue(jsonObject, Type, typeString):
    for t in jsonObject[Type]:
        if typeString == t:
            return jsonObject[Type][t]['value']
    return 0

# const long kSktCapturePropIdFriendlyNameDevice = SKTPROPIDCAPTURE(0) | SKTGETTYPE(kSktCapturePropTypeNone) | SKTSETTYPE(kSktCapturePropTypeString) | SKTSETGROUPID(kSktCaptureGroupLocalFunctions) | SKTSETPROPID(kSktCaptureIdDeviceFriendlyName);
def getEventValue(p):
    value = p['int32']
    return value

def getTypeValue(jsonObject, p):
    value = getValue(jsonObject,"Types", p)
    return value

def getGitBranch():
    pipe = subprocess.Popen(['git', 'branch'], stdout = subprocess.PIPE)
    testb, err = pipe.communicate()
    pipe.stdout.close()
    test = testb.decode('utf-8')
    test = re.sub(r'[\n\r]','?', test)
    test = re.sub(r'[\t ]','', test)
    test = test.strip()
    test = test.split('?')
    subs = '*'
    branch = [i for i in test if subs in i][0]
    branch = branch.lower()
    branch = re.sub('^\*', '', branch)
    return branch.strip()

def checkIfBranchMatches(p, branch):
    add = True
    if 'branch' in p:
        br = p['branch']
        br = br.lower()
        add = branch in br
    return add

def createEventIdsFileForC(jsonObject, includeDeprecated, branch):
    eventIds = "// Event Types\n"
    eventIds +='enum ESktEventDataType {\n'
    for t in jsonObject['Types']:
        name = t
        name = name[1:]
        typeObj = jsonObject['Types'][t]
        value = typeObj['value']
        for hlp in typeObj['help']:
            eventIds += '\t/// {0}\n'.format(hlp)
        eventIds += '\tkSktCaptureEventDataType{0} = {1},\n'.format(name, value)
    eventIds +='};\n'

    eventIds += "\n\n// Events\n"
    eventIds +='enum ESktCaptureEventID {\n'
    for ev in jsonObject['Events']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        value = ev['int32']
        typeName = ev['Type']
        name = ev['Name'][1:]
        print("kSktCaptureEventId" + name)
        for hlp in ev['help']:
            eventIds += '\t/// {0}\n'.format(hlp)
        eventIds += '\tkSktCaptureEventId{0} = {1}, // Type: {2}\n'.format(name, value, typeName)
    eventIds +='};\n'

    return eventIds

def createEventIdsFileForH(jsonObject, includeDeprecated, branch):
    return createEventIdsFileForC(jsonObject, includeDeprecated, branch)

def createEventIdsFileForCSharp(jsonObject, includeDeprecated, branch):
    tabs = "\t\t\t"
    eventIds = "{0}/// <summary>\n".format(tabs)
    eventIds += "{0}/// defines the event value type. Events can have value of different\n".format(tabs)
    eventIds += "{0}/// type or no value at all.\n".format(tabs)
    eventIds += "{0}/// </summary>\n".format(tabs)
    eventIds += "{0}public class DataTypes {{\n".format(tabs)
    for t in jsonObject['Types']:
        typeString = '{0}\t/// <summary>\n'.format(tabs)
        for hlp in jsonObject['Types'][t]['help']:
            typeString += '{0}\t/// {1}\n'.format(tabs, hlp)
        typeString += '{0}\t/// </summary>\n{0}\tpublic const int {1} = {2};\n\n'.format(tabs, t, jsonObject['Types'][t]['value'])
        eventIds += typeString
    eventIds += "{0}}};\n\n".format(tabs)

    eventIds += "\n\n"
    eventIds += "{0}/// <summary>\n".format(tabs)
    eventIds += "{0}/// defines the event IDs used in Capture\n".format(tabs)
    eventIds += "{0}/// </summary>\n".format(tabs)
    eventIds += "{0}public class Id\n".format(tabs)
    eventIds += "{0}{{\n".format(tabs)
    for ev in jsonObject['Events']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        print(ev['Name'])
        value = getEventValue(ev)
        eventIds +="{0}\t/// <summary>\n".format(tabs)
        for hlp in ev['help']:
            eventIds +='{0}\t/// {1}\n'.format(tabs, hlp)
        eventIds +="{0}\t/// </summary>\n".format(tabs)
        eventIds += '{0}\tpublic const int {1} = {2};\t\t// Type: {3}\n\n'.format(tabs, ev['Name'], value, ev['Type'])
    eventIds+='{0}}};\n\n'.format(tabs)

    return eventIds

def createEventIdsFileForObjectiveC(jsonObject, includeDeprecated, branch):
    eventIds = "typedef NS_ENUM(NSInteger, SKTCaptureEventDataType) {\n"
    for t in jsonObject['Types']:
        typeObj = jsonObject['Types'][t]
        name = t
        name = name[1:]
        name = "SKTCaptureEventDataType" + name
        value = typeObj['value']
        eventIds +="\t/**\n"
        for hlp in typeObj['help']:
            eventIds +='\t{0}\n'.format(hlp)
        eventIds +="\t*/\n"
        eventIds += '\t{0} = {1},\n\n'.format(name, value)
    eventIds += "};\n\n"

    eventIds += "typedef NS_ENUM(NSInteger, SKTCaptureEventID) {\n"
    for ev in jsonObject['Events']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        name = ev['Name']
        name = name[1:]
        name = "SKTCaptureEventID" + name
        print(name)
        value = getEventValue(ev)
        eventIds +="\t/**\n"
        for hlp in ev['help']:
            eventIds +='\t{0}\n'.format(hlp)
        eventIds +='\n\tType: {0}\n'.format(ev['Type'])
        eventIds +="\t*/\n"
        eventIds += '\t{0} = {1},\n\n'.format(name, value)
    eventIds += "};\n"
    return eventIds

def addValues(name, valueObject, jsonObject, includeDeprecaded, branch, isDart=False):
    value = ""
    for p in valueObject['Value']:
        name = lowercaseHelper(p['Name'], True) if isDart else p['Name']
        val = p['Value']
        if includeDeprecaded == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        for hlp in p['help']:
            value +='\n\t// {0}'.format(hlp)
        #need to add support for Dart as well - different syntax
        intOrNah = 'int ' if isDart else ''
        semiOrcomma = ';' if isDart else ','
        value += '\n\t' + intOrNah + '{0} = {1}'.format(name, val) + semiOrcomma
        
    if not isDart:
        value = value[:-1] # remove the last coma
    value += '\n\n' if isDart else '\n'
    return value

def createEventValuesForTypeScript(jsonObject, includeDeprecated, branch):
    values = ""
    for ev in jsonObject['Values']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        name = ev['Name']
        print("TYPESCRIPT: " + ev['Name'])
        for hlp in ev['help']:
            values +='// {0}\n'.format(hlp)
        values += 'export enum {0} {{\n'.format(name)
        values += addValues(name, ev, jsonObject, includeDeprecated, branch)
        values += '};\n\n'
    return values

def createEventValuesForDart(jsonObject, includeDeprecated, branch):
    values = ""
    for ev in jsonObject['Values']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        name = ev['Name']
        for hlp in ev['help']:
            values +='// {0}\n'.format(hlp)
        values += 'class {0} {{\n'.format(name)
        values += addValues(name, ev, jsonObject, includeDeprecated, branch, True)
        values += '}\n\n'
    return values

def createEventIdsFileForTypescript(jsonObject, includeDeprecated, branch):
    eventIds = "export enum Event {\n"
    for ev in jsonObject['Events']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        name = ev['Name']
        name = name[1:]
        # name = "SKTCaptureEventID" + name
        print(name)
        value = getEventValue(ev)
        for hlp in ev['help']:
            eventIds +='\t// {0}\n'.format(hlp)
        eventIds +='\t// Type: {0}\n'.format(ev['Type'])
        eventIds += '\t{0} = {1},\n\n'.format(name, value)
    eventIds += "};\n\n"
    types = "export enum Types {\n"
    for tp in jsonObject['Types']:
        typeObj = jsonObject['Types'][tp]
        if includeDeprecated == False:
            if 'Deprecated' in tp and tp['Deprecated'] == True:
                continue
        if checkIfBranchMatches(tp, branch) == False:
            continue
        name = tp
        name = name[1:]
        print(name)
        value = typeObj['value']
        for hlp in typeObj['help']:
            types +='\t// {0}\n'.format(hlp)
        types += '\t{0} = {1},\n\n'.format(name, value)
    types += "};\n"
    eventIds += types

    return eventIds

def lowercaseHelper(name, isFromValues=False):
    newName = list(name[0:] if isFromValues else name[1:])
    newName[0] = newName[0].lower()
    newName = ''.join(newName)
    return newName

def createEventIdsFileForDart(jsonObject, includeDeprecated, branch):
    final = ''
    eventIds = "class CaptureEventIds {\n\n"
    for ev in jsonObject['Events']:
        if includeDeprecated == False:
            if 'Deprecated' in ev and ev['Deprecated'] == True:
                continue
        if checkIfBranchMatches(ev, branch) == False:
            continue
        name = ev['Name']
        name = lowercaseHelper(name)
        # name = "SKTCapturePropertyID" + name
        print(name)
        value = getEventValue(ev)
        for hlp in ev['help']:
            eventIds +='\t// {0}\n'.format(hlp)
        eventIds +='\t// Type: {0}\n'.format(ev['Type'])
        eventIds += '\tint {0} = {1};\n\n'.format(name, value)
    eventIds += '\tCaptureEventIds();\n\n'
    eventIds += '}\n\n'
    final += eventIds

    types = "class CaptureEventTypes { \n\n"

    for tp in jsonObject['Types']:
        typeObj = jsonObject['Types'][tp]
        if includeDeprecated == False:
            if 'Deprecated' in tp and tp['Deprecated'] == True:
                continue
        if checkIfBranchMatches(tp, branch) == False:
            continue
        name = tp
        name = lowercaseHelper(name) if lowercaseHelper(name) != 'enum' else name[1:]
        print(name)
        value = typeObj['value']
        for hlp in typeObj['help']:
            types +='\t// {0}\n'.format(hlp)
        types += '\tint {0} = {1};\n\n'.format(name, value)
    types += '\tCaptureEventTypes();\n\n'
    types += '}\n\n'

    final += types

    return final

def replaceTemplateContentWithEventIds(targetTemplate, target, eventIds, eventIdsDeprecated):
    with open(targetTemplate,'r') as src:
        trg = open(target,'w')
        lines = src.readlines()
        for line in lines:
            line = re.sub(r'\$EVENTIDS\$',eventIds,line)
            line = re.sub(r'\$EVENTIDSDEPRECATED\$',eventIdsDeprecated,line)
            trg.write(line)
        trg.close()

# remove the comments from a line
def removeComment(comment, inside):
    star = False
    slash = False
    final = ''
    countSlash = 0
    for c in comment:
        if c == '/':
            countSlash+=1
            if star == True:
                inside = False
                star = False
            elif slash == True:
                final += '/'
            else :
                slash = True
                if countSlash == 3:
                    slash = False
                    final += '///'
        elif c == '*':
            countSlash = 0
            if slash == True:
                inside = True
                slash = False
            else :
                star = True
        else :
            countSlash = 0
            if slash == True:
                final += '/'
            if star == True:
                final += '*'
            slash = False
            star = False
            if inside == False:
                final += c

    return final, inside

def parseJson(sourceFile):
    # remove the comments in the json file
    handle, target = tempfile.mkstemp(suffix='.json', text=True) # sourceFile + 'temp'
    inside = False
    with open(sourceFile,'r') as src:
        trg = open(target,'w')
        lines = src.readlines()
        for line in lines:
            line,inside = removeComment(line, inside)
            if len(line) > 0:
                trg.write(line)
        trg.close()
    with open(target,'r') as src:
        parsedJson = json.load(src)
    os.close(handle)
    return parsedJson, target

def main(argv):
    if len(argv) < 5 :
        print('invalid number of parameters')
        print('usage: python createEventIds.py <options> <json property ids source file> <target template file> <target file>')
    else :
        branch = getGitBranch()
        options = argv[1]
        sourceFile = argv[2]
        targetTemplateFile = argv[3]
        targetFile = argv[4]
        if len(argv) == 6:
            branch = argv[5]
        jsonObject, tmpFile = parseJson(sourceFile)
        eventIdsDeprecated = ''

        if targetFile.find('.h') != -1:
            if options == 'ObjectiveC':
                eventIds = createEventIdsFileForObjectiveC(jsonObject, False, branch)
                eventIdsDeprecated = createEventIdsFileForObjectiveC(jsonObject, True, branch)
            else:
                eventIds = createEventIdsFileForH(jsonObject, False, branch)
                eventIdsDeprecated = createEventIdsFileForH(jsonObject, True, branch)
        elif targetFile.find('.cs') != -1:
            eventIds = createEventIdsFileForCSharp(jsonObject, False, branch)
            eventIdsDeprecated = createEventIdsFileForCSharp(jsonObject, True, branch)
        elif targetFile.find('.c') != -1:
            eventIds = createEventIdsFileForC(jsonObject, False, branch)
            eventIdsDeprecated = createEventIdsFileForC(jsonObject, True, branch)
        elif targetFile.find('.ts') != -1:
            eventIds = createEventIdsFileForTypescript(jsonObject, False, branch)
            eventIdsDeprecated = createEventIdsFileForTypescript(jsonObject, False, branch)
        elif targetFile.find('.dart') != -1:
            eventIds = createEventIdsFileForDart(jsonObject, False, branch)
            eventIdsDeprecated = createEventIdsFileForDart(jsonObject, False, branch)
        if eventIds is not None:
            replaceTemplateContentWithEventIds(targetTemplateFile, targetFile, eventIds, eventIdsDeprecated)
        else :
            print('the target file is not recognized. Shoud be a .h(*) or .c(*)')
        try:
            os.unlink(tmpFile)
        except:
            print("Unexpected error trying to remove the tmpfile:" + tmpFile, sys.exc_info()[1])
if __name__ == '__main__':
    main(sys.argv)
