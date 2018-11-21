# hw08-seed

This repo contains the BC Liquor app as a boilerplate for students to add to in Homework 08.

The code and data are from [Dean Attali's tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial). The code can specifically be found [here](https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code).

This app allows users to search and filter the BC Liquor Store product list for products of a given price range, alcohol of a certain type (Beer, Refreshment, Spirits, Wine), and their country of origin. The app displays the number of results found, a table containing data on all products matching the user's selections, and a histogram illustrating the distribution of alcohol content found in the results. Users can also sort the result table by lowest price first.

# Elements added by @acheng-ubc to this Shiny app for Assignment 8
1. Added BC Liquor Store logo on title panel
1. Tables and Plots do not render if Filtered Data has no results
1. Added option to sort Price Table in ascending order by price
1. Added text stating how many results were found

A link to this shiny app can be found [here](https://acheng.shinyapps.io/bcl-app/)