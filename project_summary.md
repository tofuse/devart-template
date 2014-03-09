###TCGA
by Christian Iten, tofuse

####Prologue

Back in 2010 I had the following idea:
The information stored in the human dna is represented by a nearly endless sequence of only four different letters: T, C, G and A. What if I interpret those four letters as drawing directions: T means one step up, C one step to the right, and so on. This way the whole dna could be visualised. How does it look like? Are there emerging patterns? Could that idea even have scientific relevance?
Back then early experiments showed interesting results, however I lost focus on it somehow. On occasion of the DEVART initiative I think its time to explore this idea again.

####Goal of this project (as of 9th of march)

I’m driven by curiousness. As for now, I have no specific end result in mind. I assume that a large image will develop, a dna map. This could be made accessible to the public through google maps. 

####Pseudo Code to draw the dna according to main idea

```
dna = loaddata();
canvas = createCanvas();
for each letter in dna{
	switch (letter) {
		case 't':
	  		currentPos.add(0,-1);
	  		break;
		case 'c':
		  	currentPos.add(1,0);
		  	break;
		case 'g':
		  	currentPos.add(0,1);
		  	break;
		case 'a':
		  	currentPos.add(-1,0);
		  	break;  
		default:
		  	break;
		}
	}
	canvas.lineto(currentPos);
}		    
```
####Tools

To draw the map, I'll start with proce55ing
(http://www.processing.org "www.processing.org")


