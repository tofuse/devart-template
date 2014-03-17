#####Mar 15 2014 First test 3D Printing part of the data tcga_i6_2

!["base of 3d model"](../project_images/baseof3dmodel.png "base of 3d model")

!["first test in cura"](../project_images/cura0.png "first test in cura")


**code** 
this is how the 3D model is created:
(processing library in use: http://n-e-r-v-o-u-s.com/tools/obj/)


```
beginRecord("nervoussystem.obj.OBJExport", dateString+"_"+scaleFactor+"_"+"mrna"+".obj"); 
    
  scale(1, 1, 1);
  for (int i = 0; i < context.pixels.length; i++) {
    // data is an array analog to context pixels, it stores amount of draw-overs for every pixel.
    int height = min(max(0, int(float(data[i]) * scaleFactor)), context.width);
    
    if (height >=  1 && height < (float(context.width) *0.25)) {
      int x = i % context.width;
      int y = (i - x) / context.width;
      pushMatrix();
      translate(x,y,+float(height)*0.5);
      box(1,1,-height);
      popMatrix();
    }
  } 
  
endRecord(); 
```

**printing pipeline** the .obj file is opened in cura: https://www.ultimaker.com/pages/our-software and then printed. I added a so called "raft" to the model (grid structure at the bottom) helps make it more robust when handeled.


![100x100px test data](../project_images/printing1.png "100x100px test data")

![3D view of model in cura](../project_images/cura1.png "3D view of model in cura")

**3d printing** printer: ultimaker original.  picture shows a print with a voxelsize of 1x1x1 mm. (means 10000px image would be a 3D model of  10x10m in size) 1x1x1mm looks like the size that looks more or less good.

![3D view of model in cura](../project_images/3dprinting.jpg "3D view of model in cura")


it becomes clear that the 3D model -if its made out of cubic voxels - is much larger in height than it is in width and height. 

this leads to new thoughts about the presentation:

!["presentation of 3d model" ](../project_images/sketch0_3D.png "presentation of 3d model")
a piece of size 3x3m

!["presentation of 3d model cut through" ](../project_images/sketch2_3D.png "presentation of 3d model")
cut through, show a part only, instead of the whole.

!["presentation of 3d model"](../project_images/sketch4_3D.png "presentation of 3d model")
:)


