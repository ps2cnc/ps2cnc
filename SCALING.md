# The truth about Inkscape scaling

There is more than a 99% chance that you are going to want to install and use Inkscape

[https://inkscape.org](https://inkscape.org)

Runs on linux, windows and mac.  The user interface changes some over time so I am using version 1.3.2,
you should be able to figure out the subtle differences.

The problem is not Inkscape.  The problem is we do not use all the same tools and/or in all the same ways.  In the main README.md for this repo, I already covered/hinted at the problems.  PostScript (PDF) is 72 points per inch.  SVG is not assumed to be, not even assumed to be points.  Consumers of SVG files (I mean software like a web browser, Inkscape, graphics tools, word processor, etc) are not expected to, and will demonstrate, make assumptions sometimes and/or make their own decisions on things, like dimensions. 

When I use the term bounding box, the "image" (set of paths as far as we are concerned) is some size, but the document defines how big the whole drawing is.  Often with some space around the sides of the image.  What you have seen from me thus far is the PostScript (tools I use) default of 8.5 by 11 inches or 612 x 792 points.  We are using SVG files because they define paths and we need something to define the paths of the things we want to cut out, not some image on a web page that wants to be able to be scaled as you grab the corner and change the height or width of the page.  Some of the CAM tools described in the README.md document and will be mentioned below, free tools, good tools, that fit in the price range of our hobby level work (free or very affordable), care about the bounding box. BUT...how YOU use that tool you might never know that.  Another person that tries to do things how you have demonstrated, may fail...(I expect to land in that category as well, I do not know everything, hopefully, you will at least see that there is value in examining things and experimenting, and you do not, you do not, you do not, have to actually have a machine, burn through many dollars worth of bits and wood, to sort out a high percentage of the problems.

A combination of the contents of an SVG and the user (you) will affect how these tools decide what units you are using.  You may click on mm (millimeters) on every step in Inkscape, save the file, open it with a CAM tool, and that 100mm by 100mm square becomes 100 inches by 100 inches.  And if you do not catch that and simply see 100 by 100, then, you might actually not catch that until your machine lifts the bit up and slams it into an end stop at the end of a rail.

The three CAM tools I am going to use are

jscut

[https://jscut.org](https://jscut.org)

[https://jscut.org/jscut.html](https://jscut.org/jscut.html)

Estlcam

[https://www.estlcam.de](https://www.estlcam.de)

OpenBuilds CAM

[https://cam.openbuilds.com](https://cam.openbuilds.com)

Estlcam is technically not free.  The free version is fully functional as described on the page, and I will let you figure out what happens when the trial period runs out.  The cost is affordable, if you use the tool, pay for it, get your license key and keep using it.

You may have only heard of one of them.  Yes, there are many others, free or otherwise, popular or otherwise.  This is more of an exercise in how YOU, can try to be successful with your tools and developing your process using them.  Or to overcome, the very painful failures that a beginner suffers through.

Lets start without inkscape, with a specifcally crafted design.

```
%!
%BoundingBox: 0 0 200 200
<< /PageSize [200 200] >> setpagedevice
72 72  moveto
72 144  lineto
144 144  lineto
144 72  lineto
closepath
stroke
showpage
```

![Alt text](./readme/100.png)

Starting with jscut.  You can skip trying it yourself, Ill provide the relevant files, images, or descriptions.

[https://jscut.org/jscut.html](https://jscut.org/jscut.html)

At the top Open SVG, and open 100.svg.  You will see the square.  

On the right side click Make all mm.  On the left side in the Tool box Diameter should change to mm 3.175.  We will just leave these numbers as is for this demonstration.

Click on one of the lines of the square.  The box turns blue.

Upper left click Create Operation.  Box turns black, it now has a new line with Pocket 3.175 Deep and a generate link.  

Click on pocket and change it to engrave.

Then click on Generate.

Lower right-ish click on Zero lower left.

Note that Max X and Max Y are 25.4 

144-72 = 72.  72 points is an inch.  One inch is 25.4 mm.  Which is what we wanted.

Save GCODE at the top.  Local file.

```
G21         ; Set units to mm
G90         ; Absolute positioning
G1 Z2.54 F2540      ; Move to clearance level

;
; Operation:    0
; Name:         
; Type:         Engrave
; Paths:        1
; Direction:    Conventional
; Cut Depth:    3.175
; Pass Depth:   3.175
; Plunge rate:  127
; Cut rate:     1016
;

; Path 0
; Rapid to initial position
G1 X25.4000 Y25.4000 F2540
G1 Z0.0000
; plunge
G1 Z-3.1750 F127
; cut
G1 X0.0000 Y25.4000 F1016
G1 X0.0000 Y0.0000
G1 X25.4000 Y0.0000
G1 X25.4000 Y25.4000
G1 X25.4000 Y25.4000
; Retract
G1 Z2.5400 F2540
M2
```

This is a success.  There is a process to follow in figuring things out.  Try to change as few things per experiment as you can...This would be fine as inches too, but others default to mm and want to try to produce compatible output.

Estlcam.  Now estlcam has some setup things that it remembers, so I hope that mine is not setup so different from yours that your experience is different.  At the same time we know the goal here is a square 25.4 mm on a side, cut along the square.

Start Estlcam and open the file.  I see an SVG Unit? dialog box.  And it has a checkbox on Point I click okay without changing it.

Click on Engraving on the left then click on the box.  The box lines turn red.

Do not need to mess with other settings.

File -> Save CNC program.  

A box for cutting depth, mine shows 1.00mm I just leave that and click okay.

I close the box that pops up and then exit the program.

```
(Project 100)
(Created by Estlcam version 11 build 11.245)
(Machining time about 00:00:08 hours)

(Required tools:)
(End mill 3mm)
G21
G90
G94
M03 S24000
G00 Z5.0000


(No. 1: Engraving 1)
G00 X0.0000 Y25.4000
G00 Z0.5000
G01 Z0.0000 F600 S24000
G01 Z-1.0000
G01 Y0.0000 F1200
G01 X25.4000
G01 Y25.4000
G01 X0.0000
G00 Z5.0000
G00 Y0.0000

M05
M30
```

Another success.

Notice so far, that while the "image" in all forms (PS, PDF, SVG) have a wide border around the box, the bounding box.  These two tools extrated the path(s) and defined the X and Y zero position of the output g-code based on the left and bottom of the path(s) not anything else.

Open builds cam, I first see a save project or start new.  I click start new.  I ignore, cancel, any select my machine stuff as I do not have one of their machines.  

Open drawing, open 100.svg

I had to zoom out but notice this user interface has a ruler with a zero corner, and this object is not in that corner.  The other two tools do not do this the zero definition is done in a different way.  Also note/realize that why this is out in space is because of the bounding box, if you mess with the bounding box you can have the same object move around.  If you did not realize this was a problem and you simply built this like this and zeroed your tool to the lower left of the material, it is not going to cut the square at that zero point, it is going to jump out into space, possibly missing the material or damaging the machine.  Inkscape helps here.

What you cannot see here, and I worked with this tool for days to try to fix this, somewhere I have the fix, but this tool does not assume 72 points per inch with a plain svg file.

If I click on the box, then left and up in the ruler window is a pointer, a four way pointer, four things, the fourth looks like a comb but it is a ruler.  AFTER selecting an object, click the ruler.  Go to position.  I see three columns.  The first has 23.1 for X and Y (note that should be 25.4, but anyway...Make those zeros and apply.  Now the box is lower left corner justified to the origin.  And now we can clearly see it is not 25.4 mm.

We can ignore that for a minute and going back to the pointer, reselect the square.

create toolpath using selected vectors

select operation, CNC: vector (no offset)  apply and preview (just leave the other settings,
yours may vary from mine depending on how much messing around was done previously)

Top left of page, settings.  and then the settings gearboxes and then advanced settings

Performance: Disable toopath preview and check that box (you are welcome, the difference between this being a usable and completely unusable tool).  Save

Generate gcode.

save gcode.

```
; GCODE Generated by cam.openbuilds.com on 2024-10-04 
G21 ; mm-mode
; Operation 0: CNC: Vector (no offset)
; Endmill Diameter: 1

G0 Z2; move to z-safe height
G0 F1000 X0.0025 Y0.0025

G0 Z0
G1 F100 Z-1.0000; Direct Plunge
 G1 F300 X23.8150 Y0.0025 Z-1.0000 S1000
G1 F300 X23.8150 Y23.8150 Z-1.0000 S1000
G1 F300 X0.0025 Y23.8150 Z-1.0000 S1000
G1 F300 X0.0025 Y0.0025 Z-1.0000 S1000
G1 F300 X0.0025 Y0.0025 Z-1.0000 S1000
; retracting back to z-safe
G0 Z2
```
23.81 is not 25.4.  It is not an inch.  Hmm also notice it is not quite in the corner the lower left is a smidge up and to the right (0.0025).  You could have a potentially unhappy experience with this if not paying attention.  

Before we fix this, lets try another.

```
%!
%BoundingBox: 0 0 200 200
<< /PageSize [200 200] >> setpagedevice
-36 -36 moveto
36 -36 lineto
36  36 lineto
-36 36 lineto
closepath
stroke
showpage
```

![Alt text](./readme/101.png)

So far I intentionally clipped outside the bounding box.  I dont need to complete the gcode in jscut to see it clipped the drawing...fail.

Estlcam has no issues, a nice one inch on a side box

```
(Project 101)
(Created by Estlcam version 11 build 11.245)
(Machining time about 00:00:08 hours)

(Required tools:)
(End mill 3mm)
G21
G90
G94
M03 S24000
G00 Z5.0000


(No. 1: Engraving 1)
G00 X0.0000 Y25.4000
G00 Z0.5000
G01 Z0.0000 F600 S24000
G01 Z-1.0000
G01 Y0.0000 F1200
G01 X25.4000
G01 Y25.4000
G01 X0.0000
G00 Z5.0000
G00 Y0.0000

M05
M30
```

openbuilds cam is happy-ish

```
; GCODE Generated by cam.openbuilds.com on 2024-10-04 
G21 ; mm-mode
; Operation 0: CNC: Vector (no offset)
; Endmill Diameter: 1

G0 Z2; move to z-safe height
G0 F1000 X-11.9062 Y-11.9062

G0 Z0
G1 F100 Z-1.0000; Direct Plunge
 G1 F300 X11.9062 Y-11.9062 Z-1.0000 S1000
G1 F300 X11.9062 Y11.9062 Z-1.0000 S1000
G1 F300 X-11.9062 Y11.9062 Z-1.0000 S1000
G1 F300 X-11.9062 Y-11.9062 Z-1.0000 S1000
G1 F300 X-11.9062 Y-11.9062 Z-1.0000 S1000
; retracting back to z-safe
G0 Z2
```

11.9062 + 11.9062 = 23.8124

Not quite an inch, but it did not clip on the bounding box, instead it, again, aligned the zero point of its ruler with the zero point of the SVG file.

Lets go back here first

```
%!
%BoundingBox: 0 0 200 200
<< /PageSize [200 200] >> setpagedevice
72 72  moveto
72 144  lineto
144 144  lineto
144 72  lineto
closepath
stroke
showpage
```

![Alt text](./readme/100.png)


If I change the generated SVG file from this

```
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="200pt" height="200pt" viewBox="0 0 200 200" version="1.1">
<g id="surface1">
<path style="fill:none;stroke-width:10;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 720 720 L 1440 720 L 1440 1440 L 720 1440 Z M 720 720 " transform="matrix(0.1,0,0,-0.1,0,200)"/>
</g>
</svg>
```

To this

```
<?xml version="1.0" encoding="UTF-8"?>
<svg 

   inkscape:version="1.3.2 (091e20e, 2023-11-25)"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"

xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="200pt" height="200pt" viewBox="0 0 200 200" version="1.1">
<g id="surface1">
<path style="fill:none;stroke-width:10;stroke-linecap:butt;stroke-linejoin:miter;stroke:rgb(0%,0%,0%);stroke-opacity:1;stroke-miterlimit:10;" d="M 720 720 L 1440 720 L 1440 1440 L 720 1440 Z M 720 720 " transform="matrix(0.1,0,0,-0.1,0,200)"/>
</g>
</svg>
```

Fixing the position which is now 25.4 off of zero

```
; GCODE Generated by cam.openbuilds.com on 2024-10-04 
G21 ; mm-mode
; Operation 0: CNC: Vector (no offset)
; Endmill Diameter: 1

G0 Z2; move to z-safe height
G0 F1000 X-0.0000 Y-0.0000

G0 Z0
G1 F100 Z-1.0000; Direct Plunge
 G1 F300 X25.4000 Y-0.0000 Z-1.0000 S1000
G1 F300 X25.4000 Y25.4000 Z-1.0000 S1000
G1 F300 X-0.0000 Y25.4000 Z-1.0000 S1000
G1 F300 X-0.0000 Y-0.0000 Z-1.0000 S1000
G1 F300 X-0.0000 Y-0.0000 Z-1.0000 S1000
; retracting back to z-safe
G0 Z2
```

And I get a 1 inch on a side square, 25.4mm... Like I wanted.

What gives?   Inkscape knows this was a one inch on a side square, and jscut and we can tell estlcame it is but we cant tell openbuilds cam without doing a scaling.  The default, if you are not an SVG creator I know (very short list) then I am not going to default to 72 points per inch I am going to use some other value (easily changed in the openbuilds cam source code).

But if I detect inkscape AND a version greater than some version where inkscape started assuming 72 points per inch THEN I will use 72 points per inch and we get 25.4 mm.

What is the whole fix for both of these problems?

Lets take this one.

```
%!
%BoundingBox: 0 0 200 200
<< /PageSize [200 200] >> setpagedevice
-36 -36 moveto
36 -36 lineto
36  36 lineto
-36 36 lineto
closepath
stroke
showpage
```

![Alt text](./readme/101.png)

Your inkscape may have a subtle difference than mine, but...

Open this svg file in inkscape.

Click in or near the square.

You will get a dashed line around the border with arrows pointing on the sides and in the corners toward the middle, dont mess with those.  

File -> Document Properties

Look for something called resize to content, click on it.

File->Save As

Select Inkscape SVG as the file type.

And pick a different name 101ink.svg...or whatever.

Exit out of inkscape (sometimes it asks you to save, if you already saved then skip out of that).

```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   width="73pt"
   height="73pt"
   viewBox="0 0 73 73"
   version="1.1"
   id="svg1"
   sodipodi:docname="101ink.svg"
   inkscape:version="1.3.2 (091e20e, 2023-11-25)"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <defs
     id="defs1" />
  <sodipodi:namedview
     id="namedview1"
     pagecolor="#505050"
     bordercolor="#eeeeee"
     borderopacity="1"
     inkscape:showpageshadow="0"
     inkscape:pageopacity="0"
     inkscape:pagecheckerboard="0"
     inkscape:deskcolor="#505050"
     inkscape:document-units="pt"
     inkscape:zoom="3.315"
     inkscape:cx="181.74962"
     inkscape:cy="-84.766214"
     inkscape:window-width="1920"
     inkscape:window-height="1123"
     inkscape:window-x="0"
     inkscape:window-y="26"
     inkscape:window-maximized="1"
     inkscape:current-layer="svg1" />
  <g
     id="surface1"
     transform="translate(36.5,-163.5)">
    <path
       style="fill:none;stroke:#000000;stroke-width:10;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-opacity:1"
       d="m -360,-360 h 720 v 720 h -720 z m 0,0"
       transform="matrix(0.1,0,0,-0.1,0,200)"
       id="path1" />
  </g>
</svg>
```

A lot more junk in the file and that 73pt by 73 looks wrong, but lets run with it.

Jscut is happy

```
G21         ; Set units to mm
G90         ; Absolute positioning
G1 Z2.54 F2540      ; Move to clearance level

;
; Operation:    0
; Name:         
; Type:         Engrave
; Paths:        1
; Direction:    Conventional
; Cut Depth:    3.175
; Pass Depth:   3.175
; Plunge rate:  127
; Cut rate:     1016
;

; Path 0
; Rapid to initial position
G1 X25.4000 Y25.4000 F2540
G1 Z0.0000
; plunge
G1 Z-3.1750 F127
; cut
G1 X0.0000 Y25.4000 F1016
G1 X0.0000 Y-0.0000
G1 X25.4000 Y-0.0000
G1 X25.4000 Y25.4000
G1 X25.4000 Y25.4000
; Retract
G1 Z2.5400 F2540
M2
```

One inch square, lower left justified.

Estlcam is happy

```
(Project 101ink)
(Created by Estlcam version 11 build 11.245)
(Machining time about 00:00:08 hours)

(Required tools:)
(End mill 3mm)
G21
G90
G94
M03 S24000
G00 Z5.0000


(No. 1: Engraving 1)
G00 X0.0000 Y25.4000
G00 Z0.5000
G01 Z0.0000 F600 S24000
G01 Z-1.0000
G01 Y0.0000 F1200
G01 X25.4000
G01 Y25.4000
G01 X0.0000
G00 Z5.0000
G00 Y0.0000

M05
M30
```

One inch square, lower left justified.

OpenBuilds CAM is close

```
; GCODE Generated by cam.openbuilds.com on 2024-10-04 
G21 ; mm-mode
; Operation 0: CNC: Vector (no offset)
; Endmill Diameter: 1

G0 Z2; move to z-safe height
G0 F1000 X0.1764 Y0.1764

G0 Z0
G1 F100 Z-1.0000; Direct Plunge
 G1 F300 X25.5764 Y0.1764 Z-1.0000 S1000
G1 F300 X25.5764 Y25.5764 Z-1.0000 S1000
G1 F300 X0.1764 Y25.5764 Z-1.0000 S1000
G1 F300 X0.1764 Y0.1764 Z-1.0000 S1000
G1 F300 X0.1764 Y0.1764 Z-1.0000 S1000
; retracting back to z-safe
G0 Z2
```
One inch square, but not lower left justified.  A fraction of an mm off.

Lets think about this what is that 73point thing?

73 points is 1.0138888 inches, or 25.7527777 mm.

25.752777 - 0.1764 = 25.576377


If we hack up that svg file like this

```
3,5c3,5
<    width="73pt"
<    height="73pt"
<    viewBox="0 0 73 73"
---
>    width="72pt"
>    height="72pt"
>    viewBox="0 0 72 72"
37c37
<      transform="translate(36.5,-163.5)">
---
>      transform="translate(36,-164)">
```

And OpenBuilds CAM makes us happy

```
; GCODE Generated by cam.openbuilds.com on 2024-10-04 
G21 ; mm-mode
; Operation 0: CNC: Vector (no offset)
; Endmill Diameter: 1

G0 Z2; move to z-safe height
G0 F1000 X0.0000 Y0.0000

G0 Z0
G1 F100 Z-1.0000; Direct Plunge
 G1 F300 X25.4000 Y0.0000 Z-1.0000 S1000
G1 F300 X25.4000 Y25.4000 Z-1.0000 S1000
G1 F300 X0.0000 Y25.4000 Z-1.0000 S1000
G1 F300 X0.0000 Y0.0000 Z-1.0000 S1000
G1 F300 X0.0000 Y0.0000 Z-1.0000 S1000
; retracting back to z-safe
G0 Z2
```
One inch square, lower left justified.

I was hoping to have that fixed before the next step but that was interesting.  Estlcam and jscut take the meat of the path information and run with it

```
    <path
       style="fill:none;stroke:#000000;stroke-width:10;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:10;stroke-opacity:1"
       d="m -360,-360 h 720 v 720 h -720 z m 0,0"
       transform="matrix(0.1,0,0,-0.1,0,200)"
       id="path1" />
```

And let us choose how to justify all of it.  OpenBuilds CAM consumes more of the file.

I know what is going on but you may be baffled at this point...

Lets go back to this...

```
%!
%BoundingBox: 0 0 200 200
<< /PageSize [200 200] >> setpagedevice
72 72  moveto
72 144  lineto
144 144  lineto
144 72  lineto
closepath
stroke
showpage
```
![Alt text](./readme/102.png)






