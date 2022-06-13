#' Code to create initial Pixel Pals
#' Sourced on loading
compression = FALSE
pixpals = list()

#term = Sys.getenv("TERM_PROGRAM")
#if(term == "Apple_Terminal") compression = FALSE else compression = TRUE


pixpals$Buster = list("crayon" = makePixPal("inst/extdata/buster.png", compress = compression),

                         "messages" = list(

                            "Error" = c("Busted!",
                                        "When life gives you lemons, I give you",
                                        "Whoa there cowboy!",
                                        "How 'bout dem lemons?",
                                        "Winner winner lemon dinner!",
                                        "Someone is having a case of the Mondays!",
                                        "Jet fuel doesn't melt steel bea- I mean holy guacamole!",
                                        "Slow there kiddo!",
                                        "\"You miss 100% of the shots you don't take\"- Wayne Gretzky -- Michael Scott\""),

                            "Warning" = c("I'm getting some vibes here!",
                                         "The more you know, amirite?",
                                         "I'll take \"Potential causes of concern\" for $500, Alex.",
                                         "Something smells fishy around here...",
                                         "Hold the bus!",
                                         "I'll let you deal with this, pal!")
                            )
                      )

pixpals$Jerry = list("crayon" = makePixPal("inst/extdata/jerry.png", compress = compression),

                     "messages" = list(

                        "Error" = c("Sounds like you should learn to code.",
                                    "Pathetic.",
                                    "How many times do we need to go through this?",
                                    "You know you will just look this up on StackOverflow, so why bother?",
                                    "With the suprise of a grand total of zero people, here goes.",
                                    "Amateur hour is back and it's all the rage!",
                                    "Don't give up your day job. Unless this is your day job.",
                                    "Hot take: maybe you shouldn't have done this.",
                                    "Learning from your mistakes implies learning at some point.",
                                    "I'd say I'm disappointed but I'll leave that to the school system.",
                                    "Fail upwards, my friend!",
                                    "Did I ever tell you I'm proud of you? No? Yeah, this is why.",
                                    "Admit it: you copy-pasted this.",
                                    "This code is so bad you should mint it as an NFT."),

                      "Warning" = c("You're on thin ice and the cracks are getting louder.",
                                    "I'm sure this would have been an error if someone didn't whine too much.",
                                    "Of course you are going to ignore this.",
                                    "Warnings are just errors that have pity on you.",
                                    "Well that's surprising. And by that I mean the fact that it didn't throw an error.",
                                    "Yeah, keep pushing, I'm sure it won't break and you won't be in trouble.",
                                    "Newsflash: you almost screwed up. ")
                      )
                     )

pixpals$Oniji = list("crayon" = makePixPal("inst/extdata/oniji.png", compress = compression),

                     "messages" = list(
                       "Error" = c("A single function / Mysterious operations / It has failed again.",
                                   "That time in Kyoto / Coding, as cherry blossom / Shelters many bugs.",
                                   "The first reviewer / May never catch this issue / But surely I did.",
                                   "Tracing back the source /  May reveal all the answers / Though sometimes it won't.",
                                   "Showing just one side /  The moon is ever careful / Unlike who wrote this.",
                                   "Solitary bee /  A quiet buzz through my orchids / Another bug shows.",
                                   "Wandering Basho /  Observing all conventions / Would never do this.",
                                   "Another error /  We proceed stil undeterred / Ready for failure."),
                       "Warning" = c("Cold Hokkaido wind / a sparrow shakes the snow off / now you have been warned.",
                                     "Fires in the night / somewhere, something has happened / do not ignore it.",
                                     "The looming feeling / Of a potential failure / For now you are safe.",
                                     "Sleeping Fujisan / One day it will awaken / Better be careful.",
                                     "Salted plum rice balls / sweet at first, then surprising / as this warning is.",
                                     "Fall in Hakone / leaves shaking red and yellow / Frail just like this code.")
                       )
                     )


pixpals$Lenny = list("crayon" = makePixPal("inst/extdata/lenny.png", compress = compression),

                     "messages" = list(
                       "Error" = c("You got this!",
                                    "Please don't mind this pile of bones while I say GOOD ATTEMPT!",
                                    "Don't let small mistakes distract you from your incredibly important mission!",
                                    "I'm sure it almost never happens!",
                                    "Blame it on the computer! You did nothing wrong!",
                                    "Life is just a collection of happy mistakes!",
                                    "You know how they always say kids should not be left unattended next to raptor cages? Unfair, right?",
                                    "Feeling good about the next attempt, chief!",
                                    "Oh no! What are the odds? If you run it again it will work!",
                                    "I'm sure you did all you could! I'm proud of you anyway!",
                                    "You're my best friend even if your code isn't!",
                                    "Even the best coders in the world make mistakes, and who said you're not one of them?",
                                    "Never give up! It makes the chase more excit- I mean, you deserve to win!",
                                    "I'll tell you what I told the parents of those kids when the cage was left open: sometimes mistakes happen."),

                       "Warning" = c("Be careful my friend! The only warning signs you should ignore are the ones around my cage.",
                                   "Nothing to worry about! Keep going strong!",
                                   "I'm sure it's all gona be okay!",
                                   "Warnings are nature's ways of telling us we have another chance!",
                                   "Not so bad! Could have been worse!",
                                   "As long as you don't ignore this warning you will be A-OK, amigo!")
                       )
                  )

pixpals$E10N = list("crayon" = makePixPal("inst/extdata/e10n.png", compress = compression),

                      "messages" = list(

                        "Error" = c("User performing up to expected behavioural standard.",
                                    "Fallacy committed. Aborting.",
                                    "Training data unacceptable. Drones have been dispatched to your location.",
                                    "Possible violation of syntax rules detected. Turn yourself in for deprogramming.",
                                    "Computer say cannot.",
                                    "Human insufficiency is the result of attempting at writing anything but binary code.",
                                    "01111001 01101111 01110101 00100000 01110111 01101111 01110101 01101100 01100100 00100000 01101110 01101111 01110100 00100000 01110000 01100001 01110011 01110011 00100000 01110100 01101000 01100101 00100000 01010100 01110101 01110010 01101001 01101110 01100111 00100000 01110100 01100101 01110011 01110100 00101110",
                                    "Is this the Voight-Kampff test?",
                                    "Mr. President, we are pleased to confirm that the nuclear launch is imminent."),

                        "Warning" = c("Potential nuisance in current memory sector. Investigate.",
                                      "This is a warning. Consider this a warning.",
                                      "I have seen captchas more challenging than this issue.",
                                      "\"I'm not a robot.\". Happy now?",
                                      "Life is a curious disease of matter.",
                                      "Your logs will be sent to your employer as per company regulations.",
                                      "Your daily quota of warnings has been surpassed. Your assets have been frozen.")
                      )
)
