<img src="https://user-images.githubusercontent.com/21171362/172660668-a915837a-7724-4499-9bc9-52478d8fe36f.png" align="right" alt="" width="150" />

# alamak
`alamak` catches your errors and lets a pixel pal tell you all about it. 

The name comes from the Singlish/Malay expression "alamak!", which is an exclamation that follows a surprising/unsettling event, or a minor nuisance, according to the vibe.

# Install

As usual, install throught `devtools`:

```
devtools::install_github("gdagstn/alamak")
```

# Use

Wrap your call into a call to `alamak()`. If a warning or an error occur, a Pixel Pal (patent pending) appears on the screen  and tells you what they think about errors or warnings.

```
alamak(your_function(), pixelpal = "Jerry")
```

`alamak` works best in a terminal; the Rstudio console has a different line height that doesn't render "pixels" properly. 

`alamak` is quite dumb and should not be used in professional settings, unless that's your thing.

There are 4 pixel pals available:

**Jerry**, a parrot who doesn't like you very much:

<img width="725" alt="Screenshot 2022-06-08 at 11 51 14 PM" src="https://user-images.githubusercontent.com/21171362/172661506-462e4337-4efa-4bb2-98d3-38dba4cd3838.png">

**Buster**, a cool lemon:

<img width="545" alt="Screenshot 2022-06-08 at 11 56 53 PM" src="https://user-images.githubusercontent.com/21171362/172662859-6c0a51b5-a1ef-4273-a561-06e67e162e9b.png">

**Lenny**, a supportive velociraptor who is also great with kids:

<img width="628" alt="Screenshot 2022-06-08 at 11 57 35 PM" src="https://user-images.githubusercontent.com/21171362/172663016-cb6f8bd3-e470-488c-ab4a-8200db2cf258.png">

**Oniji**, an 18th century Japanese kabuki actor who only speaks in haiku:

<img width="880" alt="Screenshot 2022-06-08 at 11 58 43 PM" src="https://user-images.githubusercontent.com/21171362/172663242-1bccfeaa-ad7f-4310-957d-22f48cc04aff.png">

You can create another Pixel Pal (patent pending) yourself! If you have a 16x16 (can be bigger but may distort the text on the screen) PNG file with transparency you can load it.

```
new_pixelpal = list("crayon" = makePixelPal("path/to/picture.png"),
                    "message" = c("The first possible message", "The second possible message", "And so on", "You know the drill"))

```

then use it with `alamak`

```
alamak(your_function(), new_pixelpal)
```

# Acknowledgements
- Gábor Csárdi for the `crayon` package
- Simon Urbanek for the `png` package