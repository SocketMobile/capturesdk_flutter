# createPropertyIds.py
# Python script to transform the JSON Property IDs to
# header file
#
# Just add the tag $PROPERTYIDS$ in your template file
# and this script will replace this tag with all the
# property found in the propertyIDS.json file
#
# NOTE: IMPORTANT INFORMATION ABOUT DEPRECATED PROPERTIES
# There is a new keyword to have the definition of all the
# properties including those that are deprecated. This keyword
# is $PROPERTYIDSDEPRECATED$. If you have this keyword in your
# template file, it will be replaced by all the property definitions
# including those that are marked as deprecated.
#
#  The only option supported is ObjectiveC to import
#  the properties in a header file designed for ObjectiveC
#
# (c) 2016 Copyright Socket Mobile, Inc.
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

def getGroupValue(jsonObject, Type, typeString):
    for g in jsonObject['Groups']:
        for t in jsonObject['Groups'][g]:
            if typeString == t:
                return jsonObject['Groups'][g][t]
    return 0

# const long kSktCapturePropIdFriendlyNameDevice = SKTPROPIDCAPTURE(0) | SKTGETTYPE(kSktCapturePropTypeNone) | SKTSETTYPE(kSktCapturePropTypeString) | SKTSETGROUPID(kSktCaptureGroupLocalFunctions) | SKTSETPROPID(kSktCaptureIdDeviceFriendlyName);
def getPropertyValue(jsonObject, p):
    value = 0
    if p['Capture'] :
        value += 1 << 31
    value += getValue(jsonObject,"Types",p['GetType']) << 20
    value += getValue(jsonObject,"Types",p['SetType']) << 16
    value += getValue(jsonObject,"GroupIds",p['GroupId']) << 8
    value += getGroupValue(jsonObject,"PropIds",p['PropId'])
    if value & 0x80000000:
        value = -0x100000000 + value
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
        add = br in branch
    return add

def createPropertyIdsFileForC(jsonObject, includeDeprecated, branch):
    propertyIds = "// Group IDs\n";
    for g in jsonObject['GroupIds']:
        value = jsonObject['GroupIds'][g]['value']
        propertyIds += 'const int {0} = {1};\n'.format(g, value)

    propertyIds += "\n\n// Groups\n";
    for g in jsonObject['Groups']:
        propertyIds +='enum ESkt{0}'.format(g)
        propertyIds +='{\n'
        for sub in jsonObject['Groups'][g]:
            value = jsonObject['Groups'][g][sub]
            name = sub
            propertyIds += '\t{0} = {1},\n'.format(name, value)
        propertyIds +='};\n'

    propertyIds += "\n\n// Properties\n";
    for p in jsonObject['properties']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        value = getPropertyValue(jsonObject, p)
        name = p['Name'][1:]
        name = "kSktCapturePropId" + name
        print(name)
        propertyIds += 'const int kSktCaptureProp{0} = {1};\n'.format(name, value)

    return propertyIds

def createPropertyIdsFileForH(jsonObject, includeDeprecated, branch):
    propertyIds = "\n\n// Group IDs\n"
    propertyIds +="enum {\n"
    for g in jsonObject['GroupIds']:
        value = jsonObject['GroupIds'][g]['value']
        helpText = jsonObject['GroupIds'][g]['help']
        propertyIds += '\t///<summary>\n'
        for hlp in helpText:
            propertyIds += '\t///{0}\n'.format(hlp)
        propertyIds += '\t///</summary>\n'
        propertyIds += '\t{0}={1},\n'.format(g, value)

    propertyIds += "};\n\n// Properties\n"
    for g in jsonObject['Groups']:
        propertyIds += "\n// {0}\n".format(g)
        propertyIds += "enum {\n"
        for p in jsonObject['Groups'][g]:
            value = jsonObject['Groups'][g][p]
            propertyIds += '\t{0}={1},\n'.format(p, value)

        propertyIds += "};"
    propertyIds += "\n\n// Property IDs\nenum {\n"
    for p in jsonObject['properties']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['Name'][1:]
        name = "kSktCapturePropId" + name
        print(name)
        value = getPropertyValue(jsonObject, p)
        propertyIds += '\t///<summary>'
        for hlp in p['help']:
            propertyIds += '\n\t/// {0}'.format(hlp)
        propertyIds += '\n\t///</summary>\n'
        propertyIds += '\t{0} = {1},\t\t// SKTPROPIDCAPTURE({2})|SKTGETTYPE({3})|SKTSETTYPE({4})|SKTSETGROUPID({5})|SKTSETPROPID({6})\n\n'.format(name,value,p['Capture'],p['GetType'],p['SetType'],p['GroupId'],p['PropId'])
    propertyIds+='};\n\n'
    return propertyIds

def createPropertyIdsFileForCSharp(jsonObject, includeDeprecated, branch):
    propertyIds = "/// <summary>\n"
    propertyIds += "/// defines the property value type. Properties can have value of different\n"
    propertyIds += "/// type or no value at all.\n"
    propertyIds += "/// </summary>\n"
    propertyIds += "public class Types {\n"
    for t in jsonObject['Types']:
        typeString = '\t/// <summary>\n'
        for hlp in jsonObject['Types'][t]['help']:
            typeString += '\t/// {0}\n'.format(hlp)
        typeString += '\t/// </summary>\n\tpublic const int {0}={1};\n\n'.format(t, jsonObject['Types'][t]['value'])
        propertyIds += typeString
    propertyIds += "};\n\n"

    propertyIds += "internal class GroupId\n{\n"
    for t in jsonObject['GroupIds']:
        print(t)
        typeString = '\tpublic const int {0} = {1};\n'.format(t,jsonObject['GroupIds'][t]['value'])
        propertyIds += typeString
    propertyIds += "};\n\n"

    for g in jsonObject['Groups']:
        propertyIds += 'internal class {0}\n{{\n'.format(g)
        for t in jsonObject['Groups'][g]:
            typeString = '\tpublic const int {0} = {1};\n'.format(t,jsonObject['Groups'][g][t])
            propertyIds +=typeString
        propertyIds += "};\n\n"

    propertyIds += "\n\n"
    propertyIds += "/// <summary>\n"
    propertyIds += "/// defines the property IDs used in Capture\n"
    propertyIds += "/// </summary>\n"
    propertyIds += "public class PropId\n"
    propertyIds += "{\n"
    for p in jsonObject['properties']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        print(p['Name'])
        value = getPropertyValue(jsonObject, p)
        propertyIds +="\t/// <summary>\n"
        for hlp in p['help']:
            propertyIds +='\t/// {0}\n'.format(hlp)
        propertyIds +="\t/// </summary>\n"
        propertyIds += '\tpublic const int {0} = {1};\t\t// SKTPROPIDCAPTURE({2})|SKTGETTYPE({3})|SKTSETTYPE({4})|SKTSETGROUPID({5})|SKTSETPROPID({6})\n\n'.format(p['Name'],value,p['Capture'],p['GetType'],p['SetType'],p['GroupId'],p['PropId'])
    propertyIds+='};\n\n'

    return propertyIds

def createPropertyIdsFileForObjectiveC(jsonObject, includeDeprecated, branch):
    propertyIds = "";
    for p in jsonObject['properties']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['Name']
        name = name[1:]
        name = "SKTCapturePropertyID" + name
        print(name)
        value = getPropertyValue(jsonObject, p)
        propertyIds +="\t/**\n"
        for hlp in p['help']:
            propertyIds +='\t{0}\n'.format(hlp)
        propertyIds +='\n\tDevice: {0}\tGet Type: {1} \tSet Type: {2}\n'.format(p['Capture']==False, p['GetType'][1:], p['SetType'][1:])
        propertyIds +="\t*/\n"
        propertyIds += '\t{0} = {1},\n\n'.format(name, value)

    return propertyIds

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

def createPropertyValuesForTypeScript(jsonObject, includeDeprecated, branch):
    values = ""
    for p in jsonObject['Values']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['Name']
        print("TYPESCRIPT: " + p['Name'])
        for hlp in p['help']:
            values +='// {0}\n'.format(hlp)
        values += 'export enum {0} {{\n'.format(name)
        values += addValues(name, p, jsonObject, includeDeprecated, branch)
        values += '};\n\n'
    return values

def createPropertyValuesForDart(jsonObject, includeDeprecated, branch):
    values = ""
    for p in jsonObject['Values']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['Name']
        for hlp in p['help']:
            values +='// {0}\n'.format(hlp)
        values += 'class {0} {{\n'.format(name)
        values += addValues(name, p, jsonObject, includeDeprecated, branch, True)
        values += '}\n\n'
    return values

def createPropertyIdsFileForTypescript(jsonObject, includeDeprecated, branch):
    propertyIds = ""
    for p in jsonObject['properties']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['Name']
        name = name[1:]
        # name = "SKTCapturePropertyID" + name
        print(name)
        value = getPropertyValue(jsonObject, p)
        for hlp in p['help']:
            propertyIds +='\t// {0}\n'.format(hlp)
        propertyIds +='\t// Device: {0}\tGet Type: {1} \tSet Type: {2}\n'.format(p['Capture']==False, p['GetType'][1:], p['SetType'][1:])
        propertyIds += '\t{0} = {1},\n\n'.format(name, value)

    types = ""
    for p in jsonObject['Types']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p
        name = name[1:]
        print(name)
        value = getTypeValue(jsonObject, p)
        for hlp in jsonObject['Types'][p]['help']:
            types +='\t// {0}\n'.format(hlp)
        types += '\t{0} = {1},\n\n'.format(name, value)
    values = createPropertyValuesForTypeScript(jsonObject, includeDeprecated, branch)
    return propertyIds, types, values

def lowercaseHelper(name, isFromValues=False):
    newName = list(name[0:] if isFromValues else name[1:])
    newName[0] = newName[0].lower()
    newName = ''.join(newName)
    return newName

def createPropertyIdsFileForDart(jsonObject, includeDeprecated, branch):
    final = ''
    propertyIds = "class CapturePropertyIds {\n\n"
    for p in jsonObject['properties']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['Name']
        name = lowercaseHelper(name)
        # name = "SKTCapturePropertyID" + name
        print(name)
        value = getPropertyValue(jsonObject, p)
        for hlp in p['help']:
            propertyIds +='\t// {0}\n'.format(hlp)
        propertyIds +='\t// Device: {0}\tGet Type: {1} \tSet Type: {2}\n'.format(p['Capture']==False, p['GetType'][1:], p['SetType'][1:])
        propertyIds += '\tint {0} = {1};\n\n'.format(name, value)
    propertyIds += '\tCapturePropertyIds();\n\n'
    propertyIds += '}\n\n'
    final += propertyIds

    types = "class CapturePropertyTypes { \n\n"

    for p in jsonObject['Types']:
        if includeDeprecated == False:
            if 'Deprecated' in p and p['Deprecated'] == True:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p
        name = lowercaseHelper(name) if lowercaseHelper(name) != 'enum' else name[1:]
        print(name)
        value = getTypeValue(jsonObject, p)
        for hlp in jsonObject['Types'][p]['help']:
            types +='\t// {0}\n'.format(hlp)
        types += '\tint {0} = {1};\n\n'.format(name, value)
    types += '\tCapturePropertyTypes();\n\n'
    types += '}\n\n'

    final += types

    values = createPropertyValuesForDart(jsonObject, includeDeprecated, branch)

    final += values

    return final, types, values

def replaceTemplateContentWithPropertyIds(targetTemplate, target, propertyIds, propertyIdsDeprecated, types, typesDeprecated, values, valuesDeprecated):
    with open(targetTemplate,'r') as src:
        trg = open(target,'w')
        lines = src.readlines()
        for line in lines:
            line = re.sub(r'\$PROPERTYIDS\$',propertyIds,line)
            line = re.sub(r'\$PROPERTYIDSDEPRECATED\$',propertyIdsDeprecated,line)
            if types is not None:
                line = re.sub(r'\$TYPES\$',types,line)
            if typesDeprecated is not None:
                line = re.sub(r'\$TYPESDEPRECATED\$',typesDeprecated,line)
            if values is not None:
                line = re.sub(r'\$VALUES\$',values,line)
            if valuesDeprecated is not None:
                line = re.sub(r'\$VALUESDEPRECATED\$',valuesDeprecated,line)
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
        print('usage: python createPropertyIds.py <options> <json property ids source file> <target template file> <target file>')
    else :
        branch = getGitBranch()
        options = argv[1]
        sourceFile = argv[2]
        targetTemplateFile = argv[3]
        targetFile = argv[4]
        if len(argv) == 6:
            branch = argv[5]
        jsonObject, tmpFile = parseJson(sourceFile)
        propertyIdsDeprecated = ''
        types = ''
        typesDeprecated = ''
        values = ''
        valuesDeprecated = ''
        if targetFile.find('.h') != -1:
            if options == 'ObjectiveC':
                propertyIds = createPropertyIdsFileForObjectiveC(jsonObject, False, branch)
                propertyIdsDeprecated = createPropertyIdsFileForObjectiveC(jsonObject, True, branch)
            else:
                propertyIds = createPropertyIdsFileForH(jsonObject, False, branch)
                propertyIdsDeprecated = createPropertyIdsFileForH(jsonObject, True, branch)
        elif targetFile.find('.cs') != -1:
            propertyIds = createPropertyIdsFileForCSharp(jsonObject, False, branch)
            propertyIdsDeprecated = createPropertyIdsFileForCSharp(jsonObject, True, branch)
        elif targetFile.find('.c') != -1:
            propertyIds = createPropertyIdsFileForC(jsonObject, False, branch)
            propertyIdsDeprecated = createPropertyIdsFileForC(jsonObject, True, branch)
        elif targetFile.find('.ts') != -1:
            propertyIds, types, values = createPropertyIdsFileForTypescript(jsonObject, False, branch)
            propertyIdsDeprecated, typesDeprecated, valuesDeprecated = createPropertyIdsFileForTypescript(jsonObject, False, branch)
        elif targetFile.find('.dart') != -1:
            propertyIds, types, values = createPropertyIdsFileForDart(jsonObject, False, branch)
            propertyIdsDeprecated, typesDeprecated, valuesDeprecated = createPropertyIdsFileForDart(jsonObject, False, branch)
        if propertyIds is not None:
            replaceTemplateContentWithPropertyIds(targetTemplateFile, targetFile, propertyIds, propertyIdsDeprecated, types, typesDeprecated, values, valuesDeprecated)
        else :
            print('the target file is not recognized. Shoud be a .h(*) or .c(*)')
        try:
            os.unlink(tmpFile)
        except:
            print("Unexpected error trying to remove the tmpfile:" + tmpFile, sys.exc_info()[1])
if __name__ == '__main__':
    main(sys.argv)
