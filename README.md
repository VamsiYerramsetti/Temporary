# UI Style Guide

## Color palette
The website uses three primary colours which were derived from the optimal scans logo:
1. Green: #A3AF00
2. Blue: #1998F6 
3. White: #FFFFFF

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/palette.png)

We have used other colours in spesific parts of the websites as well:
1. Yellow in the Error Page: #ffff00
2. Light Blue Gradient used in the "Vragen": linear-gradient(to right, #00d2ff 0%, #3a7bd5 100%);
3. Shadows used: rgba(209, 219, 231,0.7)

The colours palette of the pyramid and the sunflower are:
1. rgb(160, 0, 0)
2. rgb(250, 170, 25)
3. rgb(160, 175, 0)
4. rgb(30, 150, 250)
5. rgb(50, 90, 170)

## Typography
The "system-ui" and Lato sans-serif" font family is used through out the whole website. We used the standard HTML heading tags for the headings and default HTML paragrah fontsize for questions and answer text.

## UI elements (Bootstrap version and elements used) used (and for what things)

The frontend of the website heavily uses the bootsrap5 library. The "Vragen", "Dashboard", "Error-Page", "Navigation-Bar" and "Logout-Page" all have been desighned using this library. We used the follwing sources in the head tage of the respective html files and installed boostrap5 in our poetry file.
The page is first split into an appropriate combination of collumns and rows using the gridbox layout, boostrap5 offers. These "boxes" are then converted to flexbox containers where we can enter in the components of the respective pages. By using bootstrap the UI adapts to any screensize and avoids nasty unredable UI.

### Dashboard UI
The gridbox layout of the Pyramid dashboard starts with a row contiaing the theme-progress-bar heading "Voortang Bentwoording" and two bootstrap buttons on the left to donwload the raport and to get the score per sub-theme. The rest is split in into three main collumns that comprise of the theme-progress bars, theme-pyramid and the percentage panal. Each progress bar and pyramid level is its own flexbox container. The percentage panal is its own flexbox container. We stuck to using the basic HTML entity codes for the green tick: &#10004, red-circle: &#128308 and percentage-sighn: &#37.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/pyramid.png)

In the sunflower version the middle collumn is further split into three collumns where each collumns the required number of circles making up the petals of the sunflower. Each circle is a flexbox button.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/sunflower.png)


### Vragen UI
The "Vragen"(scan page quitionaire) is enitrly based on bootstrap. We do not use a gridlayout and each qution type is its own flexbox container. We used glassmorphism to make the rounded rectangles for each question and heading boces for all questions. The buttons that allow the user to navigate to different themes are all bootstrap based. The questionaire comprises of four question types: open,radio,checkbox, and checkbox which all use the respective default bootstrap5 input type. The scan progress bar uses a flexbox container and is stuck to the bottom of the screen as the user filles out the page via the css sticky tage. The progress bar incorporates a bootstrap flexbox continer and striped boostrap transformation for the animation. The update_progress_bar() function in script.js increments the width of the progress as questions are filled. The page ends with two bootstrap primary buttons which either Opslaan or Vestuur resulting in auto-save pop up to inform the user the status of his quitinaire progress.

![GitHub Logo](https://github.com/VamsiYerramsetti/Temporary/blob/main/vragen.png)



## Logo placement
## Other non-trivial design rules you applied
