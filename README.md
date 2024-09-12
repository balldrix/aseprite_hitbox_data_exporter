# Aseprite Hitbox Data Exporter

Aseprite Hitbox Data Exporter is an Aseprite Script to turn animation cel bounds into hitbox data.

There is no inbuilt way of adding hitboxes to aseprite animations. Using slices is a solution but I prefer to draw mine with transparent colours.

With this solution you can have a layer for each hitbox type, with the option of using any name you wish, and the script will create a json file with the cel bounds data, sorted by tag name.

There is a limit to 3 layers (Pushbox, Hitbox and Hurtbox) as these are the most common hitbox types.

## Installation
Download the zip file from the releases page and extract the files to your Aseprite scripts folder. Usually found at C:\Users\<username>\AppData\Roaming\Aseprite\scripts

## How to use
Just run the script from the Aseprite File->Scripts menu.
The dialogue will ask for the exported file location and names of your layers. Clicking ok will create a json file with array of the following data:

````
{
  "hitBoxName": "pushbox",
  "tagData": [
    {
      "animationName": "idle",
      "frames": [
        {
          "bounds": {
            "height": 4,
            "x": 48,
            "y": 43,
            "width": 17
          },
          "frameIndex": 0
        },
        {
          "bounds": {
            "height": 4,
            "x": 48,
            "y": 43,
            "width": 17
          },
          "frameIndex": 1
        }
      ]
    }
}
````

Note that the frame index is the indexed value of the frame in the tagged animation set, not the frame number of the aseprite timeline.

I've included an example file ''''example.json'''' so you know what to expect.
