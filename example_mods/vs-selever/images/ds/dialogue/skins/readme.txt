Dialogue skins go here

To start, just make a copy of "default" with the name of your new skin, then
open the text file called "layout" inside of it and edit the location, position
and appearance of each UI component on your skin.

Once you're done editing, trigger the following event with your skin's name in
order to use it:

  triggerEvent('dialogue.setSkin', 'myskin', '');

You are expected to do this right before triggering the 'startDialogue' event.