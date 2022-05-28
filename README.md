
# UI Style Guide

## Color palette
The website uses three primary colors which were derived from the optimal scans logo:
1. Green:  `#A3AF00`
2. Blue:   `#1998F6`
3. White:  `#FFFFFF`

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/palette1.png)

We have used other colors in specific parts of the websites as well:
1. Yellow in the Error Page: `#ffff00`
2. Light Blue Gradient used in the "Vragen": `linear-gradient(to right, #00d2ff 0%, #3a7bd5 100%)`
3. Shadows used: `#d1dbe7`

The colours palette of the pyramid and the sunflower are:
1. `#A00000`
2. `#FAAA19`
3. `#A0AF00`
4. `#1E96FA`
5. `#325AAA`

## Typography
The [system-ui](https://www.free-fonts.com/system-ui) and [Lato sans-serif](https://befonts.com/lato-sans-serif-font-family.html) font family is used throughout the whole website. We used the standard HTML heading tags for the headings and the default HTML paragraph font size for questions and answer text.

## UI elements (Bootstrap version and elements used) used (and for what things)

The frontend of the website heavily use the [bootsrap5.2](https://getbootstrap.com/docs/5.0/getting-started/introduction/) library. The "Vragen", "Dashboard", "Error-Page", "Navigation-Bar" and "Logout-Page" all have been designed using this library. We used the following sources in the head tag of the respective HTML files and installed boostrap5 in our poetry file.
The page is first split into an appropriate combination of columns and rows using the [grid system](https://getbootstrap.com/docs/5.0/layout/grid/) grid system, boostrap5 offers. These "boxes" are then converted to [flexbox containers](https://getbootstrap.com/docs/5.0/utilities/flex/) where we can enter the components of the respective pages. By using bootstrap the UI adapts to any screen size and avoids nasty unreadable UI.

### Dashboard UI
The grid box layout of the Pyramid dashboard starts with a row containing the theme-progress bar heading "Voortang Bentwoording" and two bootstrap buttons on the left to download the report and to get the score per sub-theme. The rest is split into three main columns that comprise the theme-progress bars, the theme pyramid, and the percentage panel. 

Each progress bar and pyramid level is its own flexbox container. The percentage panel is its own flexbox container. We stuck to using the basic HTML entity codes for the green tick: `&#10004`, red-circle: `&#128308` and percentage-sign: `&#37`.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/pyramid.png)

In the sunflower version the middle column is further split into three columns where each column the required number of circles making up the petals of the sunflower. Each circle is a flexbox button.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/sunflower.png) 


### Vragen UI
The "Vragen"(scan page questionnaire) is entirely based on bootstrap. We do not use a grid layout and each question type is its own flexbox container. We used glassmorphism to make the rounded rectangles for each question and heading boxes for all questions. The buttons that allow the user to navigate to different themes are all bootstrap-based. 

The questionnaire comprises four question types: open, radio, checkbox, and checkbox which all use the respective default bootstrap5 input type. The scan progress bar uses a flexbox container and is stuck to the bottom of the screen as the user fills out the page via the CSS sticky tag. The progress bar incorporates a bootstrap flexbox container and striped bootstrap transformation for the animation. 

The update_progress_bar() function in script.js increments the width of the progress as questions are filled. The page ends with two bootstrap primary buttons “Opslaan” or “Vestuur” resulting in the auto-save pop-up to inform the user of the status of his questionaire progress.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/vragen.png)

### Error-Page UI
The error page is comprised of nested boostrap collumns and is visually enhanced using glassmorphism. The danger-triangle was desighened using a filter tag and the message box is contructed using boostrap bubbles. The error page displays the error codes and messages for the respective errors. 

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/error-page.png)

## Iconography
We use the Optimal-Planet banner in the navigation bar. We also use the circular Optimal-Planet logo as the pistil in the sunflower dashboard. The yellow warning traingle is used in the error-page which is generated in HTML using a combination of filter tags.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/optimalscans.png) ![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/OP-flower.png) ![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/triangle.png) 
