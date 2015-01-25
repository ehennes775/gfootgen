# gfootgen
Footprint Generator for PCB

## Installation
1. __Install the required packages.__ These packages should be avaialble from
your distro package manager.

  * ruby
  * ruby-atk
  * ruby-cairo
  * ruby-gdk3
  * ruby-gdk-pixbuf2
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

 * __Package Length.__ The dimension of the package on the x axis. The
   footprint generator uses this value to calculate the silkscreen border.
 * __Package Width.__ The dimension of the package on the y axis. The footprint
   generator uses this value to calculate the silkscreen border.
 * __Pad Length.__ The dimension of the copper pad on the x axis.
 * __Pad Width.__ The dimension of the copper pad on the y axis.
 * __Copper Diameter.__ The diameter of the copper pad for through hole pins.
 * __Drill Diameter.__ The the diameter of the hole for through hole pins.
 * __Pad Clearance.__ The minimum distance from the copper pad to adjacent
   copper.
 * __Pad Soldermask Relief.__ The minimum distance from the copper pad to the
   soldermask opening.
 * __Pad Spacing (BSC).__ The dimension between rows of pads on opposite sides
   of the device, from center to center. Negative values exchange positions of
   the rows.
 * __Pad Pitch (BSC).__ The dimension between pads in the same row, from center
   to center. Negative values reverse the order of pads in the row.
 * __Pin Count.__ The total number of pins/pads on the device.
 * __Silkscreen Package Offset.__ The additional distance from the edge of the
   package to the inner edge of the silkscreen. To place the silkscreen
   centerline at the edge of the package, use the silkscreen line thickness
   divided by -2.0.
 * __Silkscreen Pad Offset.__ The additional distance from the edge of the
   copper pad to the inner edge of the silkscreen.
 * __Silkscreen Thickness.__ The silkscreen line thickness.
 * __Silkscreen Outline.__ Selects the type of outline for the footprint (e.g.
   polarized, non-polarized).
 * __Label Offset.__ The dimension between the centerline of the silkscreen
   border to the insertion point of the label text.


3. __Check the footprint.__ The footprint generator provides both a text and
graphic preview in the right panel. These previews allow the user a preliminary
check for correctness.

4. __Export the footprint to a file.__ Press the Export button and save the
footprint to a file.

5. __Verify the footprint.__ With the PCB design completed, print the layout at
1:1 on paper. Place the components on their footprints and ensure correct fit.
