# How to compile the Docs

## Prerequisites
The following needs to be installed on your machine:
- Python 2.7 (note: 3.9 also works)
- pip
- virtualenv

### Installing Python
Please follow the instructions from this link: https://www.python.org/downloads/

### Installing pip
Instructions can be found here: https://packaging.python.org/guides/installing-using-pip-and-virtualenv/

Note, some of these update steps required write access to the program files folder, so admin may be required

And here is a summary:

#### Windows:
get the version of pip:
```
py -m pip --version
```
update pip:
```
py -m pip install --upgrade pip
```

#### macOs/Linux:
```
python -m pip install --user --upgrade pip
```
Assuming you have a `python` alias to the appropriate python version you would like to use.

### Installing virtualenv
virtualenv is recommended in order to avoid any python packages conflicts.

#### Windows:
```
py -m pip install --user virtualenv
```

#### macOs/Linux
```
python -m pip install --user virtualenv
```
Note: This step may recommend adding a path to the virtualenv file, this is recommended.


## Steps to build the docs

### 1- Go to the docs folder where this README.md file is located.
```
cd docs
```

### 2- Create the virtualenv if not already there.
Check if docs/bin is present in the docs folder, and if that's the case then you can skip this step and the following to
go directly to build the docs step 5.
```
py -m virtualenv docs
```
macOs/Linux

```
virtualenv docs
```

### 3- Activate the virtualenv
Windows:
```
docs/Scripts/activate
```
macOs/Linux:
```
source docs/bin/activate
```

  *Please not that once you're done with the docs, you can deactivate this virtualenv by doing the following:*

  Windows:
  ```
  docs\Scripts\deactivate
  ```

  macOs/Linux:
  ```
  deactivate
  ```

### 4- Install the requirements.txt

```
pip install -r requirements.txt
```

### 5- Build the docs!
Windows:
```
make html
```
To create the .Pot files
make gettext

macOs/Linux:
```
docs/bin/sphinx-build source build
```

### 6- Open the doc:
Windows:
```
start build\html\index.html
```

Note: you may have to browse to the file location with explorer and double click on the index.html file

macOs/Linux:
```
open build/index.html
```

## Creating Translated versions of the docs

Most of this was gleaned from the following link:
http://www.sphinx-doc.org/en/master/intl.html

Talk on using Sphinx for I18n
https://www.youtube.com/watch?v=Nz8zutA55fI

### Steps for doing translations

#### 1- Make sure you can build the docs as above

#### 2- Install Sphinx-intl
Windows:
```
py -m pip install sphinx-intl
```

#### 3- Create POT files
This will create .pot files in build/locales

Windows:
```
make gettext
```

#### 4- Update Local_dir
Next, create the .PO files for desired languages (Japanese and German in this example)
Windows:
```
sphinx-intl update -p build/locales -l ja -l de
```

MacOS/Linux
```
make -e SPHINXOPTS="-D= language='ja'" html
```

#### 5- Translate
Translate the .po files in ./local/ja/LC_MESSAGES/.
This is probably done by an outside person or company
(e.g. www.icanlocalize.com, Tadaki-san, Richard, etc).
It is best to use a PO File editor tool, such as POEdit.com, 
as the raw .po file can be tricky.  Note that edited text in the
.PO file should go into the msgstr item.

#### 6- Build .mo files from .po files
Note: supposedly sphinx 1.3 does this automatically, but if you are using sphinx 
1.2.x or earlier, this step is required

Windows:
```
sphinx-intl build
```

#### 7- Make Translated documents
Windows:
```
set SPHINXOPTS=-D language='ja'
make.bat html
```

This should give you the translated HTML in the build/html folders

## To create a PDF from the doc
There are 2 tools possible to create a PDF file from the documentation.
The recommended one is by using LaTeX which creates a prettier PDF than `rst2pdf` which is part of Sphinx.

LaTeX is huge to install on a machine though.
So here are some reference links:
https://docs.typo3.org/typo3cms/extensions/sphinx/AdvancedUsersManual/RenderingPdf/#rendering-pdf-from-restructuredtext

To download LaTeX for MacOs:
http://www.tug.org/mactex/mactex-download.html

### Steps for creating a PDF

#### 1- build the docs in LaTeX:

macOs/Linux:
```
docs/bin/sphinx-build -b latex source build/latex
```

#### 2- create the pdf using LaTeX:

macOs/Linux:
```
cd build/latex
pdflatex CaptureSDK.tex
```
