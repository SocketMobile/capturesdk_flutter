# createErrors.py
# Python script to transform the JSON Errors to
# header file
#
# Just add the tag $ERROR$ in your template file
# and this script will replace this tag with all the
# property found in the propertyIDS.json file
#
# NOTE: IMPORTANT INFORMATION ABOUT DEPRECATED ERRORS
# There is a new keyword to have the definition of all the
# properties including those that are deprecated. This keyword
# is $ERRORSDEPRECATED$. If you have this keyword in your
# template file, it will be replaced by all the errors
# including those that are marked as deprecated.
#
#  The only option supported is ObjectiveC to import
#  the properties in a header file designed for ObjectiveC
#
# (c) 2017 Copyright Socket Mobile, Inc.
import sys
import json
import re # regular expression
import os
import subprocess
import tempfile

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

def createErrorsFileForH(jsonObject, includeDeprecated, branch):
    errors = "\n\n// Errors definition\nenum {\n";
    for p in jsonObject['errors']:
        comment = ''
        if 'deprecated' in p and p['deprecated'] == True:
            comment = '// deprecated'
            if includeDeprecated == False:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = (p['name'])
        print (name)
        value = p['value']
        errors += '\t{0} = {1}, {2}\n'.format(name,value,comment)
    errors+='};\n\n'
    return errors

def createErrorsFileForCSharp(jsonObject, includeDeprecated, branch):
    errors = "/// <summary>\n"
    errors += "/// defines the Errors used in Capture\n"
    errors += "/// </summary>\n"
    errors += "public partial class SktErrors\n"
    errors += "{\n"
    for p in jsonObject['errors']:
        comment = ''
        if 'deprecated' in p and p['deprecated'] == True:
            comment = 'THIS ERROR IS DEPRECATED!!!'
            if includeDeprecated == False:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        print(p['name'])
        value = p['value']
        errors +="\t/// <summary>\n"
        for hlp in p['help']:
            errors +='\t/// {0}\n'.format(hlp)
            if len(comment) > 0:
                errors +='\t/// {0}\n'.format(comment)
        errors +="\t/// </summary>\n"
        errors += '\tpublic const int {0} = {1};\n\n'.format(p['name'],value)
    errors+='};\n\n'

    return errors

def createErrorsFileForObjectiveC(jsonObject, includeDeprecated, branch):
    errors = "typedef NS_ENUM(NSInteger, SKTCaptureErrors) {\n";
    for p in jsonObject['errors']:
        comment = ''
        if 'deprecated' in p and p['deprecated'] == True:
            comment = '\tTHIS ERROR IS DEPRECATED\n'
            if includeDeprecated == False:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        name = p['name']
        name = name[5:] # remove the ESKT_
        name = "SKTCaptureE_" + name
        print(name)
        value = p['value']
        errors +="\t/**\n"
        for hlp in p['help']:
            errors +='\t{0}\n{1}'.format(hlp,comment)
        errors +="\t*/\n"
        errors += '\t{0} = {1},\n\n'.format(name, value)
    errors +='};\n'
    return errors

def createErrorsFileForTypeScript(jsonObject, includeDeprecated, branch):
    errors = "/// <summary>\n"
    errors += "/// defines the Errors used in Capture\n"
    errors += "/// </summary>\n"
    errors += "class SktErrors\n"
    errors += "{\n"
    for p in jsonObject['errors']:
        comment = ''
        if 'deprecated' in p and p['deprecated'] == True:
            comment = 'THIS ERROR IS DEPRECATED!!!'
            if includeDeprecated == False:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        print(p['name'])
        value = p['value']
        errors +="\t/// <summary>\n"
        for hlp in p['help']:
            errors +='\t/// {0}\n'.format(hlp)
            if len(comment) > 0:
                errors +='\t/// {0}\n'.format(comment)
        errors +="\t/// </summary>\n"
        errors += '\tstatic readonly {0} = {1};\n\n'.format(p['name'],value)
    errors+='};\n\n'

    return errors

def createErrorsFileForDart(jsonObject, includeDeprecated, branch):
    errors = ''
    errors += "/// defines the Errors used in Capture\n"
    errors += "class SktErrors\n"
    errors += "{\n"
    for p in jsonObject['errors']:
        comment = ''
        if 'deprecated' in p and p['deprecated'] == True:
            comment = 'THIS ERROR IS DEPRECATED!!!'
            if includeDeprecated == False:
                continue
        if checkIfBranchMatches(p, branch) == False:
            continue
        print(p['name'])
        value = p['value']
        for hlp in p['help']:
            errors +='\t/// {0}\n'.format(hlp)
            if len(comment) > 0:
                errors +='\t/// {0}\n'.format(comment)
        errors += '\tstatic const int {0} = {1};\n\n'.format(p['name'],value)
    errors+='}'

    return errors

def replaceTemplateContentWithErrors(targetTemplate, target, errors, errorsDeprecated):
    with open(targetTemplate,'r') as src:
        trg = open(target,'w')
        lines = src.readlines()
        for line in lines:
            line = re.sub(r'\$ERRORS\$',errors,line)
            line = re.sub(r'\$ERRORSDEPRECATED\$',errorsDeprecated,line)
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
    with open(target,'r') as src:
        parsedJson = json.load(src)
    os.close(handle)
    return parsedJson, target

def main(argv):
    if len(argv) < 5 :
        print('invalid number of parameters')
        print('usage: python createErrors.py <options> <json errors source file> <target template file> <target file>')
    else :
        branch = getGitBranch()
        options = argv[1]
        sourceFile = argv[2]
        targetTemplateFile = argv[3]
        targetFile = argv[4]
        if len(argv) == 6:
            branch = argv[5]
        jsonObject, tmpFile = parseJson(sourceFile)
        errorsDeprecated = ''
        if targetFile.find('.h') != -1:
            if options == 'ObjectiveC':
                errors = createErrorsFileForObjectiveC(jsonObject, False, branch)
                errorsDeprecated = createErrorsFileForObjectiveC(jsonObject, True, branch)
            else:
                errors = createErrorsFileForH(jsonObject, False, branch)
                errorsDeprecated = createErrorsFileForH(jsonObject, True, branch)
        elif targetFile.find('.cs') != -1:
            errors = createErrorsFileForCSharp(jsonObject, False, branch)
            errorsDeprecated = createErrorsFileForCSharp(jsonObject, True, branch)
        elif targetFile.find('.ts') != -1:
            errors = createErrorsFileForTypeScript(jsonObject, False, branch)
            errorsDeprecated = createErrorsFileForTypeScript(jsonObject, True, branch)
        elif targetFile.find('.dart') != -1:
            errors = createErrorsFileForDart(jsonObject, False, branch)
            errorsDeprecated = createErrorsFileForDart(jsonObject, True, branch)
        if errors is not None:
            replaceTemplateContentWithErrors(targetTemplateFile, targetFile, errors, errorsDeprecated)
        else :
            print('the target file is not recognized. Shoud be a .h(*) or .c(*)')
        try:
            os.unlink(tmpFile)
        except:
            print("Unexpected error trying to remove the tmpfile:" + tmpFile, sys.exc_info()[1])
if __name__ == '__main__':
    main(sys.argv)
