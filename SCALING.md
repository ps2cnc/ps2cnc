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






