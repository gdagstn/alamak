<img src="https://user-images.githubusercontent.com/21171362/172660668-a915837a-7724-4499-9bc9-52478d8fe36f.png" align="right" alt="" width="150" />

# alamak
`alamak` catches your errors and lets a Pixel Pal (patent pending) tell you all about it. 

The name comes from the Singlish/Malay expression "alamak!", which is an exclamation that follows a surprising/unsettling event, or a minor nuisance, according to the vibe.

# Install

As usual, install throught `devtools`:

```
devtools::install_github("gdagstn/alamak")
```

# Use

You may think that in order to use `alamak` you need to know how to code. The opposite is true: not knowing how to code will let `alamak` shine in all its glory. 

Wrap your call into a call to `alamak()`. If a warning or an error occurs, a Pixel Pal (patent pending) appears on the screen  and tells you what they think about you and your situation.

```
library(alamak)
alamak(your_function(), pixelpal = "Jerry")
```

`alamak` works best in a terminal; the Rstudio console has a different line height that doesn't render "pixels" properly. 

`alamak` is quite dumb and should not be used in professional settings, unless that's your thing.

There are 4 Pixel Pals (patent pending) available:

**Jerry**, a parrot who doesn't like you very much:

<img width="725" alt="Screenshot 2022-06-08 at 11 51 14 PM" src="https://user-images.githubusercontent.com/21171362/172661506-462e4337-4efa-4bb2-98d3-38dba4cd3838.png">

**Buster**, a cool lemon:

<img width="545" alt="Screenshot 2022-06-08 at 11 56 53 PM" src="https://user-images.githubusercontent.com/21171362/172662859-6c0a51b5-a1ef-4273-a561-06e67e162e9b.png">

**Lenny**, a supportive velociraptor who is also great with kids:

<img width="628" alt="Screenshot 2022-06-08 at 11 57 35 PM" src="https://user-images.githubusercontent.com/21171362/172663016-cb6f8bd3-e470-488c-ab4a-8200db2cf258.png">

**Oniji**, an 18th century Japanese kabuki actor who only speaks in haiku:

<img width="880" alt="Screenshot 2022-06-08 at 11 58 43 PM" src="https://user-images.githubusercontent.com/21171362/172663242-1bccfeaa-ad7f-4310-957d-22f48cc04aff.png">

**E10N**, a no-nonsense robot from the not so distant future

![e10nscreenshot](https://user-images.githubusercontent.com/21171362/172915909-36c7be7d-eec3-486c-bb78-2458565faca8.jpg)


You can create another Pixel Pal (patent pending) yourself! If you have a 16x16 (can be bigger but may distort the text on the screen) PNG file with transparency you can load it. As a reference, consider that every "pixel" is actually two whitespaces with a colored background, so a 32x32 picture will take up 64 spaces in size in the terminal. 

You only need to make a list with the following elements:

- `crayon`: the result of a call to `makePixelPal()` where the argument is the path to a PNG file
- `messages`: a nested list containing two other lists:
  - `Error`: a character vector of error messages
  - `Warning`: a character vector of warning messages

```
new_pixelpal = list("crayon" = makePixPal("path/to/picture.png"),
                    "messages" = list(
                    "Error" = c("The first possible message", 
                                "The second possible message", 
                                "And so on", 
                                "You know the drill"),
                     "Warning" = c("A warning message",
                                   "Another warning message")
                                  )
                        )

```

then use it with `alamak`

```
alamak(your_function(), new_pixelpal)
```

# Acknowledgements
- Gábor Csárdi for the `crayon` package
- Simon Urbanek for the `png` package
