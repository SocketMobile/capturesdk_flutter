# createDataSources.py
# Python script to transform the JSON Data Sources to
# header file
#
# Just add the tag $DATASOURCES$, $DATASOURCESFLAGS$ or
# $DATASOURCESSTATUS$ in your template file
# and this script will replace this tag with all the
# ids found in the dataSourceIds.json file
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

SECTION = 'dataSourceIds'
SECTION_FLAGS = 'SktCaptureDataSourceFlags'
SECTION_STATUS = 'SktCaptureDataSourceStatus'

def getValue(jsonObject, section, p):
    value = jsonObject[section][p]['value']
    return value

def checkIfBranchMatches(jsonObject, section, p, branch):
    add = True
    if 'branch' in jsonObject[section][p]:
        br = jsonObject[section][p]['branch']
        br = br.lower()
        add = br in branch
    return add

def createIdsFileForC(jsonObject, branch):
    Ids = "\n\n// Data Sources\n"
    for p in jsonObject[SECTION]:
        value = getValue(jsonObject, SECTION, p)
        name = p[1:]
        if checkIfBranchMatches(jsonObject, SECTION, p, branch):
            print(name)
            Ids += 'const int kSktCaptureDataSource{0} = {1};\n'.format(name, value)

    return Ids

def createIdsFileForH(jsonObject, branch):
    Ids = "// Data Source IDs\nenum ESktCaptureDataSourceID{\n"
    for p in jsonObject[SECTION]:
        name = p[1:]
        name = "kSktCapture" + name
        value = getValue(jsonObject, SECTION, p)
        if checkIfBranchMatches(jsonObject, SECTION, p, branch):
            Ids += '\t///<summary>'
            for hlp in jsonObject[SECTION][p]['help']:
                Ids += '\n\t/// {0}'.format(hlp)
            Ids += '\n\t///</summary>\n'
            Ids += '\t{0} = {1},\n'.format(name,value)
    Ids+='};\n\n'

    Flags = "// identifies what the Data Source struct contains\nenum ESktCaptureDataSourceFlags{\n";
    for p in jsonObject[SECTION_FLAGS]:
        name = p[1:]
        name = "kSktCaptureDataSource" + name
        value = getValue(jsonObject, SECTION_FLAGS, p)
        if checkIfBranchMatches(jsonObject, SECTION_FLAGS, p, branch):
            Flags += '\t///<summary>'
            for hlp in jsonObject[SECTION_FLAGS][p]['help']:
                Flags += '\n\t/// {0}'.format(hlp)
            Flags += '\n\t///</summary>\n'
            Flags += '\t{0} = {1},\n'.format(name,value)
    Flags+='};\n\n'

    Status = "// identifies the status of a Data Source\nenum ESktCaptureDataSourceStatus{\n"
    for p in jsonObject[SECTION_STATUS]:
        name = p[1:]
        name = "kSktCaptureDataSource" + name
        value = getValue(jsonObject, SECTION_STATUS, p)
        if checkIfBranchMatches(jsonObject, SECTION_STATUS, p, branch):
            Status += '\t///<summary>'
            for hlp in jsonObject[SECTION_STATUS][p]['help']:
                Status += '\n\t/// {0}'.format(hlp)
            Status += '\n\t///</summary>\n'
            Status += '\t{0} = {1},\n'.format(name,value)
    Status+='};\n\n'

    return Ids, Flags, Status

def createIdsFileForCSharp(jsonObject, branch):
    Ids = "/// <summary>\n"
    Ids += "/// defines the Data Source IDs used in Capture\n"
    Ids += "/// </summary>\n"
    Ids += "public class Id\n"
    Ids += "{\n"
    for p in jsonObject[SECTION]:
        value = getValue(jsonObject, SECTION, p)
        if checkIfBranchMatches(jsonObject, SECTION, p, branch):
            Ids +="\t/// <summary>\n"
            for hlp in jsonObject[SECTION][p]['help']:
                Ids +='\t/// {0}\n'.format(hlp)
            Ids +="\t/// </summary>\n"
            Ids += '\tpublic const int {0} = {1};\n\n'.format(p,value)
    Ids+='};\n\n'

    Flags = "/// <summary>\n"
    Flags += "/// defines the Data Source Flags used in a Capture Data Source\n"
    Flags += "/// </summary>\n"
    Flags += "public class FlagsMask\n"
    Flags += "{\n"
    for p in jsonObject[SECTION_FLAGS]:
        value = getValue(jsonObject, SECTION_FLAGS, p)
        if checkIfBranchMatches(jsonObject, SECTION_FLAGS, p, branch):
            Flags +="\t/// <summary>\n"
            for hlp in jsonObject[SECTION_FLAGS][p]['help']:
                Flags +='\t/// {0}\n'.format(hlp)
            Flags +="\t/// </summary>\n"
            Flags += '\tpublic const int {0} = {1};\n\n'.format(p,value)
    Flags+='};\n\n'

    Status = "/// <summary>\n"
    Status += "/// defines the Data Source Status used in Capture\n"
    Status += "/// </summary>\n"
    Status += "public class StatusValues\n"
    Status += "{\n"
    for p in jsonObject[SECTION_STATUS]:
        value = getValue(jsonObject, SECTION_STATUS, p)
        if checkIfBranchMatches(jsonObject, SECTION_STATUS, p, branch):
            Status +="\t/// <summary>\n"
            for hlp in jsonObject[SECTION_STATUS][p]['help']:
                Status +='\t/// {0}\n'.format(hlp)
            Status +="\t/// </summary>\n"
            Status += '\tpublic const int {0} = {1};\n\n'.format(p,value)
    Status+='};\n\n'

    return Ids, Flags, Status

def createIdsFileForObjectiveC(jsonObject, branch):
    Ids = "typedef NS_ENUM(NSInteger, SKTCaptureDataSourceID) {\n"
    for p in jsonObject[SECTION]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION, p, branch):
            name = name[1:]
            name = "SKTCaptureDataSourceID" + name
            print(name)
            value = getValue(jsonObject, SECTION, p)
            Ids += "\t/**\n"
            for hlp in jsonObject[SECTION][p]['help']:
                Ids +='\t{0}\n'.format(hlp)
            Ids +="\t*/\n"
            Ids += '\t{0} = {1},\n\n'.format(name, value)
    Ids +="};\n"

    Flags = "typedef NS_OPTIONS(NSInteger, SKTCaptureDataSourceFlags) {\n"
    for p in jsonObject[SECTION_FLAGS]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION_FLAGS, p, branch):
            name = name[1:]
            name = "SKTCaptureDataSourceFlags" + name
            print(name)
            value = getValue(jsonObject, SECTION_FLAGS, p)
            Flags += "\t/**\n"
            for hlp in jsonObject[SECTION_FLAGS][p]['help']:
                Flags +='\t{0}\n'.format(hlp)
            Flags +="\t*/\n"
            Flags += '\t{0} = {1},\n\n'.format(name, value)
    Flags +="};\n"

    Status = "typedef NS_ENUM(NSInteger, SKTCaptureDataSourceStatus) {\n"
    for p in jsonObject[SECTION_STATUS]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION_STATUS, p, branch):
            name = name[1:]
            name = "SKTCaptureDataSourceStatus" + name
            print(name)
            value = getValue(jsonObject, SECTION_STATUS, p)
            Status += "\t/**\n"
            for hlp in jsonObject[SECTION_STATUS][p]['help']:
                Status +='\t{0}\n'.format(hlp)
            Status +="\t*/\n"
            Status += '\t{0} = {1},\n\n'.format(name, value)
    Status +="};\n"

    return Ids, Flags, Status

def createIdsFileForTypescript(jsonObject, branch):
    Ids = "export class CaptureDataSourceID {\n"
    for p in jsonObject[SECTION]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION, p, branch):
            name = name[1:]
            print(name)
            value = getValue(jsonObject, SECTION, p)
            for hlp in jsonObject[SECTION][p]['help']:
                Ids +='\t// {0}\n'.format(hlp)
            Ids += '\tstatic readonly {0} = {1};\n\n'.format(name, value)
    Ids +="};\n"

    Flags = "export class CaptureDataSourceFlags {\n"
    for p in jsonObject[SECTION_FLAGS]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION_FLAGS, p, branch):
            name = name[1:]
            print(name)
            value = getValue(jsonObject, SECTION_FLAGS, p)
            for hlp in jsonObject[SECTION_FLAGS][p]['help']:
                Flags +='\t// {0}\n'.format(hlp)
            Flags += '\tstatic readonly {0} = {1};\n\n'.format(name, value)
    Flags +="};\n"

    Status = "export class CaptureDataSourceStatus {\n"
    for p in jsonObject[SECTION_STATUS]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION_STATUS, p, branch):
            name = name[1:]
            print(name)
            value = getValue(jsonObject, SECTION_STATUS, p)
            for hlp in jsonObject[SECTION_STATUS][p]['help']:
                Status +='\t// {0}\n'.format(hlp)
            Status += '\tstatic readonly {0} = {1};\n\n'.format(name, value)
    Status +="};\n"

    return Ids, Flags, Status

def dartLowerHelper(n):
    name = list(n[1:])
    name[0] = name[0].lower()
    name = ''.join(name)
    return name

def createIdsFileForDart(jsonObject, branch):
    Ids = "/// Generated datasource information for data in capture events.\n"
    Ids += "class CaptureDataSourceID {\n"
    for p in jsonObject[SECTION]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION, p, branch):
            name = dartLowerHelper(name)
            print('TEST: ' + name)
            value = getValue(jsonObject, SECTION, p)
            for hlp in jsonObject[SECTION][p]['help']:
                Ids +='\t/// {0}\n'.format(hlp)
            Ids += '\tstatic const int {0} = {1};\n\n'.format(name, value)
    Ids +="}\n"

    Flags = "/// Flags for the different data sources in capture events.\n"
    Flags += "class CaptureDataSourceFlags {\n"
    for p in jsonObject[SECTION_FLAGS]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION_FLAGS, p, branch):
            name = dartLowerHelper(name)
            print(name)
            value = getValue(jsonObject, SECTION_FLAGS, p)
            for hlp in jsonObject[SECTION_FLAGS][p]['help']:
                Flags +='\t/// {0}\n'.format(hlp)
            Flags += '\tstatic const int {0} = {1};\n\n'.format(name, value)
    Flags +="}\n"

    Status = "/// Status properties for data sources in capture events.\n"
    Status += "class CaptureDataSourceStatus {\n"
    for p in jsonObject[SECTION_STATUS]:
        name = p
        if checkIfBranchMatches(jsonObject, SECTION_STATUS, p, branch):
            name = dartLowerHelper(name)
            print(name)
            value = getValue(jsonObject, SECTION_STATUS, p)
            for hlp in jsonObject[SECTION_STATUS][p]['help']:
                Status +='\t/// {0}\n'.format(hlp)
            Status += '\tstatic const int {0} = {1};\n\n'.format(name, value)
    Status +="}\n"

    return Ids, Flags, Status

def replaceTemplateContentWithIds(targetTemplate, target, Ids, Flags, Status):
    with open(targetTemplate,'r') as src:
        trg = open(target,'w')
        lines = src.readlines()
        for line in lines:
            line = re.sub(r'\$DATASOURCES\$',Ids,line)
            line = re.sub(r'\$DATASOURCESFLAGS\$',Flags,line)
            line = re.sub(r'\$DATASOURCESSTATUS\$',Status,line)
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
    handle, target = tempfile.mkstemp(suffix='.json', text='true') # sourceFile + 'temp'
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

def main(argv):
    if len(argv) < 5 :
        print('invalid number of parameters')
        print('usage: python createDataSources.py <options> <json data sources file> <target template file> <target file> [option branch flavor]')
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

        Ids = None
        if targetFile.find('.h') != -1:
            if options == 'ObjectiveC':
                Ids, Flags, Status = createIdsFileForObjectiveC(jsonObject, branch)
            else:
                Ids, Flags, Status = createIdsFileForH(jsonObject, branch)
        elif targetFile.find('.cs') != -1:
            Ids, Flags, Status = createIdsFileForCSharp(jsonObject, branch)
        elif targetFile.find('.c') != -1:
            Ids = createIdsFileForC(jsonObject, branch)
        elif targetFile.find('.ts') != -1:
            Ids, Flags, Status = createIdsFileForTypescript(jsonObject, branch)
        elif targetFile.find('.dart') != -1:
            Ids, Flags, Status = createIdsFileForDart(jsonObject, branch)
        if Ids is not None:
            replaceTemplateContentWithIds(targetTemplateFile, targetFile, Ids, Flags, Status)
        else :
            print('the target file is not recognized. Shoud be a .h(*), .c(*) or .ts')

if __name__ == '__main__':
    main(sys.argv)
