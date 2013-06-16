Analysis and Modeling tool for layered photoshop documents
=========

##1. Introduction
This web application has two main goals:
* create a modular layer based model of the paintings
* implement behavioral algorithms by leveraging the layered model

These goals are only clear in the initial phase of development, and the resulting framework can be potentially extended into other areas.
The framework can be used in tandem with , https://github.com/raedatoui/Cellule, to power future animated paintings and extend to other medium such as sound.
The algorithmic animations could also be extended to include interactivity from viewers, leveraging sensors and other input devices.


##2. Modeling and data structures
The paintings are realized as large photoshop documents, with a large amount of layers, loosely organized and without any structural convention.
Once the first Cinder prototype was created, it became clear that some hierarchical structure was required to organize all these layers in order to facilitate and automate their rendering in a real time environment.
Figures consist of a number of grouped layers, which in turn are repeated and conglomerated in groups that were semantically related.

The proposed model is a hierarchical tree structure in the first place, leveraging a series of simple rules in order to e a fairly deep and complex organization.
Each layer is represented as an object, which can be of different types. An object can be a simple color region, a single graphic, or a graphic that is repeated in circular fashion.

This infinitely nested tree is the ideal data structure for representing the layers of a painting. As such, complete and modular control can be applied to any object or to any group of objects, allowing for flexibility in animating and modifying the properties of these objects. 

![alt tag](http://generator.raedatoui.com/eyebeam1.png)


![alt tag](http://generator.raedatoui.com/eyebeam2.png)


##3. Algorithms for behavior 
Once this structure is established, additional functionality will be added in order to view this model from a different perspective
and allow a better analysis of the painting and its potential behavior
The application is not only concerned in 2d modeling and adding a timeline, but also allowing the creation of unforeseen connections between the different parts of the piece.

Once the various sub parts of the painting are represented as reusable symbols, new possibilites can be explored where the painting can change configuration in space and time. The painting then serves as a starting point to a configurable machine where symbols can be rearranged and modified and new behaviors can be acquired over time. 

Each individual symbol will have an inherent set of rules that will dictate its behavior over time, but these rules can be input to other sets of rules in the system.  The intention is to create a flexible matrix where symbols exchange information, control each other and manifest various tensions and harmonies.

This behavior, which is contingent on multiple entry and exit points, would become very hard to precisely and accurately reproduce, giving the machine an organic nature.

##4. Further explorations
This model can also be applied to sound. Although the nature of sound is not additive similarly to graphics and images, symbols can possess sound properties that can be altered over time, while following the hierarchical tree structure.
On the other hand, the framework can also be extended to include various modes of interactivity where users can alter and impact the behavior of the machine and participate in producing new affects and perceptions
