## Release_Notes

### Bugs

#### Central Line
* Assets fail to load after traveling an arbitrary distance.
* Hitboxes for fish and walls are slightly different from the size of the actual sprites
* "Buy" button next to each item description in the *most recent game store design* does not register user presses and as a result, users are unable to purchase store items.
    * Previous game store designs are functional.

#### Cancer
* The pop up graphic that appears when the goal has been reached to let the user know a difficulty or level has been unlocked continues to appear even though it was already unlocked. 

### Assumptions
Game layout is designed for use on the 9.7-inch iPad Pro, regardless it works with the other iPad Pro's and the iPad Air (3rd generation), the layout has not been tested for mobile devices. We are assuming that users will have access to an iPad to play this game, as the Doctors said in our initial meeting. 

### Limitations
Game layout does not appear the same on mobile devices since we only designed for display on an iPad. 

### Testing
* The app has been tested on an iPad and emulated iPad using  automated, manual, and user testing. 
* The CI/CD pipeline should be updated by changing .gitlab-ci.yml at the top of the repo. A new, custom runner should also be added.
