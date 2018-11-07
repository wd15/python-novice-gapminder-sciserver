# Materials for SciServer SWC Workshop

SWC Workshop given at JHU from 11/11/2018 - 11/14/2018

## Nix

Use

    $ nix-shell

to fire up the environment and then

    $ jupyter notebook

to fire up the notebook.

## Print out the Git Novice lesson

    $ nix-shell
    $ cd ..
    $ git clone https://github.com/swcarpentry/python-novice-gapminder.git
    $ cd python-novice-gapminder/_episodes
    $ wget https://gist.githubusercontent.com/jeromerobert/3996eca3acd12e4c3d40/raw/c51d688a58e5a1fd583c2df37226a5e632a064c2/pandoc-svg.py
    $ for filename in ??-*.md; do pandoc --pdf-engine=xelatex -o $(basename $filename .md).pdf -f markdown --filter=./pandoc-svg.py $filename; done

or just print the one page version of the HTML.