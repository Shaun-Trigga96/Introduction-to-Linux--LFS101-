# Printing

## Learning Objectives

By the end of this chapter, you should know how to:

- Configure a printer on a Linux machine.
 Print documents.
- Manipulate postscript and PDF files using command line utilities

# Configuration

## Printing on Linux

To manage printers and print either directly from a local computer or across a networked environment, you need to know how to configure and install a printer. Printing itself requires software that converts information from the application you are using to a language your printer can understand. The Linux standard for printing software is the `Common UNIX Printing System (CUPS)`.

Modern Linux desktop systems make installing and administering printers simple and intuitive. Nevertheless, it is instructive to understand the underpinnings of how it is done in Linux.

![Printing on Linux](PrintingonLinux.jpg)

## CUPS Overview

`CUPS` is the underlying software Linux systems use to print from applications, including any web browser such as `Thunderbird` or `google-chrome`, office suite such as `LibreOffice`, or `pdf` document viewer such as evince. It interprets page descriptions produced by your application (put a paragraph here, draw a line there, and so forth) and then sends the information to the printer. It acts as a print server for both local and network printers.

Printers manufactured by different companies may use their own particular print languages and formats. `CUPS` uses a modular printing system that accommodates a wide variety of printers and also processes various data formats. This makes the printing process simpler; you can concentrate more on printing and less on how to print.

Generally, the only time you should need to configure your printer is when you use it for the first time. In fact, CUPS often figures things out on its own by detecting and configuring any printers it locates.

![CUPS Overview](CUPSOverview.png)

## How Does CUPS Work?

`CUPS` carries out the printing process with the help of its various components:

- `Configuration files`
- `Scheduler`
- `Job files`
- `Log files`
- `Filter`
- `Printer drivers`
- `Backend`

You will learn about some of these components on the next few pages.

![How Does CUPS Work?](HowDoesCUPSWork.png)

## Configuration Files

The print scheduler reads server settings from several configuration files, the two most important of which are `cupsd.conf` and `printers.conf`. These and all other `CUPS-related` configuration files are stored under the `/etc/cups/` directory.

`cupsd.conf` is where most system-wide settings are located; it does not contain any printer-specific details. Most of the settings available in this file relate to network security, i.e., which systems can access `CUPS` network capabilities, how printers are advertised on the local network, what management features are offered, and so on.

`printers.conf` is where you will find the printer-specific settings. For every printer connected to the system, a corresponding section describes the printer’s status and capabilities. This file is generated or modified only after adding a printer to the system and should not be modified by hand.

You can view the full list of configuration files by typing `ls -lF /etc/cups`.

![Configuration Files](ConfigurationFiles.png)

## Job Files

`CUPS` stores print requests as files under the `/var/spool/cups` directory (these can actually be accessed before a document is sent to a printer). Data files are prefixed with the letter `d`, while control files are prefixed with the letter `c`.

![Job Files](JobFiles.png)

After a printer successfully handles a job, data files are automatically removed. These data files belong to what is commonly known as the `print queue`.

![Job Files](JobFiles2.png)

## Log Files

`Log files` are placed in `/var/log/cups` and are used by the `scheduler` to record activities that have taken place. These files include access, error, and page records.

To view what log files exist, type:

```bash
$ sudo ls -l /var/log/cups
```

![Log Files](LogFiles.png)

`Note` *on some distributions permissions are set such that you do not need to use `sudo`. You can view the log files with the usual tools*.

## Filters, Printer Drivers, and Backends

`CUPS` uses `filters` to convert job file formats to printable formats. `Printer drivers` contain descriptions for currently connected and configured printers, and are usually stored under `/etc/cups/ppd/`. The print data is then sent to the printer through a filter, and via a backend that helps to locate `devices` connected to the system.

![Filters, Printer Drivers, and Backends](FiltersPrinterDriversBackends.png)

So, in short, when you execute a print command, the scheduler validates the command and processes the print job, creating job files according to the settings specified in the configuration files. Simultaneously, the scheduler records activities in the log files. Job files are processed with the help of the filter, printer driver, and backend, and then sent to the printer.

## Managing CUPS

Assuming `CUPS` has been installed you'll need to start and manage the `CUPS` `daemon` so that `CUPS` is ready for configuring a printer. Managing the `CUPS` daemon is simple; all management features can be done with the `systemctl` utility:

```bash
$ systemctl status cups

$ sudo systemctl [enable|disable] cups

$ sudo systemctl [start|stop|restart] cups
```

`NOTE`: *The next screen demonstrates this on Ubuntu, but is the same for all major current Linux distributions*. 

## Configuring a Printer from the GUI

Each Linux distribution has a graphical configuration application that lets you add, remove, and configure local or remote printers. If you make sure the device is currently turned on and connected to the system; if so it should show up in the printer selection menu. If the printer is not visible, you may want to troubleshoot using tools that will determine if the printer is connected. For common USB printers, for example, the `lsusb` utility will show a line for the printer. Some printer manufacturers also require some extra software to be installed in order to make the printer visible to CUPS, however, due to the standardization these days, this is rarely required.

![Configuring a Printer from the GUI](ConfiguringaPrinterfromtheGUI.png)

## Adding Printers from the CUPS Web Interface

Many users do not know `CUPS` comes with its own web server, which makes a configuration interface available via a set of `CGI scripts`.

This web interface allows you to:

- Add and remove local/remote printers
- Configure printers:
  - Local/remote printers
  - Share a printer as a CUPS server
- Control print jobs:
  - Monitor jobs
  - Show completed or pending jobs
  - Cancel or move jobs

The CUP`S web interface is available on your browser at: [localhost:631](http://localhost:631/).

Some pages require a `username` and `password` to perform certain actions, for example to add a `printer`. For most Linux distributions, you must use the `root password` to `add`, `modify`, or `delete` printers or classes.

![Adding Printers from the CUPS Web Interface](AddingPrintersfromtheCUPSWebInterface.png)

# Printing Operations

## Printing from the Graphical Interface

Many graphical applications allow users to access printing features using the `CTRL-P` shortcut. To print a file, you first need to specify the printer (or a file name and location if you are printing to a file instead) you want to use; and then select the page setup, quality, and color options. After selecting the required options, you can submit the document for printing. The document is then submitted to CUPS. You can use your browser to access the CUPS web interface at [localhost:631](http://localhost:631/) to monitor the status of the printing job. Now that you have configured the printer, you can print using either the Graphical or Command Line interfaces.

The screenshot shows the GUI interface for `CTRL-P` for CentOS, other Linux distributions appear virtually identical.

![Printing from the Graphical Interface](PrintingfromtheGraphicalInterface.png)

## Printing from the Command-Line Interface

`CUPS` provides two command-line interfaces, descended from the `System V` and `BSD` flavors of `UNIX`. This means that you can use either `lp (System V)` or` lpr (BSD)` to print. You can use these commands to print text, PostScript, PDF, and image files.

These commands are useful in cases where printing operations must be automated (from shell scripts, for instance, which contain multiple commands in one file).

`lp` is just a command line front-end to the `lpr` utility that passes input to `lpr`. Thus, we will discuss only `lp` in detail. In the example shown here, the task is to print `$HOME/.emacs`.

![Printing from the Command-Line Interface](PrintingfromtheCommandLineInterface.png)

## Using lp

**lp** and **lpr** accept command line options that help you perform all operations that the GUI can accomplish. **lp** is typically used with a file name as an argument.

Some **lp** commands and other printing utilities you can use are listed in the table:

## Commands and Usage Examples

| Command | Usage |
|---------|-------|
| `lp <filename>` | To print the file to default printer |
| `lp -d printer <filename>` | To print to a specific printer (useful if multiple printers are available) |
| `program \| lp` or `echo string \| lp` | To print the output of a program |
| `lp -n number <filename>` | To print multiple copies |
| `lpoptions -d printer` | To set the default printer |
| `lpq -a` | To show the queue status |
| `lpadmin` | To configure printer queues |

## Additional Information

**lpoptions** can be used to set printer options and defaults. Each printer has a set of tags associated with it, such as the default number of copies and authentication requirements. You can type `lpoptions help` to obtain a list of supported options. **lpoptions** can also be used to set system-wide values, such as the default printer.

## Managing Print Jobs

You send a file to the shared printer. But when you go there to collect the printout, you discover another user has just started a 200 page job that is not time sensitive. Your file cannot be printed until this print job is complete. What do you do now?

In Linux, command line print job management commands allow you to monitor the job state as well as managing the listing of all printers and checking their status, and canceling or moving print jobs to another printer.

Some of these commands are listed in the table.

## Print Job Management Commands

| Command | Usage |
|---------|-------|
| `lpstat -p -d` | To get a list of available printers, along with their status |
| `lpstat -a` | To check the status of all connected printers, including job numbers |
| `cancel job-id` or `lprm job-id` | To cancel a print job |
| `lpmove job-id newprinter` | To move a print job to new printer |

# Manipulating Postscript and PDF Files

## Working with PostScript and PDF

PostScript is a standard page description language. It effectively manages scaling of fonts and vector graphics to provide quality printouts. It is purely a text format that contains the data fed to a PostScript interpreter. The format itself is a language that Adobe developed in the early 1980s to enable the transfer of data to printers.

![Working with PostScript and PDF](WorkingwithPostScriptandPDF.png)

`Features of PostScript`

- It can be used on any printer that is PostScript-compatible, i.e., any modern printer.
- Any program that understands the PostScript specification can print to it.
- Information about page appearance, etc., is embedded in the page.

PostScript has been, for the most part, superseded by the PDF format (Portable Document Format), which produces far smaller files in a compressed format for which support has been integrated into many applications. However, one still has to deal with PostScript documents, often as an intermediate format, on the way to producing final documents.

## Working with enscript

**enscript** is a tool that is used to convert a text file to PostScript and other formats. It also supports Rich Text Format (RTF) and HyperText Markup Language (HTML). For example, you can convert a text file to two columns (`-2`) formatted PostScript using the command:

```bash
$ enscript -2 -r -p psfile.ps textfile.txt
```

This command will also rotate (`-r`) the output to print so the width of the paper is greater than the height (aka landscape mode) thereby reducing the number of pages required for printing.

The commands that can be used with **enscript** are listed in the table below (for a file called `textfile.txt`).

## enscript Commands

| Command | Usage |
|---------|-------|
| `enscript -p psfile.ps textfile.txt` | Convert a text file to PostScript (saved to `psfile.ps`) |
| `enscript -n -p psfile.ps textfile.txt` | Convert a text file to n columns where n=1-9 (saved in `psfile.ps`) |
| `enscript textfile.txt` | Print a text file directly to the default printer |

# Converting Between PostScript and PDF

Most users today are far more accustomed to working with files in PDF format, viewing them easily either on the Internet through their browser or locally on their machine. The PostScript format is still important for various technical reasons that the general user will rarely have to deal with.

From time to time, you may need to convert files from one format to the other, and there are very simple utilities for accomplishing that task. **ps2pdf** and **pdf2ps** are part of the **ghostscript** package installed on or available on all Linux distributions. As an alternative, there are **pstopdf** and **pdftops** which are usually part of the **poppler** package, which may need to be added through your package manager. Unless you are doing a lot of conversions or need some of the fancier options (which you can read about in the man pages for these utilities), it really does not matter which ones you use.

Another possibility is to use the very powerful **convert** program, which is part of the **ImageMagick** package. Some newer distributions have replaced this with Graphics Magick, and the command to use is `gm convert`.

## Format Conversion Commands

| Command | Usage |
|---------|-------|
| `pdf2ps file.pdf` | Converts `file.pdf` to `file.ps` |
| `ps2pdf file.ps` | Converts `file.ps` to `file.pdf` |
| `pstopdf input.ps output.pdf` | Converts `input.ps` to `output.pdf` |
| `pdftops input.pdf output.ps` | Converts `input.pdf` to `output.ps` |
| `convert input.ps output.pdf` | Converts `input.ps` to `output.pdf` |
| `convert input.pdf output.ps` | Converts `input.pdf` to `output.ps` |

## Viewing PDF Content

Linux has many standard programs that can read PDF files, as well as many applications that can easily create them, including all available office suites, such as LibreOffice.

The most common Linux PDF readers are:

1. evince is available on virtually all distributions and is the most widely used program.
2. okular is based on the older kpdf and is available on any distribution that provides the KDE environment.

These open source PDF readers support and can read files following the PostScript standard. The proprietary Adobe Acrobat Reader, which was once widely used on Linux systems, is fortunately no longer available, as it did defective rendering and was unstable and poorly maintained. Even if you are using Windows, it is broken badly, so we advise not to use it.

![Viewing PDF Content](ViewingPDFContent.jpg)

## Manipulating PDFs

At times, you may want to merge, split, or rotate PDF files; not all of these operations can be achieved while using a PDF viewer. Some of these operations include:

- Merging/splitting/rotating PDF documents
- Repairing corrupted PDF pages
- Pulling single pages from a file
- Encrypting and decrypting PDF files
- Adding, updating, and exporting a PDF’s metadata
- Exporting bookmarks to a text file
- Filling out PDF forms.

In order to accomplish these tasks, there are several programs available:

- `qpdf`
- `pdftk`
- `ghostscript`.

`qpdf` is widely available on Linux distributions and is very full-featured. `pdftk` was once very popular but depended on an obsolete unmaintained package (`libgcj`), and a number of distributions dropped it.  However, it has now been reimplemented in Java and is available again on most distributions under the name `pdftk-java.` `Ghostscript` (often invoked using `gs`) is widely available and well-maintained. However, its usage is a little complex.ViewingPDFContent.

## Using qpdf

You can accomplish a wide variety of tasks using **qpdf** including:

`Commands and Usage Examples
`
| Command | Usage |
|---------|-------|
| `qpdf --empty --pages 1.pdf 2.pdf -- 12.pdf` | Merge the two documents `1.pdf` and `2.pdf`. The output will be saved to `12.pdf`. |
| `qpdf --empty --pages 1.pdf 1-2 -- new.pdf` | Write only pages 1 and 2 of `1.pdf`. The output will be saved to `new.pdf`. |
| `qpdf --rotate=+90:1 1.pdf 1r.pdf` | Rotate page 1 of `1.pdf` 90 degrees clockwise and save to `1r.pdf`. |
| `qpdf --rotate=+90:1-z 1.pdf 1r-all.pdf` | Rotate all pages of `1.pdf` 90 degrees clockwise and save to `1r-all.pdf`. |
| `qpdf --encrypt mypw mypw 128 -- public.pdf private.pdf` | Encrypt with 128 bits `public.pdf` using as the password `mypw` with output as `private.pdf`. |
| `qpdf --decrypt --password=mypw private.pdf file-decrypted.pdf` | Decrypt `private.pdf` with output as `file-decrypted.pdf`. |

![Using qpdf](Usingqpdf.png)

## Using pdftk

As mentioned earlier, Marc Vinyals has developed and maintained a port to Java for **pdftk** which can be found on [GitLab](https://gitlab.com/pdftk-java/pdftk), together with instructions for installation. Some distributions, such as `Ubuntu`, may install this version only.

You can accomplish a wide variety of tasks using **pdftk**.

## pdftk Commands and Usage Examples

| Command | Usage |
|---------|-------|
| `pdftk 1.pdf 2.pdf cat output 12.pdf` | Merge the two documents `1.pdf` and `2.pdf`. The output will be saved to `12.pdf`. |
| `pdftk A=1.pdf cat A1-2 output new.pdf` | Write only pages 1 and 2 of `1.pdf`. The output will be saved to `new.pdf`. |
| `pdftk A=1.pdf cat A1-endright output new.pdf` | Rotate all pages of `1.pdf` 90 degrees clockwise and save result in `new.pdf`. |

## Encrypting PDF Files with pdftk

If you're working with PDF files that contain confidential information and you want to ensure that only certain people can view the PDF file, you can apply a password to it using the **user_pw** option. One can do this by issuing a command such as:

```bash
$ pdftk public.pdf output private.pdf user_pw PROMPT
```

When you run this command, you will receive a prompt to set the required password, which can have a maximum of 32 characters. A new file, `private.pdf`, will be created with the identical content as `public.pdf`, but anyone will need to type the password to be able to view it.

![Encrypting PDF Files with pdftk](EncryptingPDFFileswithpdftk.png)

## Using Ghostscript

Ghostscript is widely available as an interpreter for the PostScript and PDF languages. The executable program associated with it is abbreviated to `gs`.

This utility can do most of the operations qpdf and pdftk can, as well as many others; see `man gs` for details. Use is somewhat complicated by the rather long nature of the options. For example:

**Combine three PDF files into one:**

```bash
$ gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=all.pdf file1.pdf file2.pdf file3.pdf
```

**Split pages 10 to 20 out of a PDF file:**

```bash
$ gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dDOPDFMARKS=false -dFirstPage=10 -dLastPage=20 -sOutputFile=split.pdf file.pdf
```

![Using Ghostscript](UsingGhostscript.png)

## Using Additional Tools

You can use other tools to work with PDF files, such as:

## Additional PDF Tools

- **pdfinfo** - It can extract information about PDF files, especially when the files are very large or when a graphical interface is not available.
- **flpsed** - It can add data to a PostScript document. This tool is specifically useful for filling in forms or adding short comments into the document.
- **pdfmod** - It is a simple application that provides a graphical interface for modifying PDF documents. Using this tool, you can reorder, rotate, and remove pages; export images from a document; edit the title, subject, and author; add keywords; and combine documents using drag-and-drop action.

For example, to collect the details of a document, you can use the following command:

```bash
$ pdfinfo /usr/share/doc/readme.pdf
```

![Using Additional Tools](UsingAdditionalTools.png)

# Lab 18.1: Creating PostScript and PDF from Text Files

## Lab Exercise

### Task
1. Check to see if the enscript package has been installed on your system, and if not, install it.
2. Using enscript, convert the text file `/var/log/dmesg` to PostScript format and name the result `/tmp/dmesg.ps`. As an alternative, you can use any large text file on your system. Make sure you can read the PostScript file (for example with evince) and compare to the original file. 
   > **NOTE**: On some systems, evince may have problems with the PostScript file, but the PDF file you produce from it will be fine for viewing.
3. Convert the PostScript document to PDF format, using `ps2pdf`. Make sure you can read the resulting PDF file. Does it look identical to the PostScript version?
4. Is there a way you can go straight to the PDF file without producing a PostScript file on the disk along the way?
5. Using `pdfinfo`, determine what is the PDF version used to encode the file, the number of pages, the page size, and other metadata about the file. If you do not have `pdfinfo` you probably need to install the `poppler-utils` package.

### Solution

1. **Check if enscript is installed:**

   ```bash
   $ which enscript
   # Output: /usr/bin/enscript
   ```

   If you do not get a positive result, install with whichever command is appropriate for your Linux distribution:

   ```bash
   $ apt-get install enscript
   $ yum install enscript
   $ zypper install enscript
   ```

2. **Convert text file to PostScript:**

   ```bash
   $ enscript -p /tmp/dmesg.ps /var/log/dmesg
   evince /tmp/dmesg.ps
   ```

3. **Convert PostScript to PDF:**

   ```bash
   $ ps2pdf /tmp/dmesg.ps
   ls -lh /var/log/dmesg /tmp/dmesg.ps /tmp/dmesg.pdf
   ```

   Sample output:

   ```bash
   $ -rw-rw-r-- 1 coop coop 28K Apr 22 13:00 /tmp/dmesg.pdf
   $  -rw-rw-r-- 1 coop coop 80K Apr 22 12:59 /tmp/dmesg.ps
   $ -rw-r--r-- 1 root root 53K Apr 22 11:48 /var/log/dmesg
   ```

   ```bash
   $ evince /tmp/dmesg.ps /tmp/dmesg.pdf
   ```

   Note the difference in sizes. PostScript files tend to be large, while PDF is a compressed format.

4. **Direct conversion to PDF without intermediate PostScript file:**
   You may want to scan the man pages for `enscript` and `ps2pdf` to figure out how to use standard input or standard output instead of files.

   ```bash
   $ enscript -p - /var/log/dmesg | ps2pdf - dmesg_direct.pdf
   ```

   Output:

   ```bash
   $ [ 15 pages * 1 copy ] left in -
   85 lines were wrapped
   ```

   ```bash
   $ ls -l dmesg*.pdf
   ```

   Output:

   ```bash
   $  -rw-rw-r-- 1 coop coop 28177 Apr 22 13:20 dmesg_direct.pdf
   $  -rw-rw-r-- 1 coop coop 28177 Apr 22 13:00 dmesg.pdf
   ```

5. **Extract PDF metadata:**

   ```bash
   $ pdfinfo dmesg.pdf
   ```

   Output:

   ```bash
   Title:          Enscript Output
   Author:         Theodore Cleaver
   Creator:        GNU Enscript 1.6.6
   Producer:       GPL Ghostscript 9.07
   CreationDate:   Wed Apr 22 13:00:26 2015
   ModDate:        Wed Apr 22 13:00:26 2015
   Tagged:         no
   Form:           none
   Pages:          15
   Encrypted:      no
   Page size:      612 x 792 pts (letter)
   Page rot:       0
   File size:      28177 bytes
   ```

# Lab 18.2: Combining PDFs

## Lab Exercise

### Task
You can convert two text files (you can create them or use ones that already exist since this is non-destructive) into PDFs, or you can use two pre-existing ones. Combine them into one PDF, and view the result. Do this using three different methods:

1. **qpdf**
2. **pdftk**
3. **gs**

If `pdftk` is not installed, you can try to install. However, if you are on a system for which it is no longer available, you will have to use `qpdf` or `gs`.

## Solution

First, we can create two PDFs to play with, using `enscript` and then `ps2pdf`:

```bash
$ cd /var/log
enscript -p dmesg.ps /var/log/dmesg
enscript -p boot.ps /var/log/boot.log
ps2pdf dmesg.ps
ps2pdf boot.ps
```

Of course, you may use two pre-existing PDF files and substitute their names below.

**Method 1: Using qpdf:**

```bash
$ qpdf --empty --pages dmesg.pdf boot.pdf -- method1.pdf
```

**Method 2: Using pdftk:**

```bash
$ pdftk dmesg.pdf boot.pdf cat output method2.pdf
```

**Method 3: Using gs:**

```bash
$ gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=method3.pdf dmesg.pdf boot.pdf
```

Now view them:

```bash
$ ls -l method1.pdf method2.pdf method3.pdf
evince method1.pdf method2.pdf method3.pdf
```

How do the files compare?

## Chapter Summary

You have completed Chapter 18. Let's summarize the key concepts covered:

- CUPS provides two command-line interfaces: the System V and BSD.
- The CUPS interface is available at localhost:631.
- `lp` and `lpr` are used to submit a document to CUPS directly from the command line.
- `lpoptions` can be used to set printer options and defaults.
- PostScript effectively manages scaling of fonts and vector graphics to provide quality prints.
- `enscript` is used to convert a text file to PostScript and other formats.
- Portable Document Format (PDF) is the standard format used to exchange documents while ensuring a certain level of consistency in the way the documents are viewed.
- `pdftk` joins and splits PDFs; pulls single pages from a file; encrypts and decrypts PDF files; adds, updates, and exports a PDF's metadata; exports bookmarks to a text file; adds or removes attachments to a PDF; fixes a damaged PDF; and fills out PDF forms.
- `pdfinfo` can extract information about PDF documents.
- `flpsed` can add data to a PostScript document.
- `pdfmod` is a simple application with a graphical interface that you can use to modify PDF documents.