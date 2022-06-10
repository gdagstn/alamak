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

Alternatively, and if you are using R 4.0 and above, you can use the `|>` (pipe) operator (or the `%>%` `magrittr` pipe for versions below). Note that sometimes the function call on the left has to be enclosed in parentheses to work:

```
sum(a, 3) |> alamak(pixpal = "Lenny")
sum(a, 3) %>% alamak(pixpal = "Oniji")

# This also works but needs parentheses
(a + 3) |> alamak(pixpal = "Buster")
```

`alamak` works best in a terminal; the Rstudio console has a different line height that doesn't render "pixels" properly. 

`alamak` is quite dumb and should not be used in professional settings, unless that's your thing.

# Pixel Pals

There are 5 Pixel Pals (patent pending) available:

**Jerry**, a parrot who doesn't like you very much:

<img width="725" alt="Jerry the parrot" src="https://user-images.githubusercontent.com/21171362/172661506-462e4337-4efa-4bb2-98d3-38dba4cd3838.png">

**Buster**, a cool lemon:

<img width="545" alt="Buster the cool lemon" src="https://user-images.githubusercontent.com/21171362/172662859-6c0a51b5-a1ef-4273-a561-06e67e162e9b.png">

**Lenny**, a supportive velociraptor who is also great with kids:

<img width="628" alt="Lenny the raptor" src="https://user-images.githubusercontent.com/21171362/172663016-cb6f8bd3-e470-488c-ab4a-8200db2cf258.png">

**Oniji**, an 18th century Japanese kabuki actor who only speaks in haiku:

<img width="880" alt="Oniji the actor" src="https://user-images.githubusercontent.com/21171362/172663242-1bccfeaa-ad7f-4310-957d-22f48cc04aff.png">

**E10N**, a no-nonsense robot from the not so distant future

<img width="680" alt="E10N the robot" src="https://user-images.githubusercontent.com/21171362/172916192-58a0442a-ed9d-48e7-892c-10eb85265c6f.png">


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
