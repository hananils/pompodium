# Export Ensemble #

This extension exports your Symphony website.
It is part of the Symphony core download package.

- Version: 1.11
- Date: 12th Feb 2010
- Requirements: Symphony 2.0.7RC2 or above, ZIP enabled (--enable-zip)
- Author: Alistair Kearney, alistair@symphony-cms.com
- Constributors: [A list of contributors can be found in the commit history](http://github.com/pointybeard/export_ensemble/commits/master)
- GitHub Repository: <http://github.com/pointybeard/export_ensemble>

## Synopsis

This extension will create an installable version of your Symphony install useful for distribution. The resultant archive contains install.php, install.sql and workspace/install.sql files. This is how all official Symphony releases are created.

The ZIP module of PHP is utilised, and is memory efficient, allowing for larger sites to be exported without the need for increasing PHP's memory limit.

Currently this extension adds a "Create" button to the preferences page. In the future it will instead have its own interface with options for including additional files and folders as well as excluding and other options.

## Installation & Updating

Information about [installing and updating extensions](http://symphony-cms.com/learn/tasks/view/install-an-extension/) can be found in the Symphony documentation at <http://symphony-cms.com/learn/>.

## Change Log


**Version 1.11**

- Compatibility changes for 2.0.7RC2


**Version 1.10**

- Added localisation files for Dutch, German, Portuguese (Brazil) and Russian

**Version 1.9**

- Misc code cleanup
- Minor changes to ensure compatibility with PHP v5.3.x

**Version 1.8**

- Any file that matches '/README.*' will be added to the archive along with '/README' if it exists.

**Version 1.7**

- Fixed order in which items are added to the zip so the new 'workspace/install.sql' file overrides any existing one

**Version 1.6**

- Creates separate SQL files. install.sql and workspace/install.sql

**Version 1.5**

- README and LICENCE are correctly added to the archives

**Version 1.3**

- Changed call to pageAlert to make easier to translate and conform with 2.0.1 guidelines

**Version 1.2**

- install() function properly checks for the ZipArchive class and returns true if found, allowing installation

**Version 1.1**

- Moved "installer.tpl", found in the main S2 repository, into the /lib folder