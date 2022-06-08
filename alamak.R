
#' Make a pixel pal
#'
#' Generates a pixel pal from a PNG file
#'
#' @param filepath a character indicating a path to a .PNG file.
#'
#' @return a character string converted to color ASCII through \code{crayon}
#'
#' @importFrom png readPNG
#' @importFrom crayon make_style
#' @importFrom grDevices rgb
#'
#' @examples
#'
#' fpath <- system.file("extdata", "buster.png", package="alamak")
#' buster = makePixPal(fpath)
#' cat(as.vector(t(buster)), sep = "")
#'
#' @export

makePixPal <- function(filepath) {

  pix = readPNG(filepath, native = FALSE)

  pixcols = rgb(pix[,,1], pix[,,2], pix[,,3], pix[,,4])

  pix = matrix(pixcols, nrow = dim(pix)[1], byrow = TRUE)

  crayonstrings <- matrix(
    unlist(sapply(pixcols, function(x) {
           make_style(x, bg = TRUE)("  ")})),
    nrow = nrow(pix))

  crayonstrings[t(pix) == "#00000000"] = "  "
  crayonstrings[,ncol(crayonstrings)] <- paste(crayonstrings[,ncol(crayonstrings)], "\n", sep = "")
  return(crayonstrings)
}

#' alamak!
#'
#' Catches an error or warning and lets a pixel pal tell you all about it
#'
#' @param f a function
#' @param pixpal a pixel pal, one of "Lenny" (supportive velociraptor), "Buster"
#'     (cool lemon), "Jerry" (a parrot that hates you) and "Oniji" (Edo period
#'     Japanese kabuki actor who speaks in haiku only)
#'
#' @return the result of the function if there are no errors, otherwise
#'     it displays the pixel pal with the message. Warnings are also displayed but
#'     the result of the function is still returned.
#'
#' @examples
#'
#' alamak(a + 4)
#'
#' @importFrom crayon red reset
#'
#' @export

alamak <- function(f, pixpal = "Jerry"){

  if(pixpal %in% c("Jerry", "Lenny", "Buster", "Oniji")) {
    pixpal = pixpals[[pixpal]]
  } else if(class(pixpal) != "list") stop("Not a valid Pixel Pal!")

  warns = list()
  errs = list()

  out <- tryCatch(withCallingHandlers(
               expr = f,

               warning = function(w) {
                 warns <<- c(warns, list(w))
                 invokeRestart("muffleWarning")
               }),

               error = function(e) {
                 errs <<- c(errs, list(e))
               }
             )

  if(length(errs) > 0 | length(warns) > 0) {
    if(length(errs) > 0){
      errtype = "Error"
      errmess = paste0(errtype, ": ", unlist(lapply(errs, function(x) x$message)))
    } else if(length(warns) > 0) {
      errtype = "Warning"
      errmess = paste0(errtype, ": ", unlist(lapply(warns, function(x) x$message)))
    }
        introMessage = paste0(strwrap(pixpal$messages[sample(seq_len(length(pixpal$messages)), size = 1)], 100), collapse = " \n")

        errmess_wrapped = paste0(sapply(strwrap(errmess, 100), crayon::red, USE.NAMES = FALSE), collapse = "\n")

        message_to_add = unlist(strsplit(paste0(introMessage, " \n", errmess_wrapped), "\n"))

        column_sizes = unlist(sapply(message_to_add, nchar))
        column_types = unlist(sapply(message_to_add, function(x) grepl("\\033\\[", x, perl = TRUE)))
        max_col_size = which.max(column_sizes)

        if(column_types[max_col_size]){
            column_sizes[max_col_size] = column_sizes[max_col_size] - 10
            max_col_size = which.max(column_sizes)
          }

        max_text_col = column_sizes[max_col_size]

        #print(max_text_col)
        #print(message_to_add[1])

        finalmess = c(" ", rep("_", max_text_col), "____\n|",
                      rep(" ", max_text_col), "    |\n")

        for(i in message_to_add) {
          if(grepl("\\033\\[", i, perl = TRUE)) {
            padding = nchar(i)-10
          } else {
            padding = nchar(i)
          }
            finalmess = c(finalmess,
                          "|  ", i,
                          rep(" ", max_text_col - padding), "  |\n")
          }

       finalmess = c(finalmess, "|_", rep("_", max_text_col), "___|\n")

       finalmess_print = unlist(strsplit(paste0(finalmess, collapse = ""), split = "\n"))

       pal = pixpal$crayon
       difference = length(finalmess_print) - nrow(pal)
       if(difference > 0) {
         pal = rbind(pal,
                     do.call(rbind,
                             lapply(seq_len(difference), function(x) c(rep("  ", ncol(pal)-1), "  \n"))
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
       cat(crayonmap_with_message, sep = "")
  }

  if(length(errs) == 0) return(out)

}


