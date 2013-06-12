Analysis and Modeling tool for layered photoshop documents
=========

##1. Introduction
This web application has two main goals:
* create a modular layer based model of the paintings
* implement behavioral algorithms by leveraging the layered model

These goals are only clear in the initial phase of developement, and the resulting framework can be potentially extended into other areas


##2. Modeling and data structures
The pantings are realized as large photoshop documents, with a large amount of layers, loosely organized and without any structural convention.
Once the first Cinder prototype was created, it became clear that some hierarchical structure was required to organize all these layers in order to facilitate and automate their rendering in a real time environment.
Figures consist of a number of grouped layers, which in turn are repeated and conglomerated in groups that were semantically related.

The proposed model is a hierarchical tree structure in the first place, leveraging a series of simple rules in order to e a failry deep and complex organization.
Each layer is represented as an object, which can be of different types. An object can be a simple color region, a single graphic, or a graphic that is repeated in circular fashion.

This infinitely nested tree is the ideal data structure for representing the layers of a painting. As such, complete and modular control can be applied to any object or to any group of objects, allowing for flexibility in animating and modifying the properties of these objects. 

##3. Algorithms for behavior 
Once this structure is established, additional functionality will be added in order to view this model from a different perspective
and allow a better analysis of the painting and its potential behavior
The application is not only concerned in 2d modeling and adding a timeline, but also allowing to create unforseen connection between the different parts of the piece
