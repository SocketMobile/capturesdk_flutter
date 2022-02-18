# CoreConstantsCapture

## Note

This project was initially called **Capture Property IDs Universal**. You may find some references to this old name, which is the reason why this note exists.

## Purpose of this project

This project defines the constants that are used in Capture for all the platforms supported by Capture.

This project is integrated as subtree of a Capture project for each platform except for iOS where it will be used as Swift Pakcage Manager. See instructions further.

The python script is used to generate the appropriate source file(s) for the platform for which the build is invoked.

## Subtree integration

If modifications have been made in the Subtree it can be possible to pushand pull those modifications back to the original project from the Subtree by doing:

```
1. git remote add CoreConstantsCapture git@git.socketmobile.com:scanning/captureconstants-universal.git
2. git subtree add --prefix=CoreConstantsCapture/ git@git.socketmobile.com:scanning/captureconstants-universal.git master
```

Then to pull the modifications from the subtree repository:

```
git subtree pull --prefix=CoreConstantsCapture/ git@git.socketmobile.com:scanning/captureconstants-universal.git master
```

And then, to push the modifications made on the subtree repository:

```
git subtree push --prefix=CoreConstantsCapture/ git@git.socketmobile.com:scanning/captureconstants-universal.git master
```

This will update the project captureconstants-universal with the modifications made in the captureconsole-windows/CoreConstantsCapture folder.

## Installation for iOS projects

### Prerequisites

You have to have a source control account configured into Xcode before doing this operation. NB: Xcode does not support ED25519 SSH keys yet.

In Xcode:

- File menu > Add packages...

1. Locally (for development purpose) - Ideally, call the branch the same name than the current branch you're working on on the project where you're adding the package (soon to be automated...)

- Choose this repository in your Finder
- Choose the right branch, version or commit
- Add it to the right project of your workspace
- In the target under which you want to add this package, go to **Build Phases**
- In the **Link Binary With Libraries**, click on the + to add a binary
- In the list, select **CoreConstantsCapture** and click on the Add button

2. Remotely

- Choose this repository in your source control account
- Choose the right branch, version or commit
- Add it to the right project of your workspace
- It is added automatically to **Link Binary With Libraries**

## How to Run The Tests

Simply run `buildscripts/build.sh` in your command line and the tests should run. If a test fails the script will stop and alert you to the error.