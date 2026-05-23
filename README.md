# AutoSizeText
Autosize text in labels and text boxes for Godot, just like in Unity.

## About
I was always missing the Unity function of auto-sizing text inside labels/text fields in Godot.  
Intentionally made in GDScript to provide maximum compatibility (even in some of our GDScript only projects).  
Just use the provided UI elements in your project.  

## Features
* Font Auto Size: Change Font-Size between two numbers
* Font Step Size: Change Font-Size based on pre-defined numbers

## Implemented
* Label
* Button
* CheckButton
* CheckBox
* RichTextLabel
* TextEdit
* LineEdit

### WIP


## TODO

### Controls
* MenuButton
* OptionButton

### Features
* Step-Size based on theme
* Auto-Size numbers based on theme

## Know Issues
Overriding existing variables when inheriting doesnt work, see:  

* https://github.com/godotengine/godot-proposals/issues/7593
* https://github.com/godotengine/godot-proposals/issues/338

therefore some hacks and workarounds are needed.

## Contribute
Please try to adhere to the GDScript style guidelines https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html.  
States that are considered "stable" enough will get a git-tag and be released to the Godot Asset Library.  
In the future I'd like merge requests and development on the development branch, but since it's currently "moving fast" I don't care so much (yet).  

## OTHER
Godot Asset Store: https://store.godotengine.org/asset/spielmannspiel/autosizetext/  
Godot Asset Library (deprecated): https://godotengine.org/asset-library/asset/3843  
GitHub: https://github.com/SpielmannSpiel/AutoSizeText  
by bison - SpielmannSpiel https://spielmannspiel.com  
