Foremost
========

A Command Line RSYNC front end


Purpose: Mirroring or Safely Merging a file transfer with graphical output of its transfer status.

Installation
========

On Debian/Ubuntu:

cd ~/Downloads

wget https://codeload.github.com/microuser/Foremost/zip/master

unzip master

cd Foremost-master

sudo cp -v foremost /usr/bin/foremost

sudo chmod +x /usr/bin/foremost


Useage
========
cd ~

foremost A B


Prerequisits Debain/Ubuntu
========
sudo apt-get install pv

Attribution:
========
This program is published in response to a general nececessity as referenced in the stack exchange discussion at http://unix.stackexchange.com/questions/68582/how-to-see-the-total-progress-while-copying-the-files

Specifically, rsync currently has no progress bar, just an rate indicator:...

Quoting from the forum...

"So... short answer: you can't."...

"But you can have a progress bar about the number of file transferred using pv, if you already know how much you have".
