# createDeviceTypes.py
# Python script to transform the JSON Device Types to
# header file
#
# Just add the tag $DEVICETYPES$ in your template file
# and this script will replace this tag with all the
# property found in the deviceTypes.json file
#
# NOTE: IMPORTANT INFORMATION ABOUT BRANCH
# When a device type has a branch field, then the current
# branch should contains the word in the mentioned
#
#
# (c) 2018 Copyright Socket Mobile, Inc.
import sys
import json
import re # regular expression
import os
import subprocess
import tempfile

def getIndividualValue(jsonObject, section, typeString):
    for t in jsonObject[section]:
        if typeString == t:
            return jsonObject[section][t]['value']
    return 0


# const long kSktCapturePropIdFriendlyNameDevice = SKTPROPIDCAPTURE(0) | SKTGETTYPE(kSktCapturePropTypeNone) | SKTSETTYPE(kSktCapturePropTypeString) | SKTSETGROUPID(kSktCaptureGroupLocalFunctions) | SKTSETPROPID(kSktCaptureIdDeviceFriendlyName);
def getValue(jsonObject, p):
    value = 0
    value += getIndividualValue(jsonObject,"classType",jsonObject['deviceTypes'][p]['classType']) << 24
    value += getIndividualValue(jsonObject,"interfaceType",jsonObject['deviceTypes'][p]['interfaceType']) << 16
    if 'productID' in jsonObject['deviceTypes'][p]:
        value += getIndividualValue(jsonObject,"productID",jsonObject['deviceTypes'][p]['productID'])
    if 'managerID' in jsonObject['deviceTypes'][p]:
        value += getIndividualValue(jsonObject,"managerID",jsonObject['deviceTypes'][p]['managerID'])
    if value & 0x80000000:
        value = -0x100000000 + value
    return value

def checkIfBranchMatches(jsonObject, p, section, branch):
    add = True
    if 'branch' in jsonObject[section][p]:
        br = jsonObject[section][p]['branch']
        br = br.lower()
        add = br in branch
    return add

def createIdsFileForC(jsonObject, branch):
    Ids = "\n\n// Device Types\n"
    for p in jsonObject['deviceTypes']:
        value = getValue(jsonObject, p)
        name = p[1:]
        name = "kSktCaptureDeviceType" + name
        if checkIfBranchMatches(jsonObject, p, 'deviceTypes', branch):
            print(name)
            Ids += 'const int kSktCaptureProp{0} = {1};\n'.format(name, value)

    return Ids

def createEnum(result, prefix, formatStyle, section, jsonObject, branch, isDart=False):
    for p in jsonObject[section]:
        name = p[1:]
        name = prefix + name
        if (isDart):
            name = dartLowerHelper(name, True)
        value = jsonObject[section][p]['value']
        if checkIfBranchMatches(jsonObject, p, section, branch):
            result += '' if isDart else '\t///<summary>'
            for hlp in jsonObject[section][p]['help']:
                result += '\n\t/// {0}'.format(hlp)
                result += '\n\t/// value: {0} (0x{1:05X})'.format(value,value)
            result += '\n\t\n' if isDart else '\n\t///</summary>\n'
            result += formatStyle.format(name,value)
    result += '}\n\n' if isDart else '};\n\n'
    return result

def createIdsFileForH(jsonObject, branch):
    Ids = "// Class Types\n"
    Ids += "enum {\n"
    Ids = createEnum(Ids, 'kSktCaptureDeviceTypeClass', '\t{0} = {1},\n', 'classType', jsonObject, branch)
    Ids += "// Interface Types\n"
    Ids += "enum {\n"
    Ids = createEnum(Ids, 'kSktCaptureDeviceTypeInterface', '\t{0} = {1},\n', 'interfaceType', jsonObject, branch)
    Ids += "// Devices Types\n"
    Ids += "enum {\n"
    for p in jsonObject['deviceTypes']:
        name = p[1:]
        name = "kSktCaptureDeviceType" + name
        value = getValue(jsonObject, p)
        if checkIfBranchMatches(jsonObject, p, 'deviceTypes', branch):
            Ids += '\t///<summary>'
            for hlp in jsonObject['deviceTypes'][p]['help']:
                Ids += '\n\t/// {0}'.format(hlp)
                Ids += '\n\t/// value: {0} (0x{1:05X})'.format(value,value)
            Ids += '\n\t///</summary>\n'
            Ids += '\t{0} = {1},\n'.format(name,value)
    Ids+='};\n\n'
    return Ids

def createIdsFileForCSharp(jsonObject, branch):
    Ids = "/// <summary>\n"
    Ids += "/// defines the Device Type Classes used in Capture\n"
    Ids += "/// </summary>\n"
    Ids += "public class DeviceTypeClasses\n"
    Ids += "{\n"
    Ids = createEnum(Ids, '', '\tpublic const int {0} = {1};\n\n', 'classType', jsonObject, branch)

    Ids += "/// <summary>\n"
    Ids += "/// defines the Device Type Interfaces used in Capture\n"
    Ids += "/// </summary>\n"
    Ids += "public class DeviceTypeInterfaces\n"
    Ids += "{\n"
    Ids = createEnum(Ids, '', '\tpublic const int {0} = {1};\n\n', 'interfaceType', jsonObject, branch)

    Ids += "/// <summary>\n"
    Ids += "/// defines the Device Type used in Capture\n"
    Ids += "/// </summary>\n"
    Ids += "public class DeviceTypes\n"
    Ids += "{\n"
    for p in jsonObject['deviceTypes']:
        value = getValue(jsonObject, p)
        if checkIfBranchMatches(jsonObject, p, 'deviceTypes', branch):
            Ids +="\t/// <summary>\n"
            for hlp in jsonObject['deviceTypes'][p]['help']:
                Ids +='\t/// {0}\n'.format(hlp)
            Ids += '\t/// value: {0} (0x{1:05X})\n'.format(value,value)
            Ids +="\t/// </summary>\n"
            Ids += '\tpublic const int {0} = {1};\n\n'.format(p,value)
    Ids+='};\n\n'

    return Ids

def createIdsFileForObjectiveC(jsonObject, branch):
    Ids = "typedef NS_ENUM(NSInteger, SKTCaptureDeviceTypeClasses){\n";
    Ids = createEnum(Ids, 'SKTCaptureDeviceTypeClass', '\t{0} = {1},\n\n', 'classType', jsonObject, branch)
    Ids += "typedef NS_ENUM(NSInteger, SKTCaptureDeviceTypeInterfaces){\n";
    Ids = createEnum(Ids, 'SKTCaptureDeviceTypeInterface', '\t{0} = {1},\n\n', 'interfaceType', jsonObject, branch)

    Ids += "typedef NS_ENUM(NSInteger, SKTCaptureDeviceType){\n";
    for p in jsonObject['deviceTypes']:
        name = p
        if checkIfBranchMatches(jsonObject, p, 'deviceTypes', branch):
            name = name[1:]
            name = "SKTCaptureDeviceType" + name
            print(name)
            value = getValue(jsonObject, p)
            Ids += "\t/**\n"
            for hlp in jsonObject['deviceTypes'][p]['help']:
                Ids +='\t{0}\n'.format(hlp)
            Ids +='\n\tvalue: {0} (0x{1:05X})\n'.format(value,value)
            Ids +="\t*/\n"
            Ids += '\t{0} = {1},\n\n'.format(name, value)
    Ids += "};\n"

    return Ids

def createIdsFileForTypescript(jsonObject, branch):
    Ids = 'export class CaptureDeviceTypeClass {\n'
    Ids = createEnum(Ids, '', '\tstatic readonly {0} = {1};\n\n', 'classType', jsonObject, branch)
    Ids += 'export class CaptureDeviceTypeInterface {\n'
    Ids = createEnum(Ids, '', '\tstatic readonly {0} = {1};\n\n', 'interfaceType', jsonObject, branch)

    Ids += 'export class CaptureDeviceType {\n'
    for p in jsonObject['deviceTypes']:
        name = p
        if checkIfBranchMatches(jsonObject, p, 'deviceTypes', branch):
            name = name[1:]
            print(name)
            value = getValue(jsonObject, p)
            for hlp in jsonObject['deviceTypes'][p]['help']:
                Ids +='\t//{0}\n'.format(hlp)
            Ids +='\t//value: {0} (0x{1:05X})\n'.format(value,value)
            Ids += '\tstatic readonly {0} = {1};\n\n'.format(name, value)
    Ids += '};\n'

    return Ids
    
def dartLowerHelper(n, extra):
    val = n if extra else n[1:] 
    name = list(val)
    name[0] = name[0].lower()
    name = ''.join(name)
    return name

def createIdsFileForDart(jsonObject, branch):
    Ids = '// ignore_for_file: non_constant_identifier_names\n/// Differentiate between devices and device managers.\nclass CaptureDeviceTypeClass {\n'
    Ids = createEnum(Ids, '', '\tstatic const int {0} = {1};\n\n', 'classType', jsonObject, branch, "\tCaptureDeviceTypeClass();\n\n")
    Ids += '/// Differentiate between types of interfaces (bluetooth, NFC, etc).\nclass CaptureDeviceTypeInterface {\n'
    Ids = createEnum(Ids, '', '\tstatic const int {0} = {1};\n\n', 'interfaceType', jsonObject, branch, "\tCaptureDeviceTypeInterface();\n\n")

    Ids += "/// Differentiate between types of devices (Model 7, NFC tag, etc).\n"
    Ids += 'class CaptureDeviceType {\n'
    for p in jsonObject['deviceTypes']:
        name = p
        if checkIfBranchMatches(jsonObject, p, 'deviceTypes', branch):
            name = dartLowerHelper(name, False)
            print(name)
            value = getValue(jsonObject, p)
            for hlp in jsonObject['deviceTypes'][p]['help']:
                Ids +='\t///{0}\n'.format(hlp)
            Ids +='\t///value: {0} (0x{1:05X})\n'.format(value,value)
            Ids += '\tstatic const int {0} = {1};\n\n'.format(name, value)
    Ids += '}\n'

    return Ids

def replaceTemplateContentWithIds(targetTemplate, target, Ids):
    with open(targetTemplate,'r') as src:
        trg = open(target,'w')
        lines = src.readlines()
        for line in lines:
            line = re.sub(r'\$DEVICETYPES\$',Ids,line)
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
    src.close()
    with open(target,'r') as src:
        parsedJson = json.load(src)
    src.close()
    os.close(handle)
    return parsedJson, target

def getGitBranch():
    pipe = subprocess.Popen(['git', 'branch'], stdout = subprocess.PIPE)
    testb, err = pipe.communicate()
    pipe.stdout.close()
    test = testb.decode('utf8')
    test = re.sub(r'[\n\r]','?', test)
    test = re.sub(r'[\t ]','', test)
    test = test.strip()
    test = test.split('?')
    subs = '*'
    branch = [i for i in test if subs in i][0]
    branch = branch.lower()
    branch = re.sub('^\*', '', branch)
    return branch.strip()

def main(argv):
    if len(argv) < 5 :
        print('invalid number of parameters')
        print('usage: python createDeviceTypes.py <options> <json device types source file> <target template file> <target file>')
        print('usage: <options> could be ObjectiveC or anything else because ')
        print('usage: it is used only to make a distinction for .h files')
    else :
        branch = getGitBranch()
        options = argv[1]
        sourceFile = argv[2]
        targetTemplateFile = argv[3]
        targetFile = argv[4]
        if len(argv) == 6:
            branch = argv[5]
        jsonObject, tmpFile = parseJson(sourceFile)

        if targetFile.find('.h') != -1:
            if options == 'ObjectiveC':
                Ids = createIdsFileForObjectiveC(jsonObject, branch)
            else:
                Ids = createIdsFileForH(jsonObject, branch)
        elif targetFile.find('.cs') != -1:
            Ids = createIdsFileForCSharp(jsonObject, branch)
        elif targetFile.find('.c') != -1:
            Ids = createIdsFileForC(jsonObject, branch)
        elif targetFile.find('.ts') != -1:
            Ids = createIdsFileForTypescript(jsonObject, branch)
        elif targetFile.find('.dart') != -1:
            Ids = createIdsFileForDart(jsonObject, branch)
        if Ids is not None:
            replaceTemplateContentWithIds(targetTemplateFile, targetFile, Ids)
        else :
            print('the target file is not recognized. Shoud be a .h(*) or .c(*)')
        try:
            os.unlink(tmpFile)
        except:
            print("Unexpected error trying to remove the tmpfile:" + tmpFile, sys.exc_info()[1])
if __name__ == '__main__':
    main(sys.argv)