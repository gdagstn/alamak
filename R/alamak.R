
#' Make a pixel pal
#'
#' Generates a pixel pal from a PNG file
#'
#' @param filepath a character indicating a path to a .PNG file.
#' @param compress logical, should the Pixel Pal be compressed to take up fewer
#'    spaces in the terminal? Default is TRUE.
#'
#' @return a character string converted to color ASCII through \code{crayon}
#'
#' @importFrom png readPNG
#' @importFrom crayon make_style combine_styles
#' @importFrom grDevices rgb
#'
#' @examples
#'
#' fpath <- system.file("extdata", "buster.png", package="alamak")
#' buster = makePixPal(fpath)
#' cat(as.vector(t(buster)), sep = "")
#'
#' ## To make a new Pixel Pal to be used with `alamak()`
#'
#' new_pixelpal = list("crayon" = makePixPal(fpath),
#'     "messages" = list(
#'       "Error" = c("The first possible message",
#'                   "The second possible message",
#'                   "And so on",
#'                   "You know the drill"),
#'       "Warning" = c("A warning message",
#'                    "Another warning message")
#'                     )
#'                    )
#'
#' alamak(a + b, pixpal = new_pixelpal)
#'
#' @export

makePixPal <- function(filepath, compress = TRUE) {

  pix = readPNG(filepath, native = FALSE)

  pixcols = rgb(pix[,,1], pix[,,2], pix[,,3], pix[,,4])

  pix = matrix(pixcols, nrow = dim(pix)[1], byrow = TRUE)

  if(compress) {
    crayonstrings <- compressPixPal(pix)
  } else {
    crayonstrings <- matrix(
      unlist(sapply(pixcols, function(x) {
        make_style(x, bg = TRUE)("  ")})),
      nrow = nrow(pix))

    crayonstrings[t(pix) == "#00000000"] = "  "
    crayonstrings[,ncol(crayonstrings)] <- paste(crayonstrings[,ncol(crayonstrings)], "\n", sep = "")
  }
  return(crayonstrings)
}

#' alamak!
#'
#' Catches an error or warning and lets a pixel pal tell you all about it
#'
#' @param f a function
#' @param pixpal a Pixel Pal, one of "Lenny" (supportive velociraptor), "Buster"
#'     (cool lemon), "Jerry" (a parrot that hates you), "Oniji" (Edo period
#'     Japanese kabuki actor who speaks in haiku only), and "E10N" (a robot from
#'     the future). Alternatively, a Pixel Pal can be created manually following
#'     the instructions at \code{?makePixPal}.
#'
#' @return the output of \code{f} if there are no errors, otherwise
#'     it displays the pixel pal with the (edited) message.
#'     Warnings are also displayed, but the output of the function is still
#'     returned.
#'
#' @examples
#'
#' # Error message
#' alamak(a + 4)
#'
#' # Warning message
#' alamak(as.numeric("alamak"))
#'
#' # Change Pixel Pal
#' alamak(as.numeric("alamak"), "Lenny")
#'
#' @importFrom crayon red
#' @importFrom cli console_width
#'
#' @export

alamak <- function(f, pixpal = "Jerry"){

  # Input checks
  if(all(class(pixpal) == "character" & pixpal %in% c("Jerry", "Lenny", "Buster", "Oniji", "E10N"))) {
    pixpal = pixpals[[pixpal]]
  } else if(class(pixpal) != "list") {
    stop("Not a valid Pixel Pal! See ?makePixPal for an example.")
  } else if(class(pixpal) == "list" &
            !all(names(pixpal) %in% c("crayon", "messages"))) {
    stop("Not a valid Pixel Pal! Needs \"crayon\" and \"messages\" elements. See ?makePixPal for an example")
  } else if(class(pixpal) == "list" &
            all(names(pixpal) %in% c("crayon", "messages")) &
            !all(names(pixpal$messages) %in% c("Error", "Warning"))) {
    stop("Not a valid Pixel Pal! Needs \"Error\" and \"Warning\" elements. See ?makePixPal for an example")
  }

  #Error catching
  warnings = list()
  errors = list()

  out <- tryCatch(withCallingHandlers(
               expr = f,
               warning = function(w) {
                 warnings <<- c(warnings, list(w))
                 invokeRestart("muffleWarning")}),
               error = function(e) {
                 errors <<- c(errors, list(e))}
             )

  if(length(errors) > 0 | length(warnings) > 0) {

    if(length(errors) > 0){
      errtype = "Error"
      errmess = paste0(errtype, ": ", unlist(lapply(errors, function(x) {
          mess = gsub(x = as.character(x$message), pattern = "\\033\\[[0-9][0-9+]m", replacement = "", perl = TRUE)
          return(mess)
        })))
    } else if(length(warnings) > 0) {
      errtype = "Warning"
      errmess = paste0(errtype, ": ", unlist(lapply(warnings, function(x) {
          mess = gsub(x = as.character(x$message), pattern = "\\033\\[[3[0-9+]m", replacement = "", perl = TRUE)
          return(mess)
        })))
    }

    # Message wrangling

        pal = pixpal$crayon

        consolew = min(2*console_width() - 2 - ncol(pal), 100)

        introMessage = paste0(strwrap(pixpal$messages[[errtype]][sample(seq_len(length(pixpal$messages[[errtype]])), size = 1)], consolew), collapse = " \n")

        errmess_wrapped = paste0(sapply(strwrap(errmess, consolew), crayon::red, USE.NAMES = FALSE), collapse = "\n")

        message_to_add = unlist(strsplit(paste0(introMessage, " \n", errmess_wrapped), "\n"))

        column_sizes = unlist(sapply(message_to_add, nchar))
        column_types = unlist(sapply(message_to_add, function(x) grepl("\\033\\[", x, perl = TRUE)))
        max_col_size = which.max(column_sizes)

        if(column_types[max_col_size]){
            column_sizes[max_col_size] = column_sizes[max_col_size] - 10
            max_col_size = which.max(column_sizes)
          }

        max_text_col = column_sizes[max_col_size]

        finalmess = c("\u250c", rep("\u2500", max_text_col + 3), "\u2510\n\u2502",
                      rep(" ", max_text_col), "   \u2502\n")

        for(i in message_to_add) {
          if(grepl("\\033\\[31", i, perl = TRUE)) {
            padding = nchar(i)-10
          } else {
            padding = nchar(i)
          }
            finalmess = c(finalmess,
                          "\u2502  ", i,
                          rep(" ", max_text_col - padding), " \u2502\n")
          }

       finalmess = c(finalmess, "\u2502", rep(" ", max_text_col + 3), "\u2502\n",
                                "\u2514", rep("\u2500", max_text_col + 3), "\u2518\n")

       finalmess_print = unlist(strsplit(paste0(finalmess, collapse = ""), split = "\n"))

       difference = length(finalmess_print) - nrow(pal)
       if(difference > 0) {
         pal = rbind(pal,
                     do.call(rbind,
                             lapply(seq_len(difference), function(x) c(rep(" ", ncol(pal)-1), "\n"))
                             )
         )
         }

       crayonmap = crayonmap = as.vector(t(pal))
       right_lines = seq(ncol(pal), length(crayonmap), ncol(pal))
       crayonmap_with_message = crayonmap

       for(i in seq_len(length(finalmess_print))) {
         crayonmap_with_message[right_lines[i]] = gsub(x = crayonmap[right_lines[i]],
                                                       pattern = "\n",
                                                       replacement =  paste0("   ", finalmess_print[i], "\n"))
       }

       # Printing
       cat("\n", crayonmap_with_message, "\n", sep = "")
  }

  if(length(errors) == 0) return(out)

}


#' Compress a pixel pal
#'
#' Compresses a pixel pal using Unicode Blocks
#'
#' @param pix a character indicating a path to a .PNG file.
#'
#' @return returns a compressed Pixel Pal character matrix that occupies half the
#'     space in the terminal
#'
#' @details Internal use only. Note: the Apple Terminal does not deal well with
#'     Unicode blocks. When the  package is loaded, if Apple Terminal is detected,
#'     compression is disabled.
#'
#' @references kindly suggested in https://github.com/gdagstn/alamak/issues/2
#'     by Trevor L. Davis
#'
#' @importFrom crayon make_style combine_styles

compressPixPal <- function(pix){

  pix = t(pix)

  complist = list()

  for(i in seq(1,nrow(pix), by = 2)) {

    two_rows = t(pix[i:(i + 1),])

    compressed = apply(two_rows, 1, function(x) {

      if(x[1] == "#00000000" & x[2] != "#00000000") {
          background1 = FALSE
          x[1] = x[2]
          pixel_char = "\u2584"
        } else  if(x[1] != "#00000000" & x[2] == "#00000000") {
          x[2] = x[1]
          background1 = FALSE
          pixel_char = "\u2580"
        } else if(x[1] == "#00000000" & x[2] == "#00000000"){
          background1 = FALSE
          pixel_char = " "
        } else  if(x[1] != "#00000000" & x[2] != "#00000000"){
          background1 = TRUE
          pixel_char = "\u2584"
        }

        combine_styles(make_style(x[1], bg = background1),
                       make_style(x[2], bg = FALSE))(pixel_char)
    })

    complist[[i]] = c(compressed, "\n")

  }
  return(do.call(rbind, complist[!is.null(complist)]))
}


