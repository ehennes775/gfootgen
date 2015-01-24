# gfootgen
Footprint Generator for PCB

## Installation
1. __Install the required packages.__ These packages should be avaialble from
your distro package manager.

  * ruby
  * ruby-atk
  * ruby-cairo
  * ruby-gdk3
  * ruby-gdk-pixbuf
  * ruby-gio2
  * ruby-glib2
  * ruby-gtk3
  * ruby-pango

2. __Obtain the source code to the footprint generator.__ Change the current
directory to a project folder, and use the following command to obtain source
from GitHub.

 ```sh
$ git clone https://github.com/ehennes775/gfootgen.git
```
3. __Build the gem.__

 ```sh
$ cd gfootgen
$ gem build gfootgen.gemspec
```
4. __Install the gem.__ Superuser access may be needed for installation.

 ```sh
$ sudo gem install gfootgen-0.0.1.gem
```

5. __Run the program.__ The following command line can be used to run the
footprint generator.

 ```sh
$ gfootgen
```

## Usage

1. __Select the desired footprint.__ To change the type of footprint, press the
Change button. Select the type of footprint from the dialog box and then press
OK.

2. __Edit the parameters in the left panel.__ Measurements accept both mil and
mm. Errors encountered while parsing a measurement prevent updating the
footprint. Common parameters for footprints include the following:

|Parameter|Description|
|-|-|
|Package Length|The dimension of the package on the x axis. Used to calculate the silkscreen border.|
|Package Width|The dimension of the package on the y axis. Used to calculate the silkscreen border.|
|Pad Length|The dimension of the copper pad on the x axis.|
|Pad Width|The dimension of the copper pad on the y axis.|
|Pad Spacing (BSC)|The dimension between pads on opposite sides of the device, from center to center. Negative values flip the pads of the device horizontally.|
|Pad Pitch (BSC)|The dimension between pads in the same row, from center to center. Negative values flip the pads of the device vertically.|
|Pin Count|The total number of pins/pads on the device.|
|Pad Clearance|The minimum distance from the copper pad to surrounding copper.|
|Pad Soldermask Relief|The minimum distance from the copper pad to the soldermask opening.|
|Silkscreen Package Offset|The additional distance from the edge of the package to the centerline of the silkscreen.|
|Silkscreen Pad Offset|The additional distance from the edge of the pad copper to the centerline of the silkscreen.|
|Silkscreen Thickness|The silkscreen line thickness.|
|Silkscreen Outline|Selects the type of outline for the footprint (e.g. polarized, non-polarized).|

3. __Check the footprint.__ The footprint generator provides both a text and
graphic preview in the right panel. These previews allow the user a preliminary
check for correctness.

4. __Export the footprint to a file.__ Press the Export button and save the
footprint to a file.
