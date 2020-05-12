SourceForgeUpdateChecker
========================
http://sourceforge.net/projects/kpsfupdatechecker

This is a plugin to KeePass <http://www.KeePass.info> to allow other plugins to check
for updates using the latest file release on SourceForge. On it's own, it does nothing,
but other plugins may require this one in order to provide version information when KeePass
checks for upades


Installation
------------
Place SourceForgeUpdateChecker.plgx in your KeePass Plugins folder.


Usage (Plugin Developers)
-------------------------
To use this plugin to assist with version checking, in your own plugin override the UpdateUrl
property with a URI of the form:

sourceforge-version://YourPluginName/YourProjectName?VersionRegex

Where:
 YourPluginName is the exact name of your KeePass plugin, as specified in its AssemblyTitle
 YourProjectName is the name of your sourceforge project, as it appears in the URL to the project page
 VersionRegex is a regular expression that extracts the version number from the release path

(remember to URL-encode, particularly the regex!)

This plugin will then go to:
http://sourceforge.net/projects/YourProjectName/files/latest/download

And find the url to the file that it offers to download. It will then apply VersionRegex to it,
and if it matches, the matching groups will be used as the version number to report to KeePass.

For example, if you name your file "MyPlugin-0.1.0.zip" you might want to use the regex "-(.+?)\.zip"
Or if you put your file in a version number folder like: "v0.1.0/MyPlugin.zip" then you could use
"/v([\d.]+)/" or similar. So long as the result is a numeric version number KeePass will be happy
with it.


Uninstallation
--------------
Delete SourceForgeUpdateChecker.plgx from your KeePass Plugins folder.


Bug Reporting, Questions, Comments, Feedback
--------------------------------------------
Please use the SourceForge project page: <http://sourceforge.net/projects/kpsfupdatechecker>
Bugs can be reported using the issue tracker, for anything else, a discussion forum is available.


Changelog
---------
v0.4
 Fixes compatibility with SourceForge by always requesting over https

v0.3
 Fixes bug where KeePass proxy settings were used

v0.2
 Fixes check-hanging bug where multiple clients are using this helper

v0.1 Initial release