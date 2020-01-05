# Design Justification
## High Level Architecture


### What is Cancer?
* Each SKS Scene contains info for the different scenes (GoalScene, GameScene, MenuScene, LevelsScene)
* The GameScene currently stores all properties related to the actions of the fish, the timer counter, the health bar function, the tracking score function, and the game logic (onTouch functions). In the upcoming sprint, this will be broken down into subsequent classes to improve code efficiency. 

### What is a Central Line?
* Each scene file contains information for a different view, including views for the introductory scenes, game store scene, and the gameplay scene
* The Player class currently stores all properties relating to game stats, player image sprite, movement, and other physics behaviors
* GameScene class controls game logic, detects user input, and updates the gameplay environment accordingly
* Different types of obstacles, such as Rubble and Wall, inherit superclass Obstacle
* Store items, such as powerups and future player appearance item inherit superclass StoreItem
* Each powerup, from the store or spawned in the game, implements the PowerUp protocol

## Design Goals

* Create different classes to adhere to our method of using the view, model, and controller design pattern


* **What Is Cancer**: Allow future developers to add new objects and sprites to the game, including:
    * Different types of fish
    * New powerups
    * New levels

* **What Is Cancer**: Allow future developers to modify game parameters without changing existing code, including:
    * Speed of fish
    * Variance of movement patterns for fish
    * Score received when fish are tapped
    * Time allotted
    * Health allotted
    * Fish spawn patterns and spawn rates
    * Different backgrounds and cosmetics
    * Duration and strength of the powerup

* **What Is Cancer**: Move the appropriate functions and variables to the right classes
    * Move counters and mechanics for score, health, etc. into a separate model class
    * Move onTouch functions, etc. into a separate controller class

* **What is a Central Line**: Allow future developers to easily add new types of objects to the game without modifying or writing new code, including:
    * Power-ups
    * Obstacles spawned in game
    * Collectables, such as different coin types
    * Game store items, such as "skins"
    * New game scenes
    * Multiple users
    * Different player characters with unique in-game powers
* **What is a Central Line**: Allow future developers to easily modify game parameters without modifying code, including:
    * Sprite images
    * Background images
    * Spawn rates
    * Game physics parameters
    * Win/failure conditions for game
    * Properties of powerups, collectables, and obstacles

## Design Assumptions: What will not be changed?
### What is Cancer?
* The orientation and display of the original objects and models (health, timer, etc) shouldn't be changed.
* The user inputs of the games (button actions, tapping behaviors). 
* Exit conditions - time running out and health running out should be the only aspects that determine that end the game
* Victory conditions - the score goal being reached should determine that the user has 'won' the game

### What is a Central Line?
* Basic game physics will not change - the player will still horizontally and lift upon screen press
* Failure condition - health should be the only stat that determines user failure
* The game store will require the user to exchange some items collected in-game to buy store items

## Significant Design Decisions

## What is Cancer?
    
1. **The issue requiring a decision** 
    If we would use any kit to help us code the games. 
    
    **The choice that was ultimately made**
    We decided to use SpriteKit. 
 
    **The justification for the choice**
    Because it would help us with setting up the sprites we would need for the games. 


3.  **What is Cancer game:** 
    **The issue requiring a decision** 
    Whether to convert the fish into physicsbodies to enhance movement
    
    **The choice that was ultimately made**
    Fish would not be physicsbodies and would remain as SKSpriteNodes and follow a randomized, predetermined, sinusoidal path
    
    **The justification for the choice**
    Physicsbodies would collide into each other and would require more notation, and forcefields applied onto physicsbodies would be buggy and inconsistent. Following a sinusoidal path resulted in a smooth and consistent movement pattern.
    
    **The other alternatives considered**
    Fish could become physicsbodies not affected by gravity or collisions, and random turbulence fields could appear to induce changes in movement
    Fish could stay as SKSpriteNodes and use the linear moveTo method
    
    **The trade-offs evaluated**
    Having to look into physicsbodies and refactor the rest of the code to deal with them, as well as investigate how to fix our bugs with force fields vs. more predictable movement on a pre-defined path
    
    **Any assumptions that may have had an impact on the decision**
    N/A
    
    **Any dependencies on the decision that impacted other issues**
    N/A
    
4. 
    **The issue requiring a decision** 
    Difficulty should be able to be modified in the future in an accessible manner
    
    **The choice that was ultimately made**
   Have all of the parameters predefined, only when they are used

    **The justification for the choice**
    We didin't look into reading into files for this sprint, and were focused more on gameplay and functionality than extensibility. However, we will switch to our preferred method of using an xml file for this current sprint.

    **The other alternatives considered**
    Difficulty (in terms of relevant game parameters) should be written in a xml file and the game will read the relevant parameters from that file (preferred).
    Have all of the parameters in the respective files as variables that could be modified.

    **The trade-offs evaluated**
    Ease of future modifications (go into an xml file and change some game parameters, rather than having to go into the code itself) vs. other features that were prioritized for this sprint (enhanced functionality)

    
## What is a Central Line?

1. 
    **The issue requiring a decision** 
    Powerups needed to be available as store items and as collectables spawned in-game.
    **The choice that was ultimately made**
     Every powerup, regardless of how the user obtains it, implements the PowerUp protocol, which requires implementation of the deploy() method.
     Each powerup is then stored in an array in the Player class and deploy() is called on each, either in the beginning of the game or when they are collected.
    **The justification for the choice**
    Easier to deploy and store powerups when they all implement the same method. Making the PowerUp protocol also allows powerups to inherit different superclasses.

    **The other alternatives considered**
    Making a PowerUp superclass with subclasses for StoreItem and in-game powerups. 
    
    **The trade-offs evaluated**
    This would add unnecessary properties to all StoreItems, since not all store items have to be powerups. 
    
2. **The issue requiring a decision** 
    How to handle StoreItem objects. 
    **The choice that was ultimately made**
    StoreItem objects currently contain view information as well as a model for the item. The StoreItem is displayed in the GameStore then added into either the Player's PowerUps array or array for cosmetic items.
    
    **The justification for the choice**
    By tying together the view and model of a store item, we avoid using multiple conditional statements to determine which items are added to the Player inventory based on the item sprite that they select. 
    
    **The other alternatives considered**
    Using a controller that contains a view to represent the store item in the game store as well as containing the storeItem model that will actually be added to the Player inventory and deployed as appropriate.
    
    **The trade-offs evaluated**
    Due to time constraints in sprint 3, we prioritized functionality over certain design considerations. We plan on refactoring the class and using the alternative described above in sprint 4.
    
3. **The issue requiring a decision** 
    How do we represent a view?
    **The choice that was ultimately made**
    We chose a scene file, from SpriteKit, to represent each view in the game, including the introductory scenes, the gameplay scene, the game store scene, and the end screen. Logic relevant to the transition to and from each scene is also contained in the scene file.
    **The justification for the choice**
    We did not consider extensibility of game scenes in our initial design planning. 

    **The other alternatives considered**
    Using a gamescene controller that controls transitions between scenes, storing other scene information (images, image positions) in a resource file that is read by a factory class to generate new scenes. Creating separate classes to represent the view, the model, and a controller to interpret user input.  
    
    **The trade-offs evaluated**
    The alternative would be more extensible because new scenes could be created without modifying existing code. Views could also be changed without modifying model code. Due to time constraints in sprint 3, we did not implement the alternative, but we plan on refactoring to implement it in sprint 4.