## 5.0.0

### Enhancements
- **General Changes**
  - Remove landing pages learn more and sign up links
- **Dashboard Changes**
  - Complete profile widget no longer requires a photo to be uploaded
- **Document Changes**
  - Reduced size of folder names in documents sidebar
- **Folder Changes**
  - Folders are now sorted alphabetically in each category
- **Site Changes**
  - Display Staff ID on site pages in the directory
- **User Changes**
  - Admins can now associate a Staff ID with a user that will display in the
    directory and in the menu bar
- **Gem Changes**
  - Update to ruby 2.6.4
  - Update to rails 6.0.1
  - Update to carrierwave 2.0.2
  - Update to devise 4.7.1
  - Update to font-awesome-sass 5.11.2
  - Update to haml 5.1.2

## 4.0.0 (August 10, 2019)

### Enhancements
- **Report Changes**
  - Report pages without any reports now display a message
  - Descriptions can be added to reports that support markdown formatting
  - Left hand column of report tables now freeze when scrolling horizontally
  - Report rows can be marked as emphasized to group rows together visually
    - Subsequent rows are indented until the next emphasized row

## 3.0.0 (August 4, 2019)

### Enhancements
- **Admin Changes**
  - Admins now receive an email when a user confirms their account
- **General Changes**
  - Remove example reports from dashboard
- **Gem Changes**
  - Update to pg_search 2.3.0
  - Remove bootsnap

### Bug Fix
- Fix bug that prevented reports from being reordered on pages

## 2.0.0 (June 23, 2019)

### Enhancements
- **General Changes**
  - Update link to Slice
- **Reports Added**
  - Editors can create reports that pull data from Slice on a daily basis
  - Reports can be grouped on pages that users can see under the home tab on the
    dashboard
- **Gem Changes**
  - Update to ruby 2.6.3
  - Update to devise 4.6.2
  - Update to font-awesome-sass 5.8.1
  - Update to haml 5.1.1
  - Update to jbuilder 2.9
  - Update to pg_search 2.2.0

## 1.0.0 (April 11, 2019)

### Enhancements
- **Base Web Framework**
  - Clone of LOFT-HF v5.0.1
  - Rails for the web framework
  - Amazon AWS for hosting and continuous deployment
  - Travis CI for continuous integration testing
  - Devise for authentication
  - Bootstrap for user interface
  - Font Awesome for icons
- **Videos Added**
  - Editors can embed videos for users to view
- **Gem Changes**
  - Update to ruby 2.6.2
  - Update to rails 6.0.0.beta3
