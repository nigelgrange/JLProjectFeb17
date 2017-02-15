# JLProjectFeb17

This is a demonstration projct for John Lewis to show the range of dishwashers.

It is designed as a simple two view-controller project, with the design in the main storybaord.

Main view controller:
- This contains a collection view with a cell for each product.

Detail view controller:
- The detail elements - slideshow, price, product information and features - are implemented as table view cells. This allows elements to be added or removed dynamically.
- The view controller contains two tables, to allow elements to be moved to between the two tables.
- Landscape and portrait layouts are achieved by changing the width of the side table (which contains the price in landscape layout) and adding or removing the price element from the main table.

Third-party components:
- The following third-party cocoapods are used by this project. These components already contain well-tested functionality that I considered to be outside of the development scope of this task.
- Haneke - An asynchronous / caching image loading component, with categories for UIImageView
- ImageSlideshow - This provides the scrolling image component used for the detail view
- GONMarkupParser - This allows NSAttribuetdStrings to be constructed from markup text. Though not strictly a HTML parser, it can also be used to parse tags in HTML content. This is used for the description / price label in the overview cell, as well as the price / guarantee information cell and the product description cell.


Known issues:
- Text does not word-wrap correctly in the Price / Guarantee cell. It should be possible to fix this by adding the correct paragraph wrpaping attributes to the string.

