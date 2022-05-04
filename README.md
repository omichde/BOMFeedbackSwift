# BOMFeedbackSwift

A general iOS feedback module, which helps to show most APP information, get in contact with the user, promote positive APP ratings, and other stuff - think of it as a more elaborated but concise AboutMe dialog.

The idea behind this package is to free you as a developer from those tedious administrative areas within your APP (about, copyright, user contact) and at the same time motivate users to positive reviews: it starts with a simple question, whether the user likes that APP (and hence could give a positive review or like to share it) or in case of problems provides a FAQ/email contact.

# Features

- every module can be switched on/off in the config
- selection of "sharing services" (APP Store rating deep-link, email, twitter, facebook)
- every text output can be localized
- SF Symbol icon font for (tab bar) symbols, zero images used
- support for DarkMode, markdown
- runs modally or as a form sheet
- self-contained, no extra dependencies
- one storyboard, all AutoLayout, full rotation support
- local or server-based FAQ with auto-updating
- embedding for custom subviewcontroller (i.e. for IAP restauration)

# Installation

Link to `BOMFeedbackSwift` as an SPM. There is a sample `niceapp` to show a local setup. BOMFeedbackSwift is configured using a concise configuration value or a property list or JSON file and uses localizations from different subfiles.

# Documentation

`APPId` - the number of your APP in the APP store (123456789)

`ITMSURL` - the Link to your APP in the APP store (http://itunes.apple.com/de/app/id12345678?mt=8)

`WebURL` - the Link to your website for this APP (http://getniceapp.com)

## Contact module

This is the core and initial module. It simply starts with the question if the user likes the APP or not. In case he likes it, he'll be invited to submit a review in the APP store and/or share an APP link to others. In case there is a problem, a FAQ is displayed and an email button to get in contact with you.

`submodule` - classname of a custom subviewcontroller, optional. If you want to display further information about your APP in the contact module or an APP store purchase restoring feature, this might be the right place.

`email` - email address to be used in the contact sheet (info@getniceapp.com)

`services` - comma-separated list of services: store, email, twitter, facebook

`faqFile` - local filename containing your FAQ, optional (FeedbackFAQ.plist)

## APPs module

This module loads and displays an HTML page from your server. Your page should contain other APPs or recommendations of you.

`URL` - the URL to load (http://getallniceapps.com)

Following GET parameters are sent to the server:

`locale` - the locale of the APP

`src` - the CFBundleName of the APP

## About module

A local and hence localized HTML page is displayed. It is a good idea the collect basic information about the APP and you in this page, maybe including address, copyright, and APP history information.

`file` - the name of the HTML file to be displayed (FeedbackAbout.html)

## Modules module

A small acknowledgment page to those who built frameworks, libraries, code, or graphics you are using in this APP.

`files` - a list of files to be displayed. HTML, RTF, or PDF is supported

# Compatibility

Tested and developed under iOS 15

# Contact

Oliver Michalak - [oliver@werk01.de](mailto:oliver@werk01.de) - [@omichde](http://twitter.com/omichde)

## Keywords

iOS, feedback, user, contact, markdown

## License

BOMFeedbackSwift is available under the MIT license:

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
